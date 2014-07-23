# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  render: ->
    flags = [0..31].map ->
      <div className="gallery__flag" />

    <div className="gallery">
      {flags}
    </div>