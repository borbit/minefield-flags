React = require 'react'

List = require '../../blocks/list/list'

items = [
  {title: 'List item 1'}
  {title: 'List item 2'}
  {title: 'List item 3'}
  {title: 'List item 4'}
]

React.renderComponent List(items: items), document.getElementById 'list'