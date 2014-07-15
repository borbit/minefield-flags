# @cjsx React.DOM 
React = require 'react'
Canvas = require '../canvas/canvas'
Toolbar = require '../toolbar/toolbar'

module.exports = React.createClass
  onColorSet: (color) ->
    @setState color: color
  
  onPenSet: ->
    @setState tool: 'pen'
  
  onEraserSet: ->
    @setState tool: 'eraser'

  getInitialState: ->
    color: '#ff0000'
    tool: 'pen'

  render: ->
    <div className="easel">
      <div className="easel__canvas">
        <Canvas
          tool={@state.tool}
          color={@state.color}
          width={@props.width}
          height={@props.height}
          size={@props.size}
        />
      </div>
      <div className="easel__toolbar">
        <Toolbar
          tool={@state.tool}
          color={@state.color}
          onColorSet={@onColorSet}
          onEraserSet={@onEraserSet}
          onPenSet={@onPenSet}
        />
      </div>
    </div>