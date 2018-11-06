import React from "react"
import PropTypes from "prop-types"
import ChatForm from "./ChatForm"
import Message from "./Message"
class Chat extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      chatItems: [
        "test1", "this is a dumb test"
      ],
      watsonData: props.watsonData
    }
    this.sendMessage = this.sendMessage.bind(this)
  }

  sendMessage(input) {
    let payload = {
      input: input,
      context: {
        conversation_id: this.state.watsonData.context.conversation_id,
        system: this.state.watsonData.context.system
      }
    }

    $.post("/conversations/add_message", payload, response => {

      console.log('response', response)
      this.setState({watsonData: response})

    })

  }

  render() {
    console.log('this is what watson is', this.state.watsonData)

    return (<div>
      <Message watsonData={this.state.watsonData}/>
      <ChatForm sendMessage={this.sendMessage}/>

    </div>);
  }
}

export default Chat
