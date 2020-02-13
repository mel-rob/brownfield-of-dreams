require 'rails_helper'

RSpec.describe 'user dashboard page' do
  scenario 'user can see 5 of their github repos', :vcr do
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within('.github') do
      expect(page).to have_content('GitHub')
      expect(page).to have_content('Repositories')
      expect(page).to have_css('.repos')
      expect(page).to have_css('.repo', count: 5)
    end

    within(first('.repo')) do
      expect(page).to have_link('adopt_dont_shop_paired', href: 'https://github.com/DanielEFrampton/adopt_dont_shop_paired')
    end
  end
end
