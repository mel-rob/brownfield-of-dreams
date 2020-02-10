# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@brownfield-of-dreams-ra-mr.herokuapp.com'
  layout 'mailer'
end
