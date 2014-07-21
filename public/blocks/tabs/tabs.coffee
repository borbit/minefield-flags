# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  onChange: (e) ->
    @props.onChange e.currentTarget.dataset.page

  render: ->
    <div className="tabs">
      <input type="radio" name="tabs" value="draw" onChange={@onChange} />
      <label className="tabs__tab">DRAW</label>
      <input type="radio" name="tabs" value="gallery" onChange={@onChange} />
      <label className="tabs__tab">GALLERY ({123})</label>
      <input type="radio" name="tabs" value="about" onChange={@onChange} />
      <label className="tabs__tab">ABOUT</label>
    </div>