require 'rails_helper'

RSpec.describe 'user dashboard page' do
  scenario 'user can see all of their github followers', :vcr do
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('GitHub')

    within('.github') do
      expect(page).to have_content('Followers')
      expect(page).to have_css('.followers', count: 2)
    end

    within(first('.followers')) do
      expect(page).to have_link('sasloan', href: "https://github.com/sasloan")
    end
  end
end
