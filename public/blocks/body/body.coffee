# @cjsx React.DOM 
React = require 'react'
Easel = require '../easel/easel'
Gallery = require '../gallery/gallery'
About = require '../about/about'
Tabs = require '../tabs/tabs'

cs = React.addons.classSet

module.exports = React.createClass
  getInitialState: ->
    page: 'easel'

  onTabChange: (page) ->
    @setState page: page

  render: ->
    <main className="body">
      <div className="body__tabs">
        <Tabs onChange={@onTabChange} page={@state.page} />
      </div>
      <div className={cs 'body__page': yes, 'body__page_show': @state.page is 'easel'}>
        <Easel width=544 height=544 size=17 />
      </div>
      <div className={cs 'body__page': yes, 'body__page_show': @state.page is 'gallery'}>
        <Gallery />
      </div>
      <div className={cs 'body__page': yes, 'body__page_show': @state.page is 'about'}>
        <About />
      </div>
    </main>