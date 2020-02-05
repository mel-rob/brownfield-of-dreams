require 'rails_helper'

RSpec.describe 'user dashboard page' do
  scenario 'user can see 5 of their github repos' do
    # WebMock.enable_net_connect!
    #   VCR.eject_cassette
    #   VCR.turn_off!(ignore_cassettes: true)

    json_response = File.read('spec/fixtures/users_5_github_repos.json')
    stub_request(:get, 'https://api.github.com/user/repos?page=1&per_page=5').
    to_return(status: 200, body: json_response)

    user = create(:user, github_token: '38cc530ff45301e738924d4d94a94166a34016aa')

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('GitHub Repositories')

    expect(page).to have_css('.repos', count: 5)
    save_and_open_page

    within(first('.repos')) do
      expect(page).to have_link('adopt_dont_shop_paired', href: 'https://github.com/DanielEFrampton/adopt_dont_shop_paired')
    end
  end
end
