# frozen_string_literal: true

class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def show
    conn = Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers["Authorization"] = "token #{current_user.github_token}"
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/user/repos?page=1&per_page=5")
    @repos = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
