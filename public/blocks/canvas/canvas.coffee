# @cjsx React.DOM 
React = require 'react'

previewCellSize = 32
previewCellsMap = [
  [1, 1], [2, 1], [1, 2], [0, 3], [2, 3], [0, 6]
  [1, 9], [2, 9], [0, 11], [1, 13], [0, 15], [1, 15]
]

module.exports = React.createClass
  componentDidMount: ->
    @canvas = @refs.canvas.getDOMNode()
    @preview = @refs.preview.getDOMNode()

    @cellW = ~~(@props.width / @props.size)
    @cellH = ~~(@props.height / @props.size)

    @ctxc = @canvas.getContext '2d'
    @ctxp = @preview.getContext '2d'
    @mousePressed = no
    @drawGrid()

  onClick: (e) ->
    @drawCell e

  onMouseMove: (e) ->
    @drawCell(e) if @mousePressed

  onMouseDown: ->
    @mousePressed = yes

  onMouseUp: ->
    @mousePressed = no

  drawCell: (e) ->
    @offsetL = @canvas.offsetLeft
    @offsetT = @canvas.offsetTop

    cellX = ~~((e.pageX - @offsetL) / @cellW)
    cellY = ~~((e.pageY - @offsetT) / @cellH)
    
    @ctxp.fillStyle = @props.color
    @ctxc.fillStyle = @props.color
    @ctxc.fillRect cellX * @cellW, cellY * @cellH, @cellW, @cellH
    
    previewCellsMap.forEach (coords) =>
      x = (coords[0] * previewCellSize) + cellX * 2
      y = (coords[1] * previewCellSize) + cellY * 2
      @ctxp.fillRect x, y, 2, 2

  render: ->
    <div className="canvas">
      <canvas ref="preview" className="canvas__preview" width=546 height=546 />
      <canvas ref="canvas" className="canvas__canvas"
        width={@props.width}
        height={@props.height}
        onMouseMove={@onMouseMove}
        onMouseDown={@onMouseDown}
        onMouseUp={@onMouseUp}
        onClick={@onClick}>
      </canvas>
    </div>

  drawGrid: ->
    @ctxc.beginPath()
    @ctxc.lineWidth = 2
    @ctxc.strokeStyle = '#333'

    for x in [0..@props.size]
      @ctxc.moveTo (x * @cellW) + 0, 0
      @ctxc.lineTo (x * @cellW) + 0, @props.height
      @ctxc.stroke()

    for y in [0..@props.size]
      @ctxc.moveTo 0,            (y * @cellH) + 0
      @ctxc.lineTo @props.height,(y * @cellH) + 0
      @ctxc.stroke()