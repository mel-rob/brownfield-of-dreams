require 'rails_helper'

describe 'adding friends' do
  it 'as a visitor i can not add a friend' do
    visit '/friendships/rallen20'

    within('.flash-message') do
      expect(page).to have_content('User must login to add friends')
    end
  end

  it 'as a visitor i can not add a friend' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/friendships/rallen20'

    within('.flash-message') do
      expect(page).to have_content('Github User does not exist in our system.')
    end
  end
end
