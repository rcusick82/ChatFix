require 'twilio-ruby'

account_sid = Rails.application.credentials.dig(:twilio, :account_sid)
auth_token = Rails.application.credentials.dig(:twilio, :auth_token)

TwilioClient = Twilio::REST::Client.new account_sid, auth_token
 
