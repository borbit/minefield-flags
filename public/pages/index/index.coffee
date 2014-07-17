React = require 'react'
Easel = require '../../blocks/easel/easel'
Tabs = require '../../blocks/tabs/tabs'

React.renderComponent Easel(width: 544, height: 544, size: 17), document.querySelector '.body__canvas'
React.renderComponent Tabs(), document.querySelector '.body__tabs'