require 'sendgrid-ruby'
include SendGrid

from = SendGrid::Email.new(email: 'gauravpal@blubirch.com')
to = SendGrid::Email.new(email: 'akashgupta@blubirch.com')
subject = 'Sending with Twilio SendGrid is Fun'
content = SendGrid::Content.new(type: 'text/plain', value: 'gg ho gai akash')
mail = SendGrid::Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: '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' )
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers