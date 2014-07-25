redis = require 'redis-url'
parser = require 'body-parser'
config = require 'config'
fs = require 'fs'

React = require 'react/addons'
Body = require 'public/blocks/body/body'

module.exports = (app) ->
  redisClient = redis.connect()

  app.get '/', (req, res, next) ->
    res.render 'index/index',
      body: React.renderComponentToString Body()

  app.get '/flags', (req, res) ->
    redisClient.zrange 'flags', 0, -1, (err, flags) ->
      next err if err
      res.json flags

  app.post '/', parser.text(type: 'application/upload'), (req, res, next) ->
    now = Date.now()
    flag = new Buffer req.body, 'base64'
    file = "#{config.flags_dir_path}/#{now}.png"

    fs.writeFile file, flag, (err) ->
      next err if err

      redisClient.zadd 'flags', now, now, (err) ->
        next err if err        
        res.send 200
