class ConversationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:receive]
  def generate_sms
    dialog = JSON.parse(params[:chat_items]).compact
    numbers = Location.find_by_zip_code(params[:zip_code]).users.pluck(:phone_number)
    byebug
    broadcast_to_plumbers(numbers, dialog)
    requestor = Requestor.find_or_create_by(phone_number: params[:phone_number])
    service_request = ServiceRequest.new
    service_request.requestor = requestor
    service_request.users = Location.find_by_zip_code(params[:zip_code]).users
    service_request.save

    redirect_to json: { success: true }
  end

  def receive
    if params['Body'].include?('cfx')
      capture = params['Body'].scan(/cfx(\d+)/)
      user = User.find_by_id(capture[0][0])

      client = Requestor.find_by_phone_number(params['From'].delete('+'))
      send_company_name_to_client(client.phone_number, user.company_name)

      send_client_phone_number_to_user(user.phone_number, client.phone_number)

    else
      vendor = User.find_by_phone_number(params['From'].delete('+'))
      to = vendor.service_requests.last.requestor
      twilio_sms_proxy(to.phone_number, params['Body'], vendor.id.to_s)
    end
  end

  def new
    assistant = IBMWatson::AssistantV1.new(
      username: ENV['WATSON_USERNAME'],
      password: ENV['WATSON_PASSWORD'],
      version: ENV['WATSON_VERSION']
    )

    @response = assistant.message(
      workspace_id: 'db296f7b-b013-4e37-a401-4556b04d438b',
      input: {
        'text' => ''
      }
    ).result

    @conversation_id = @response['context']['conversation_id']
    @system = @response['context']['system']
    @context = @response['context']

    @welcome_text = @response['output']['generic'][0]['text']
    @welcome_title = @response['output']['generic'][1]['title']
    @welcome_options = @response['output']['generic'][1]['options'].map do |o|
      o['label']
    end
  end

  def add_message
    assistant = IBMWatson::AssistantV1.new(
      username: ENV['WATSON_USERNAME'],
      password: ENV['WATSON_PASSWORD'],
      version: ENV['WATSON_VERSION']
    )

    data_for_watson = {
      workspace_id: 'db296f7b-b013-4e37-a401-4556b04d438b',
      input: params[:input],
      context: params[:context]
    }
    data_for_watson[:context][:system][:dialog_stack] = data_for_watson[:context][:system][:dialog_stack].values

    @response = assistant.message(
      data_for_watson
    ).result

    respond_to do |format|
      format.json { render json: @response }
    end
  end

  private

  def broadcast_to_plumbers(numbers, dialog)
    client = Twilio::REST::Client.new
    numbers.each do |number|
      client.messages.create(
        from: Rails.application.credentials.twilio[:number],
        to: number,
        body: 'Hey Plumber! 🚽 Can you help with this issue?' + dialog.join("\n") + ' Please respond  with available times and minimum service fees'
      )
    end
  end

  def twilio_sms_proxy(number, body, acceptance_code)
    client = Twilio::REST::Client.new
    client.messages.create(
      from: Rails.application.credentials.twilio[:number],
      to: number,
      body: 'Please respond with the following code to accept this vendor: cfx' + acceptance_code + " \n" + body
    )
  end

  def send_company_name_to_client(number, company)
    client = Twilio::REST::Client.new
    client.messages.create(
      from: Rails.application.credentials.twilio[:number],
      to: number,
      body: 'Thank you for choosing ' + company + '. You will be contacted shortly by a member of their staff to further assist you.  Thank you for using ChatFix!'
    )
  end

  def send_client_phone_number_to_user(number, client_phone)
    client = Twilio::REST::Client.new
    client.messages.create(
      from: Rails.application.credentials.twilio[:number],
      to: number,
      body: 'Please contact client at ' + client_phone + ' within 30 minutes to schedule appointment'
    )
  end
end
