# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  componentDidMount: ->
    @ctx = @getDOMNode().getContext '2d'
    @drawGrid()

  onClick: (event) ->
    console.log @ctx

  render: ->
    <canvas className="canvas"
      width={@props.width}
      height={@props.height}
      onClick={@onClick}>
    </canvas>

  drawGrid: ->
    @ctx.beginPath()
    @ctx.lineWidth = 1
    @ctx.strokeStyle = '#eee'

    xInterval = ~~(@props.width / @props.size)
    yInterval = ~~(@props.height / @props.size)

    for x in [1..@props.size]
      @ctx.moveTo (x * xInterval) + 0.5, 0
      @ctx.lineTo (x * xInterval) + 0.5, @props.height
      @ctx.stroke()

    for y in [1..@props.size]
      @ctx.moveTo 0,            (y * yInterval) + 0.5
      @ctx.lineTo @props.height,(y * yInterval) + 0.5
      @ctx.stroke()