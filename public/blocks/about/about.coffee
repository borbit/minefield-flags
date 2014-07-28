# @cjsx React.DOM
React = require 'react'
texts = require '../../coffee/texts'

module.exports = React.createClass
  render: ->
    <div className="about">
      <div>
        <p className="about__text" dangerouslySetInnerHTML={{__html: texts.about_idea}}/>
        <p className="about__text" dangerouslySetInnerHTML={{__html: texts.about_built}}/>
        <p className="about__text" dangerouslySetInnerHTML={{__html: texts.about_share}}/>
        <p className="about__text">
          <iframe
            src="http://ghbtns.com/github-btn.html?user=borbit&repo=minefield-flags&type=watch&count=true"
            allowTransparency="true"
            frameBorder="0"
            scrolling="no"
          />
          <iframe
            src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2Fmienfield.com%2Fflags&layout=button_count&action=like&appId=230676180385849"
            allowTransparency="true"
            frameBorder="0"
            scrolling="no"
          />
          <iframe 
            src="https://platform.twitter.com/widgets/tweet_button.html"
            allowTransparency="true"
            frameBorder="0"
            scrolling="no"
          />
        </p>
        <p className="about__text">
          Made by <a href="https://github.com/borbit">Serge Borbit</a>
        </p>
      </div>
    </div>