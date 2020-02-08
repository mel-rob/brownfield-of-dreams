class OauthController < ApplicationController
  def create
    user = User.find(current_user.id)
    user.update(github_token: omni_authorize[:credentials][:token])
    redirect_to dashboard_path
  end

  private

  def omni_authorize
    request.env["omniauth.auth"]
  end
end
