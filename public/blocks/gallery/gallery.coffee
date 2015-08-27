# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  onSelect: (flag) ->
    this.props.onSelect(flag)

  render: ->
    flags = @props.flags.map (flag) =>
      <div className="gallery__flag" style={backgroundImage: "url(/flags/#{flag}.png)"} onClick={@onSelect.bind(@, flag)}/>

    <div className="gallery">
      {flags}
    </div>