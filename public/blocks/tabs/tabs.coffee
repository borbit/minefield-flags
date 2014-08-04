# @cjsx React.DOM 
React = require 'react'
cs = React.addons.classSet

module.exports = React.createClass
  onClick: (e) ->
    @props.onChange e.currentTarget.dataset.value

  render: ->
    classEasel = cs
      'tabs__tab': yes
      'tabs__tab_active': @props.page is 'easel'
    classGallery = cs
      'tabs__tab': yes
      'tabs__tab_active': @props.page is 'gallery'
      'tabs__tab_gallery': yes
    classAbout = cs
      'tabs__tab': yes
      'tabs__tab_active': @props.page is 'about'

    <ul className="tabs">
      <li data-value="easel" className={classEasel} onClick={@onClick}>DRAW</li>
      <li data-value="gallery" className={classGallery} onClick={@onClick}>GALLERY ({@props.flags.length})</li>
      <li data-value="about" className={classAbout} onClick={@onClick}>ABOUT</li>
    </ul>