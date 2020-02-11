require 'rails_helper'

RSpec.describe 'user invite page' do
  it 'user with valid github connnection can access invite page from dashboard', :vcr do
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)

    click_on('Send an Invite')

    expect(current_path).to eq('/invite')
  end

  it 'user within invalid connection cannot access invite page from dashboard', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)

    expect(page).not_to have_content('Send an Invite')
  end

  it 'user can send an email to a valid github user', :vcr do
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(github_invite_path)

    fill_in 'Github Handle', with: 'rallen20'

    click_on('Send Invitiation')

    expect(current_path).to eq(dashboard_path)
    within('.flash-message') do
      expect(page).to have_content('Successfully sent invite!')
    end
  end

  it 'user can not send an email to an invalid github user', :vcr do
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(github_invite_path)

    fill_in 'Github Handle', with: 'mel-rob'

    click_on('Send Invitiation')

    expect(current_path).to eq(dashboard_path)
    within('.flash-message') do
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
