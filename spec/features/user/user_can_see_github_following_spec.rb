require 'rails_helper'

RSpec.describe 'user dashboard page' do
  scenario 'user can see all of their github followers', :vcr do
    user = create(:user, github_token: ENV['AUTHORIZATION'])

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('GitHub')

    within('.github') do
      expect(page).to have_content('Following')
      expect(page).to have_css('.following', count: 2)
    end

    within(first('.following')) do
      expect(page).to have_link('mel-rob', href: "https://github.com/mel-rob")
    end
  end
end
