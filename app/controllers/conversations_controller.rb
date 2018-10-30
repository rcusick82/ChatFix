class ConversationsController < ApplicationController

  def new
    assistant = IBMWatson::AssistantV1.new(
      username: ENV["WATSON_USERNAME"],
      password: ENV["WATSON_PASSWORD"],
      version: ENV["WATSON_VERSION"]
    )

    @response = assistant.message(
      workspace_id: "db296f7b-b013-4e37-a401-4556b04d438b",
      input: {
        "text" => ""
      }
    ).result
    redirect_to conversation_path(id: @response["context"]["conversation_id"])
  end

  def show
    #code
    @conversation_id = params[:id]
  end

  def add_message
    assistant = IBMWatson::AssistantV1.new(
      username: ENV["WATSON_USERNAME"],
      password: ENV["WATSON_PASSWORD"],
      version: ENV["WATSON_VERSION"]
    )

    @response = assistant.message(
      workspace_id: "db296f7b-b013-4e37-a401-4556b04d438b",
      input: {
        "text" => params[:input]
      },
      context: {
        "conversation_id": params[:id]
      }
    ).result

    formatted_response = {
      title: response_title(@response),
      options: response_options(@response)
    }



    respond_to do |format|
      format.json { render json: formatted_response }
    end
  end

  private

  def response_options(response)
    labels = response["output"]["generic"].map do |g|
      g["options"].map do |x|
        x["label"]
      end
    end

    labels.flatten
  end

  def response_title(response)
    response["output"]["generic"].map do |t|
      t["title"]
    end
  end
end
