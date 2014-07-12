# @cjsx React.DOM 
React = require 'react'
ListItem = require './list__item'

module.exports = React.createClass
  render: ->
    items = @props.items.map (item) ->
      <ListItem title={item.title} />
    <ul className="list">{items}</ul>