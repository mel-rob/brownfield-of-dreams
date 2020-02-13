# frozen_string_literal: true

class FriendshipsController < ApplicationController

  def create
    friend = User.find_by(github_username: params['login'])
    if !current_user
      flash[:error] = 'User must login to add friends'
      redirect_to login_path
    elsif friend
      current_user.friends << friend
      redirect_to dashboard_path
    else
      flash[:error] = 'Github User does not exist in our system.'
      redirect_to dashboard_path
    end
  end
end
