# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  componentDidMount: ->
    canvas = @getDOMNode()

    @cellW = ~~(@props.width / @props.size)
    @cellH = ~~(@props.height / @props.size)
    @offsetL = canvas.offsetLeft
    @offsetT = canvas.offsetTop

    @mousePressed = no
    @ctx = canvas.getContext '2d'
    @drawGrid()

  onClick: (event) ->
    cellX = ~~((event.pageX - @offsetL) / @cellW)
    cellY = ~~((event.pageY - @offsetT) / @cellH)
    
    @ctx.fillStyle = @props.color
    @ctx.fillRect cellX * @cellW, cellY * @cellH, @cellW, @cellH

  onMouseDown: ->
    @mousePressed = yes

  onMouseUp: ->
    @mousePressed = no

  onMouseMove: (e) ->
    if @mousePressed
      cellX = ~~((event.pageX - @offsetL) / @cellW)
      cellY = ~~((event.pageY - @offsetT) / @cellH)
      
      @ctx.fillStyle = @props.color
      @ctx.fillRect cellX * @cellW, cellY * @cellH, @cellW, @cellH

  render: ->
    <canvas className="canvas"
      width={@props.width}
      height={@props.height}
      onMouseMove={@onMouseMove}
      onMouseDown={@onMouseDown}
      onMouseUp={@onMouseUp}
      onClick={@onClick}>
    </canvas>

  drawGrid: ->
    @ctx.beginPath()
    @ctx.lineWidth = 2
    @ctx.strokeStyle = '#aaa'

    for x in [0..@props.size]
      @ctx.moveTo (x * @cellW) + 0, 0
      @ctx.lineTo (x * @cellW) + 0, @props.height
      @ctx.stroke()

    for y in [0..@props.size]
      @ctx.moveTo 0,            (y * @cellH) + 0
      @ctx.lineTo @props.height,(y * @cellH) + 0
      @ctx.stroke()