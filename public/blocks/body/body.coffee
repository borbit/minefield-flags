# @cjsx React.DOM 
React = require 'react'
Easel = require '../easel/easel'
Gallery = require '../gallery/gallery'
About = require '../about/about'
Modal = require '../modal/modal'
Tabs = require '../tabs/tabs'
texts = require '../../coffee/texts'
cs = React.addons.classSet

module.exports = React.createClass
  componentDidMount: ->
    setInterval @updateFlags, 30000
    @updateFlags()

  getInitialState: ->
    page: 'easel'
    submitted: no
    submiting: no
    flags: []

  onTabChange: (page) ->
    @setState page: page

  onSubmit: (flag) ->
    @setState submiting: yes

    ajax = new XMLHttpRequest()
    ajax.open 'post','/', yes
    ajax.onreadystatechange = =>
      if ajax.status == 200
        @setState 
          submitted: yes
          submiting: no

    flag = flag.toDataURL 'image/png'
    flag = flag.replace /^data:image\/png;base64,/, ''

    ajax.setRequestHeader 'Content-Type', 'application/upload'
    ajax.send flag

  onSubmitConfirmed: ->
    @setState submitted: no

  updateFlags: ->
    ajax = new XMLHttpRequest()
    ajax.open 'get', '/flags', yes
    ajax.onreadystatechange = =>
      if ajax.status == 200
        @setState flags: JSON.parse ajax.responseText
    ajax.send()

  render: ->
    modal = null
    if @state.submitted
      modal = <Modal message={texts.body_submitted} onClose={@onSubmitConfirmed} />

    classEasel = cs
      'body__page': yes
      'body__page_show': @state.page is 'easel'
    classGallery = cs
      'body__page': yes
      'body__page_gallery': yes
      'body__page_show': @state.page is 'gallery'
    classAbout = cs
      'body__page': yes
      'body__page_show': @state.page is 'about'

    <main className="body">
      {modal}
      <div className="body__tabs">
        <Tabs 
          onChange={@onTabChange}
          flags={@state.flags}
          page={@state.page}
        />
      </div>
      <div className={classEasel}>
        <Easel
          size=17 
          width=544
          height=544
          onSubmit={@onSubmit} 
          submiting={@state.submiting}
        />
      </div>
      <div className={classGallery}>
        <Gallery flags={@state.flags} />
      </div>
      <div className={classAbout}>
        <About />
      </div>
    </main>