# @cjsx React.DOM 
React = require 'react'

previewCellSize = 32
previewCellsMap = [
  [1, 0],[4, 0],[9, 0],[11, 0],[12, 0],[16, 1],
  [0, 2],[1, 2],[3, 2],[9, 2],[13, 2], [1, 3],[3, 3],
  [7, 3],[9, 3],[12, 3],[16, 3],[4, 4],[8, 4],[14, 4],
  [2, 5],[7, 5],[10, 5],[11, 5],[7, 6],[9, 6],[16, 6],
  [9, 7],[15, 7],[0, 8],[7, 8],[10, 8],[11, 8],[13, 8],
  [16, 8],[1, 9],[4, 9],[13, 9],[3, 10],[9, 10],[12, 10],
  [3, 11],[3, 12],[6, 12],[12, 12],[15, 12],[16, 12],
  [9, 13],[0, 14],[2, 14],[10, 14],[2, 15],[6, 15],
  [4, 16],[9, 16],[15, 16],[16, 16]
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

    document.body.addEventListener 'mousedown', @onMouseDown.bind @
    document.body.addEventListener 'mouseup', @onMouseUp.bind @

  onClick: (e) ->
    switch @props.tool
      when 'pen'
        @drawCell e
      when 'eraser'
        @clearCell e

  onMouseMove: (e) ->
    @onClick(e) if @mousePressed

  onMouseDown: ->
    @mousePressed = yes

  onMouseUp: ->
    @mousePressed = no

  drawCell: (e) ->
    coords = @calcCoords e
    @ctxp.fillStyle = @props.color
    @ctxc.fillStyle = @props.color
    @ctxc.fillRect coords.x * @cellW, coords.y * @cellH, @cellW, @cellH
    
    previewCellsMap.forEach (cell) =>
      x = (cell[0] * previewCellSize) + coords.x * 2
      y = (cell[1] * previewCellSize) + coords.y * 2
      @ctxp.fillRect x, y, 2, 2

  clearCell: (e) ->
    coords = @calcCoords e
    @ctxc.clearRect coords.x * @cellW, coords.y * @cellH, @cellW, @cellH

    previewCellsMap.forEach (cell) =>
      x = (cell[0] * previewCellSize) + coords.x * 2
      y = (cell[1] * previewCellSize) + coords.y * 2
      @ctxp.clearRect x, y, 2, 2

  calcCoords: (e) ->
    brect = document.body.getBoundingClientRect()
    crect = @canvas.getBoundingClientRect()
    
    x = ~~((e.pageX - (crect.left - brect.left)) / @cellW)
    y = ~~((e.pageY - (crect.top - brect.top)) / @cellH)
    x = Math.max 0, Math.min x, @props.size - 1
    y = Math.max 0, Math.min y, @props.size - 1

    return x: x, y: y

  render: ->
    <div className="canvas">
      <div className="canvas__preview">
        <canvas ref="preview" width=546 height=546 />
      </div>
      <div className="canvas__canvas">
        <canvas ref="canvas"
          width={@props.width}
          height={@props.height}
          onMouseMove={@onMouseMove}
          onClick={@onClick}>
        </canvas>
      </div>
    </div>