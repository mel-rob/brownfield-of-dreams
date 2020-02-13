require 'rails_helper'

RSpec.describe 'user dashboard' do
  describe 'user can create friendships' do
    before(:each) do
      @user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'], github_username: 'rallen20')

      @user_2 = create(:user, github_username: 'mel-rob')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'sees a link to add friendships to followers that exist in our database' do
      visit dashboard_path

      expect(page).to have_css('.followers')

      within "#follower-#{@user_2.github_username}" do
        expect(page).to have_link('Add Friend')
      end

      within "#follower-sasloan" do
        expect(page).to_not have_link('Add Friend')
      end
    end

    it 'sees a link to add friendships to followings that exist in our database' do
      visit dashboard_path

      expect(page).to have_css('.followings')

      within "#following-#{@user_2.github_username}" do
        expect(page).to have_link('Add Friend')
      end

      within "#follower-sasloan" do
        expect(page).to_not have_link('Add Friend')
      end
    end

    it 'sees a section of users that I have friended' do
      friend_1 = create(:user, github_username: 'mel-rob')
      friend_2 = create(:user, github_username: 'sasloan')
      non_friend = create(:user, github_username: 'non-friend')

      @user.friends << [friend_1, friend_2]

      visit dashboard_path

      expect(page).to have_content('Friends')

      within '.friends' do
        expect(page).to have_content(friend_1.github_username)
        expect(page).to have_content(friend_2.github_username)
        expect(page).to_not have_content(non_friend.github_username)
      end
    end

    it 'I can friend a user I am following' do
      visit dashboard_path

      within '.friends' do
        expect(page).to_not have_content(@user_2.first_name)
        expect(page).to_not have_content(@user_2.last_name)
        expect(page).to_not have_content(@user_2.github_username)
      end

      within "#following-#{@user_2.github_username}" do
        click_link('Add Friend')
      end

      expect(current_path).to eq(dashboard_path)

      within '.friends' do
        expect(page).to have_content(@user_2.first_name)
        expect(page).to have_content(@user_2.last_name)
        expect(page).to have_content(@user_2.github_username)
      end
    end

    it 'I can friend a user who is following me' do
      visit dashboard_path

      within '.friends' do
        expect(page).to_not have_content(@user_2.first_name)
        expect(page).to_not have_content(@user_2.last_name)
        expect(page).to_not have_content(@user_2.github_username)
      end

      within "#following-#{@user_2.github_username}" do
        click_link('Add Friend')
      end

      expect(current_path).to eq(dashboard_path)

      within '.friends' do
        expect(page).to have_content(@user_2.first_name)
        expect(page).to have_content(@user_2.last_name)
        expect(page).to have_content(@user_2.github_username)
      end
    end
  end
end
