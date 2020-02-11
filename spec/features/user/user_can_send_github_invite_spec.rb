require 'rails_helper'

RSpec.describe 'user invite page' do
  it 'user can access invite page from dashboard' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)

    click_on('Send an Invite')

    expect(current_path).to eq('/invite')
  end

  it 'user can send an email to a valid github user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(github_invite_path)

    fill_in('Github Handle').with ('rallen20')

    click_on('Send Invitiation')

    expect(current_path).to eq(dashboard_path)
    within('.flash-message') do
      expect(page).to have_content('Successfully sent invite!')
    end

  it 'user can not send an email to an invalid github user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(github_invite_path)

    fill_in('Github Handle').with ('XXrallen20XX')

    click_on('Send Invitiation')

    expect(current_path).to eq(dashboard_path)
    within('.flash-message') do
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
