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
      page_count = +req.query.page_count or 100
      page_num = +req.query.page_num or 0
      
      total_files_count = files.length - 1
      total_pages_count = Math.ceil(total_files_count / page_count)

      files = files.filter (file) -> ~file.indexOf('.png')
      files = files.slice page_num * page_count, (page_num+1) * page_count

      res.render 'admin/admin', {
        files
        total_files_count
        total_pages_count
        page_count
        page_num
      }

  app.post '/admin', auth, parser.urlencoded(extended: no), (req, res) ->
    files = req.body.files
    files = [files] unless files.push
    
    files.forEach (file) ->
      fs.unlinkSync path.join(config.flags_dir_path, file)

    res.redirect req.url

