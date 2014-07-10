# @cjsx React.DOM 
React = require 'react'

List = module.exports = React.createClass
  render: ->
    items = @props.items.map (item) ->
      <ListItem title={item.title} />
    <ul className="list">{items}</ul>

ListItem = React.createClass
  render: ->
    <li className="list__item">{@props.title}</li>