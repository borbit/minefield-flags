# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  onColorSet: ->
    @props.onColorSet @refs.color.getDOMNode().value

  render: ->
    <div className="toolbar">
      <input type="color" onChange={@onColorSet} value={@props.color} ref="color" />
    </div>