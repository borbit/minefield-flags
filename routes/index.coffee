React = require 'react'
Easel = require 'public/blocks/easel/easel'
Tabs = require 'public/blocks/tabs/tabs'

module.exports = (app) ->
  app.get '/', (req, res) ->
    res.render 'index/index',
      easel: React.renderComponentToString Easel(width: 544, height: 544, size: 17)
      tabs: React.renderComponentToString Tabs()