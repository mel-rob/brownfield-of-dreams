class ActivationNotifierMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: 'Please activate your account.')
  end
end
