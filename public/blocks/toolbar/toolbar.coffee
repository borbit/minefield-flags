# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  onColorSet: ->
    @props.onColorSet @refs.color.getDOMNode().value

  render: ->
    <div className="toolbar">
      <button className="toolbar__tool toolbar__tool_pen">Pen</button>
      <button className="toolbar__tool toolbar__tool_eraser">Eraser</button>
      <input className="toolbar__tool toolbar__tool_color" type="color"
        onChange={@onColorSet}
        value={@props.color}
        ref="color"
      />
    </div>