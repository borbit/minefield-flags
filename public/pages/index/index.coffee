React = require 'react'
Easel = require '../../blocks/easel/easel'
Tabs = require '../../blocks/tabs/tabs'

React.renderComponent Easel(width: 510, height: 510, size: 17), document.querySelector '.body__canvas'
React.renderComponent Tabs(), document.querySelector '.body__tabs'