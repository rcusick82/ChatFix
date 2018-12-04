import React from "react"
import PropTypes from "prop-types"
class ChatForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      inputText: ''
    }

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleKeyDown = this.handleKeyDown.bind(this);
  }

  handleSubmit() {
    this.props.sendMessage({text: this.state.inputText})
    this.setState({inputText: ""})
  }

  handleKeyDown(e) {
    if (e.keyCode === 13) {
      this.handleSubmit()
    }
  }

  render() {
    return (<div className="clearfix chat-input">
      <input className="input-text-field" type="text" value={this.state.inputText} onKeyDown={this.handleKeyDown} onChange={(event) => {
          this.setState({inputText: event.target.value})
        }}/> {/* <div class="input-group input-group-lg">
        <div class="input-group-prepend">
          <span class="input-group-text" id="inputGroup-sizing-lg">Large</span>
        </div>
        <input type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
      </div> */
      }

      <input type="submit" className="btn btn-primary" onClick={this.handleSubmit}/>
    </div>);
  }
}

export default ChatForm
