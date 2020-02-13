require 'rails_helper'

RSpec.describe GithubUser do
  describe 'existance' do
    it 'exists' do
      attrs = {
        login: 'mel-rob',
        html_url: 'https://github.com/mel-rob'
      }

      github_user = GithubUser.new(attrs)

      expect(github_user).to be_a GithubUser
      expect(github_user.login).to eq('mel-rob')
      expect(github_user.html_url).to eq('https://github.com/mel-rob')
    end
  end


  describe 'instance methods' do
    # happy
    it 'friendable? if user exists and is not already friended' do
      current_user = create(:user, github_username: 'rallen')
      user = GithubUser.new(login: 'mel-rob', html_url: 'https://github.com/mel-rob')

      non_friend = create(:user, github_username: 'mel-rob')
      friend_2 = create(:user, github_username: 'sasloan')
      friend_3 = create(:user, github_username: 'not-sasloan')

      current_user.friends << [friend_2, friend_3]

      expect(user.friendable?(current_user)).to eq(true)
    end
    # sad
    it 'not friendable? if user does not exist' do
      current_user = create(:user, github_username: 'rallen')
      user = GithubUser.new(login: 'mel-rob', html_url: 'https://github.com/mel-rob')

      friend_2 = create(:user, github_username: 'sasloan')
      friend_3 = create(:user, github_username: 'not-sasloan')

      current_user.friends << [friend_2, friend_3]

      expect(user.friendable?(current_user)).to eq(false)
    end
    # sad
    it 'not friendable? if user is already friended' do
      current_user = create(:user, github_username: 'rallen')
      user = GithubUser.new(login: 'mel-rob', html_url: 'https://github.com/mel-rob')

      friend_2 = create(:user, github_username: 'mel-rob')
      friend_3 = create(:user, github_username: 'not-sasloan')

      current_user.friends << [friend_2, friend_3]

      expect(user.friendable?(current_user)).to eq(false)
    end
  end
end
