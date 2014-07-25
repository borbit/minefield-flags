# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  render: ->
    flags = @props.flags.map (flag) ->
      <div className="gallery__flag" style={backgroundImage: "url(/img/flags/#{flag}.png)"}/>

    <div className="gallery">
      {flags}
    </div>