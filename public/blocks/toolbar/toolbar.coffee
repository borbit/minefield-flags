# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  onColorSet: ->
    @props.onColorSet @refs.color.getDOMNode().value

  render: ->
    <div className="toolbar">
      <b className="toolbar__tool toolbar__tool_pen"></b>
      <b className="toolbar__tool toolbar__tool_eraser"></b>
      <b className="toolbar__tool toolbar__tool_color"></b>
      <b className="toolbar__tool toolbar__tool_submit"></b>
    </div>

###
<input className="toolbar__tool toolbar__tool_color" type="color"
  onChange={@onColorSet}
  value={@props.color}
  ref="color"
/>
###