class GithubInviteController < ApplicationController
  def new
  end

  def create
    service = GithubService.new(current_user.github_token)
    to_email_address = service.email_by_username(params['github_username'])
    if to_email_address 
      # ActivationNotifierMailer.invite_github_user(@user).deliver
      flash[:notice] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to(dashboard_path)
  end
end
