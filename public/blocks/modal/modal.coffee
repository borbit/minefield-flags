# @cjsx React.DOM 
React = require 'react'

module.exports = React.createClass
  show: ->
    el = @getDOMNode()
    el.styles.display = 'block'
    setTimeout (->
      el.classList.add 'modal__show'
    ), 0

  hide: ->
    el = @getDOMNode()
    el.classList.remove 'modal__show'
    setTimeout (->
      el.style.display = 'none'
    ), 200

  onClose: ->
    @hide()
    @props.onClose()

  render: ->
    <div className="modal">
      <div className="modal__mask"/>
      <div className="modal__window">
        <div className="modal__content" dangerouslySetInnerHTML={{__html: @props.message}}/>
        <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_blank">
          <input type="hidden" name="cmd" value="_s-xclick" />
          <input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----"/>
          <button className="modal__donate">Donate <3</button>
        </form>
        <div className="modal__close" onClick={@onClose}>Close x</div>
      </div>
    </div>
