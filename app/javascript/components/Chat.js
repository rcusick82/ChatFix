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
      watsonData: props.watsonData,
      conversation_id: props.watsonData.context.conversation_id
    }
    this.sendMessage = this.sendMessage.bind(this)
  }

  sendMessage(input) {
    console.log('test start', input)
    input.conversation_id = this.state.conversation_id
    input.system = this.state.system
    console.log('test added', input)
    input = JSON.stringify(input)

    $.post("/conversations/add_message", {
      //  "context": {
      //     "conversation_id": "d85538fc-6c32-475a-b289-91ccd7fccc02",
      //     "system": {
      //         "dialog_stack": [
      //             "root"
      //         ],
      //         "dialog_turn_counter": 1,
      //         "dialog_request_counter": 1
      //     }
      // }

      input
    }, response => {
      // here,
      // you want setState and update the chatItems
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
