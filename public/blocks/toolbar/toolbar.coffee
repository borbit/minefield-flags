# @cjsx React.DOM 
React = require 'react'
cs = React.addons.classSet

module.exports = React.createClass
  onColorSet: ->
    @props.onColorSet @refs.color.getDOMNode().value

  onToolChange: (e) ->
    @props.onToolSet e.currentTarget.value

  onColorClick: ->
    e = document.createEvent 'Events'
    e.initEvent 'click', yes, no
    @refs.color.getDOMNode().dispatchEvent e

  onSubmitClick: ->
    unless @props.submiting
      @props.onSubmit()

  render: ->
    tools = []
    
    ['pen', 'eraser'].forEach (tool) =>
      attrId = "tool_#{tool}"
      attrClass = "toolbar__tool toolbar__tool_#{tool}"
      attrChecked = @props.tool == tool

      tools.push <input type="radio" name="tool" onChange={@onToolChange} value={tool} id={attrId} checked={attrChecked} />
      tools.push <label className={attrClass} htmlFor={attrId}></label>

    toolColorClass = cs
      'toolbar__tool': yes
      'toolbar__tool_color': yes

    toolSubmitClass = cs
      'toolbar__tool': yes
      'toolbar__tool_submit': yes
      'toolbar__tool_submiting': @props.submiting

    <div className="toolbar">
      {tools}
      <b className={toolColorClass} style={background: @props.color} onClick={@onColorClick}></b>
      <b className={toolSubmitClass} onClick={@onSubmitClick}></b>
      <input type="color"
        onChange={@onColorSet}
        value={@props.color}
        ref="color"
      />
    </div>