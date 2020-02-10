require 'rails_helper'

RSpec.describe 'As a user when I am on my dashboard' do
  it 'I can authorize my account with github', :vcr do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :credentials => {:token => ENV['GITHUB_ACCESS_TOKEN']}, :info => {:nickname => 'rallen20'}
      })

    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    expect(page).not_to have_css('.repos')
    expect(page).not_to have_css('.followers')
    expect(page).not_to have_css('.following')

    click_link 'Connect to GitHub'

    expect(@user.github_token).to eq(ENV['GITHUB_ACCESS_TOKEN'])
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css('.repos')
    expect(page).to have_css('.followers')
    expect(page).to have_css('.following')
  end
end
