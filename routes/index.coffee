React = require 'react'

module.exports = (app) ->
  app.get '/', (req, res) ->
    res.render 'index/index',
      easel: '' #React.renderComponentToString Easel(width: 544, height: 544, size: 17)
      tabs: '' #React.renderComponentToString Tabs()