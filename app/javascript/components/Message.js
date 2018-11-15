import React from "react"
import PropTypes from "prop-types"
import Option from './Option'

class Messages extends React.Component {
  render() {
    let generic = this.props.watsonData.output.generic
    let options

    if (generic.length > 1) {
      options = generic[1].options.map((option, index) => <Option key={index} option={option}/>)
    } else if (generic.length > 0 && generic[0].response_type == "option") {
      options = generic[0].options.map((option, index) => <Option key={index} option={option}/>)
    }
    return (<div className="speech-bubble clearfix">
      {
        this.props.watsonData.output.generic[1]
          ? <div>
              <h2 className="welcome-text">{this.props.watsonData.output.generic[0].text}</h2>
              <h3 className="watson-question">{this.props.watsonData.output.generic[1].title}</h3>
              {options}
            </div>
          : <div>

              <h3 className="watson-question">{this.props.watsonData.output.generic[0].title}</h3>{options}
            </div>
      }

    </div>)
  }
}

Messages.propTypes = {
  text: PropTypes.string
};
export default Messages
