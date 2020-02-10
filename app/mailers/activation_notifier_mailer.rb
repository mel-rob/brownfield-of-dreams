class ActivationNotifierMailer < ApplicationMailer
  def inform(user, email)
    @user = user
    mail(to: email, subject: "Please activate your account.")
  end
end
