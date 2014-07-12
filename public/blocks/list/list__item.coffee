# @cjsx React.DOM 
React = require 'react'
      
module.exports = React.createClass
  render: ->
    <li className="list__item">{@props.title}</li>