require "rails_helper"

RSpec.describe ActivationNotifierMailer, type: :mailer do
  describe "instructions" do
    it "renders the correct email data" do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)
      mail = ActivationNotifierMailer.inform(user).deliver_now
      expect(mail.subject).to eq("Please activate your account.")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['no-reply@brownfield-of-dreams-ra-mr.herokuapp.com'])
      expect(mail.body.encoded).to match("http://localhost:3000/email_confirmation/#{user.id}")
    end
  end
end
