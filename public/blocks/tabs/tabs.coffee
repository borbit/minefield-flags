# @cjsx React.DOM 
React = require 'react'
cs = React.addons.classSet

module.exports = React.createClass
  onClick: (e) ->
    @props.onChange e.currentTarget.dataset.value

  render: ->
    <ul className="tabs">
      <li data-value="easel" className={cs 'tabs__tab': yes, 'tabs__tab_active': @props.page is 'easel'} onClick={@onClick}>DRAW</li>
      <li data-value="gallery" className={cs 'tabs__tab': yes, 'tabs__tab_active': @props.page is 'gallery'} onClick={@onClick}>GALLERY ({123})</li>
      <li data-value="about" className={cs 'tabs__tab': yes, 'tabs__tab_active': @props.page is 'about'} onClick={@onClick}>ABOUT</li>
    </ul>