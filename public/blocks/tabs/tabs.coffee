# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  render: ->
    <ul className="tabs">
      <li className="tabs__tab tabs__tab_act">DRAW</li>
      <li className="tabs__tab">GALLERY</li>
      <li className="tabs__tab">ABOUT</li>
    </ul>