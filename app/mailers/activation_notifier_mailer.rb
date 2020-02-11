class ActivationNotifierMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: 'Please activate your account.')
  end

  def invite_github_user(to_email_address, github_username)
    @github_username = github_username
    mail(to: to_email_address, subject: 'Brownfield-of-Dreams Invitation')
  end
end
