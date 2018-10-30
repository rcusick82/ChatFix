require "ibm_watson/assistant_v1"

class MessagesController < ApplicationController
  def new

  end

  def create
    assistant = IBMWatson::AssistantV1.new(
      username: ENV["WATSON_USERNAME"],
      password: ENV["WATSON_PASSWORD"],
      version: ENV["WATSON_VERSION"]
    )

    @response = assistant.message(
      workspace_id: "db296f7b-b013-4e37-a401-4556b04d438b",
      input: {
        "text" => params[:input]
      }
    ).result

    render "new"
  end
end
