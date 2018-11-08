import React from "react"
import PropTypes from "prop-types"
class ChatForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      inputText: ''
    }

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit() {
    this.props.sendMessage({text: this.state.inputText})
  }

  render() {
    return (<div>
      <input type="text" value={this.state.inputText} onChange={(event) => {
          this.setState({inputText: event.target.value})
        }}/>
      <input type="submit" className="btn btn-primary" onClick={this.handleSubmit}/>
    </div>);
  }
}

export default ChatForm
