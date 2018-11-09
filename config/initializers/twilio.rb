require 'twilio-ruby'

account_sid = Rails.application.credentials.dig(:twilio, :account_sid)
auth_token = Rails.application.credentials.dig(:twilio, :auth_token)

Twilio.configure do |config|
  config.account_sid = account_sid
  config.auth_token = auth_token
end
