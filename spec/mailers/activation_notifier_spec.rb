require "rails_helper"

RSpec.describe ActivationNotifierMailer, type: :mailer do
  describe "instructions" do
    it "renders the correct email data for inform template" do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)
      mail = ActivationNotifierMailer.inform(user).deliver
      expect(mail.subject).to eq("Please activate your account.")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['no-reply@brownfield-of-dreams-ra-mr.herokuapp.com'])
      expect(mail.body.encoded).to match("http://localhost:3000/email_confirmation/#{user.id}")
    end

    it "renders the correct email data for invite github user template" do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, github_username: 'jim123')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      to_github_username = 'rallen20'
      to_github_username_email = 'ryan_test@email.com'
      mail = ActivationNotifierMailer.invite_github_user(user.github_username, to_github_username_email, to_github_username).deliver
      expect(mail.subject).to eq("Brownfield-of-Dreams Invitation.")
      expect(mail.to).to eq([to_github_username_email])
      expect(mail.from).to eq(['no-reply@brownfield-of-dreams-ra-mr.herokuapp.com'])
      expect(mail.body.encoded).to match("Hello #{to_github_username}")
      expect(mail.body.encoded).to match("#{user.github_username} has invited you to join Brownfield-of-Dreams")
      # how it shows in html
      expect(mail.body.encoded).to match('You can create an account <a href="http://localhost:3000/sign_up">&lt;here&gt;</a>.')
    end
  end
end
