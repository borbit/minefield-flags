# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  onColorSet: ->
    @props.onColorSet @refs.color.getDOMNode().value

  onToolChange: (e) ->
    @props.onToolSet e.currentTarget.value

  onColorClick: ->
    e = document.createEvent 'Events'
    e.initEvent 'click', yes, no
    @refs.color.getDOMNode().dispatchEvent e

  render: ->
    tools = []
    
    ['pen', 'eraser'].forEach (tool) =>
      attrId = "tool_#{tool}"
      attrClass = "toolbar__tool toolbar__tool_#{tool}"
      attrChecked = @props.tool == tool

      tools.push <input type="radio" name="tool" onChange={@onToolChange} value={tool} id={attrId} checked={attrChecked} />
      tools.push <label className={attrClass} htmlFor={attrId}></label>

    <div className="toolbar">
      {tools}
      <b className="toolbar__tool toolbar__tool_color" style={background: @props.color} onClick={@onColorClick}></b>
      <b className="toolbar__tool toolbar__tool_submit"></b>
      <input type="color"
        onChange={@onColorSet}
        value={@props.color}
        ref="color"
      />
    </div>

###
<input className="toolbar__tool toolbar__tool_color" type="color"
  onChange={@onColorSet}
  value={@props.color}
  ref="color"
/>
###