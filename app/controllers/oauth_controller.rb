class OauthController < ApplicationController

  def create
    current_user.update(github_token: token)
    redirect_to dashboard_path
  end

private

  def token
    request.env['omniauth.auth']['credentials']['token']
  end
end
