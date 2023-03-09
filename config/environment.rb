# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Rails.application.configure do
#   config.action_mailer.delivery_method = :smtp
#   config.action_mailer.smtp_settings = {
#     address: "smtp.gmail.com",
#     port: 587,
#     domain: "gmail.com",
#     authentication: "plain",
#     user_name: "dave",
#     password: "secret", enable_starttls_auto: true
#   }

  ActionMailer::Base.smtp_settings = {
  user_name: 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
  password: Rails.application.credentials[:sendgrid][:apikey], # This is the secret sendgrid API key which was issued during API key creation
  domain: 'localhost:3000',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true,
}

# end
