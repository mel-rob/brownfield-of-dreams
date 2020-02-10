# frozen_string_literal: true

class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      send_activation_email(user)
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_to register_path
    end
  end

  def show
    render locals: {
      search_results: GithubSearchFacade.new(current_user.github_token)
    }
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
  
  def send_activation_email(user)
    ActivationNotifierMailer.inform(user).deliver_now
  end
end
