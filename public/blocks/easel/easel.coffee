# @cjsx React.DOM 
React = require 'react'
Canvas = require '../canvas/canvas'
Toolbar = require '../toolbar/toolbar'

module.exports = React.createClass
  getInitialState: ->
    color: '#ffa500'
    tool: 'pen'

  onColorSet: (color) ->
    @setState color: color
  
  onToolSet: (tool) ->
    @setState tool: tool

  onSubmit: ->
    @props.onSubmit @refs.canvas.flag
  
  render: ->
    <div className="easel">
      <div className="easel__canvas">
        <Canvas
          tool={@state.tool}
          color={@state.color}
          width={@props.width}
          height={@props.height}
          flag={@props.flag}
          size={@props.size}
          ref="canvas"
        />
      </div>
      <div className="easel__toolbar">
        <Toolbar
          tool={@state.tool}
          color={@state.color}
          submiting={@props.submiting}
          onColorSet={@onColorSet}
          onToolSet={@onToolSet}
          onSubmit={@onSubmit}
        />
      </div>
    </div>