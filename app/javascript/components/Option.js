import React from "react"
import PropTypes from "prop-types"

class Option extends React.Component {
  render() {
    return <div className="watson-options d-inline-block">{this.props.option.label}</div>
  }
}

Option.propTypes = {
  text: PropTypes.string
};

export default Option
