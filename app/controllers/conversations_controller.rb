class ConversationsController < ApplicationController
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

  def response_options(response)
    labels = response['output']['generic'].map do |g|
      g['options'].map do |x|
        x['label']
      end
    end

    labels.flatten
  end

  def response_title(response)
    response['output']['generic'].map do |t|
      t['title']
    end
  end
end
