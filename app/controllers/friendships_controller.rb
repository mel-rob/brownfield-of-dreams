class FriendshipsController < ApplicationController

  def create
    friend = User.find_by(github_username: params['login'])
    current_user.friends << friend
    redirect_to dashboard_path
  end
end
