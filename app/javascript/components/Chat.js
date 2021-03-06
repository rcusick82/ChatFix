import React from "react"
import PropTypes from "prop-types"
import ChatForm from "./ChatForm"
import Message from "./Message"
class Chat extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      chatItems: ["What room has the plumbing issue?"],
      watsonData: props.watsonData,
      watsonDataLog: [props.watsonData]
    }
    this.sendMessage = this.sendMessage.bind(this)
  }
  launchModal() {
    $('#twilioModal').modal()
  }

  loadUserInfo(input) {
    let userInput = {
      phone_number: input,
      zip_code: input
    }
    $.post("/conversations/generate_message", userInput, response => {

      console.log('WHAT', response);
    })

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

      if (dialog_node.startsWith("node") && input.text == "yes") {
        $('#chat_items').val(JSON.stringify(this.state.chatItems))
        this.launchModal()
      }

      console.log('node', dialog_node)
      console.log('response', response)
      this.setState({watsonData: response})
      this.setState({
        watsonDataLog: [
          ...this.state.watsonDataLog,
          this.state.watsonData.input.text,
          response
        ]
      })
      this.state.chatItems.push(this.state.watsonData.input.text, this.state.watsonData.output.generic[0].title)
    })

  }

  componentDidMount() {
    $('.last-item').addClass('active')
  }

  componentDidUpdate() {
    setTimeout(function() {
      $('.last-item').addClass('active')
    }, 600)
    var objDiv = document.getElementById("conversation-container");
    objDiv.scrollTop = 9000;
  }

  render() {
    console.log('this is what watson is', this.state.watsonData)
    console.log('chatItems', this.state.chatItems)

    return (<div className="relative">
      <div className="conversation-container clearfix" id="conversation-container">
        {
          this.state.watsonDataLog.map((item, index) => {
            return (
              typeof item == "string"
              ? <div className="speech-bubble user-speech-bubble clearfix">{item}</div>
              : <Message key={index} watsonData={item} isLast={this.state.watsonDataLog.length - 1 === index}/>)
          })
        }
      </div>
      <ChatForm sendMessage={this.sendMessage}/>
    </div>);
  }
}

export default Chat
