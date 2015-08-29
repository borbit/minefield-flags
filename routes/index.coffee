fs = require 'fs'
async = require 'async'
Canvas = require 'canvas'
redis = require 'redis-url'
express = require 'express'
basicAuth = require 'basic-auth'
parser = require 'body-parser'
crypto = require 'crypto'
config = require 'config'
path = require 'path'
fs = require 'fs'

React = require 'react/addons'
Body = require 'public/blocks/body/body'

auth = (req, res, next) ->
  unauthorized = (res) ->
    res.set 'WWW-Authenticate', 'Basic realm=Authorization Required'
    res.send 401

  user = basicAuth req

  if not user?.name or not user?.pass
    return unauthorized res
  if user.name != config.admin_login or user.pass != config.admin_pass
    return unauthorized res

  next()

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
    md5 = crypto.createHash 'md5'
    md5 = md5.update req.body
    md5 = md5.digest 'hex'

    flag = new Buffer req.body, 'base64'
    file = "#{config.flags_dir_path}/#{md5}.png"

    fs.writeFile file, flag, (err) ->
      next err if err
      res.send 200

  app.get '/admin', auth, (req, res) ->
    fs.readdir config.flags_dir_path, (err, files) ->
      files = files.map (file) ->
        return {
          stat: fs.statSync path.join(config.flags_dir_path, file)
          file: file
        }

      files = files.sort (a, b) ->
        a.stat.mtime.getTime() -
        b.stat.mtime.getTime()

      files = files.map (file) ->
        file.file

      page_count = +req.query.page_count or 100
      page_num = +req.query.page_num or 0
      
      total_files_count = files.length - 1
      total_pages_count = Math.ceil(total_files_count / page_count)

      files = files.filter (file) -> ~file.indexOf('.png')
      files = files.slice page_num * page_count, (page_num+1) * page_count

      redisClient.zrange 'flags', 0, -1, (err, flags) ->
        res.render 'admin/admin', {
          files
          flags
          total_files_count
          total_pages_count
          page_count
          page_num
        }

  app.post '/admin', auth, parser.urlencoded(extended: no), (req, res) ->
    files = req.body.files
    files = [files] unless files.push

    if req.body.build
      return buildSprite files, (err, sprite) ->
        res.redirect req.url
    
    if req.body.delete
      files.forEach (file) ->
        fs.unlinkSync path.join(config.flags_dir_path, file)

    if req.body.delete or req.body.gallery_remove
      files.forEach (file, i) ->
        redisClient.zrem 'flags', file.replace('.png', '')

    if req.body.gallery_add
      files.forEach (file, i) ->
        redisClient.zadd 'flags', Date.now()+i, file.replace('.png', '')


    res.redirect req.url



buildSprite = (files, cb) ->
  countH = Math.ceil Math.sqrt files.length
  countV = Math.ceil Math.sqrt files.length

  FLAG_SIZE = 34

  canvas = new Canvas(
    countH * FLAG_SIZE
  , countV * FLAG_SIZE
  )

  ctx = canvas.getContext('2d')

  async.forEachOf files, ((file, i, cb) ->
    x = i % countH
    y = ~~(i / countH)

    image = new Canvas.Image()
    image.onerror = cb
    image.onload = ->
      ctx.drawImage image, x * FLAG_SIZE, y * FLAG_SIZE
      cb()

    image.src = path.join(config.flags_dir_path, file)
  ), (err) ->
    return cb err if err

    fs.writeFile(
      config.flags_sprite_path,
      canvas.toBuffer(),
      cb
    )


