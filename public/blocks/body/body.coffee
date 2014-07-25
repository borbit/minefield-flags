# @cjsx React.DOM 
React = require 'react'
Easel = require '../easel/easel'
Gallery = require '../gallery/gallery'
About = require '../about/about'
Tabs = require '../tabs/tabs'

cs = React.addons.classSet

module.exports = React.createClass
  componentDidMount: ->
    setInterval @updateFlags, 10000
    @updateFlags()

  getInitialState: ->
    page: 'easel'
    flags: []

  onTabChange: (page) ->
    @setState page: page

  onSubmit: (flag) ->
    ajax = new XMLHttpRequest()
    ajax.open 'post','/', no
    ajax.onreadystatechange = =>
      if ajax.status == 200
        @updateFlags()

    flag = flag.toDataURL 'image/png'
    flag = flag.replace /^data:image\/png;base64,/, ''

    ajax.setRequestHeader 'Content-Type', 'application/upload'
    ajax.send flag

  updateFlags: ->
    ajax = new XMLHttpRequest()
    ajax.open 'get', '/flags', no
    ajax.onreadystatechange = =>
      if ajax.status == 200
        @setState flags: JSON.parse ajax.responseText
    ajax.send()

  render: ->
    <main className="body">
      <div className="body__tabs">
        <Tabs onChange={@onTabChange} page={@state.page} flags={@state.flags} />
      </div>
      <div className={cs 'body__page': yes, 'body__page_show': @state.page is 'easel'}>
        <Easel width=544 height=544 size=17 onSubmit={@onSubmit} />
      </div>
      <div className={cs 'body__page': yes, 'body__page_show': @state.page is 'gallery'}>
        <Gallery flags={@state.flags} />
      </div>
      <div className={cs 'body__page': yes, 'body__page_show': @state.page is 'about'}>
        <About />
      </div>
    </main>