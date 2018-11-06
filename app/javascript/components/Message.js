import React from "react"
import PropTypes from "prop-types"
import Option from './Option'

class Messages extends React.Component {
  render() {
    let options

    if (this.props.watsonData.output.generic[1]) {
      options = this.props.watsonData.output.generic[1].options.map((option, index) => <Option key={index} option={option}/>)
    } else {
      options = this.props.watsonData.output.generic[0].options.map((option, index) => <Option key={index} option={option}/>)
    }
    return (<div>
      {
        this.props.watsonData.output.generic[1]
          ? <div>
              <p>{this.props.watsonData.output.generic[0].text}</p>
              <p>{this.props.watsonData.output.generic[1].title}</p>
              {options}
            </div>
          : <div>
              <p>{this.props.watsonData.output.generic[0].title}</p>{options}</div>
      }

    </div>)
  }
}

Messages.propTypes = {
  text: PropTypes.string
};
export default Messages
