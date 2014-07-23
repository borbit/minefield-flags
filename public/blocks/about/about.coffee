React = require 'react'

module.exports = React.createClass
  render: ->
    <div className="about">
      <div>
        <p className="about__text">
          The idea of this project it to enable<br/>
          Minefield's players to draw their own custom flags.<br/>
          For the timebeing it work's pretty simple - you draw<br/>
          a flag, then you submit it, then it appears in gallery, <br/>
          then I put it on Minefield (if it is nice and not abusive).<br/>
          To prevent flooding sever doesn't allow submitting<br/>
          within 15 minutes after the last submit.
        </p>
        <p className="about__text">
          All the project's front-end is built with powers of<br/>
          super awesome framework <a hreaf="#">React.js</a>. The sorce code<br/>
          is hostend on <a hreaf="#">GitHub</a> . I will be very greatful for any<br/>
          contribution or bugreports or star.
        </p>
        <p className="about__text">
          Share it with your frieds :
        </p>
        <p className="about__text">
          Made by <a hreaf="#">Serge Borbit</a>
        </p>
      </div>
    </div>