# frozen_string_literal: true

class OauthController < ApplicationController
  def create
    current_user.update(github_token: token_retrieval, github_username: username_retrieval)
    redirect_to dashboard_path
  end

  private

  def token_retrieval
    request.env['omniauth.auth']['credentials']['token']
  end

  def username_retrieval
    request.env['omniauth.auth']['info']['nickname']
  end
end
