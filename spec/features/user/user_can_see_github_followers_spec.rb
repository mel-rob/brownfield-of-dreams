require 'rails_helper'

RSpec.describe 'user dashboard page' do
  scenario 'user can see all of their github followers' do
    json_response = File.read('spec/fixtures/users_github_followers.json')
    stub_request(:get, 'https://api.github.com/user/followers').
    to_return(status: 200, body: json_response)

    user = create(:user, github_token: ENV['AUTHORIZATION'])

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('GitHub')

    within('.github') do
      expect(page).to have_content('Followers')
      expect(page).to have_css('.followers', count: 5)
    end

    within(first('.followers')) do
      expect(page).to have_link('mel-rob', href: "https://github.com/mel-rob")
    end
  end
end
