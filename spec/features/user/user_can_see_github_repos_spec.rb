require 'rails_helper'

RSpec.describe 'user dashboard page' do
  scenario 'user can see 5 of their github repos' do
    # OPTIMIZE: should we be using a vcr?

    json_response = File.read('spec/fixtures/users_5_github_repos.json')
    stub_request(:get, 'https://api.github.com/user/repos?page=1&per_page=5').
    to_return(status: 200, body: json_response)

    user = create(:user, github_token: ENV['AUTHORIZATION'])

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within('.github') do
      expect(page).to have_content('GitHub')
      expect(page).to have_content('Repositories')
    end
    expect(page).to have_css('.repos', count: 5)

    within(first('.repos')) do
      expect(page).to have_link('adopt_dont_shop_paired', href: 'https://github.com/DanielEFrampton/adopt_dont_shop_paired')
    end
  end
end
