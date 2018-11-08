import React from "react"
import PropTypes from "prop-types"
import ChatForm from "./ChatForm"
import Message from "./Message"
class Chat extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      chatItems: [],
      watsonData: props.watsonData
    }
    this.sendMessage = this.sendMessage.bind(this)
  }
  launchModal() {
    $('#twilioModal').modal()
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

      let dialog_node = this.state.watsonData.context.system.dialog_stack[0].dialog_node

      if (dialog_node.startsWith("node_6") && input.text == "yes") 
        this.launchModal()

      console.log('node', dialog_node)
      console.log('response', response)
      this.setState({watsonData: response})
      this.state.chatItems.push(this.state.watsonData.input.text, this.state.watsonData.output.generic[0].title)

    })

  }

  render() {
    console.log('this is what watson is', this.state.watsonData)
    console.log('chatItems', this.state.chatItems)

    let chatItems = this.state.chatItems.map((item, index) => {
      return (<div key={index}>{item}</div>)
    })
    return (<div>
      <Message watsonData={this.state.watsonData}/>
      <ChatForm sendMessage={this.sendMessage}/>{chatItems}
    </div>);
  }
}

export default Chat
