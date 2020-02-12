class ActivationNotifierMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: 'Please activate your account.')
  end

  def invite_github_user(user_github_username, to_email_address, to_github_username)
    @users = {
      to: to_github_username,
      from: user_github_username
    }
    mail(to: to_email_address, subject: 'Brownfield-of-Dreams Invitation.')
  end
end
