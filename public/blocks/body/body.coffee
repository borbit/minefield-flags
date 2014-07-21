React = require 'react'
Easel = require '../easel/easel'
Gallery = require '../gallery/gallery'
Tabs = require '../tabs/tabs'

module.exports = React.createClass
  onTabChange: (page) ->
    console.log page

  render: ->
    <main className="body">
      <div className="body__tabs">
        <Tabs onChange={@onTabChange} />
      </div>
      <div className="body__page" ref="easel">
        <Easel width=544 height=544 size=17 />
      </div>
      <div className="body__page" ref="gallery">
        <Gallery />
      </div>
    </main>