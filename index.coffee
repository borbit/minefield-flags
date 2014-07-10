express = require 'express'
engines = require 'consolidate'
config  = require './config'

app = express()

app.set 'env', config.NODE_ENV
app.set 'strict routing', no
app.set 'views', 'public/pages'
app.set 'view engine', 'ejs'
app.engine 'ejs', engines.ejs
app.enable 'trust proxy'
app.use express.static __dirname + '/public/'

try
  manifest = require config.dist_manifest_path
catch e
  manifest = {}

app.locals.asset = (src) ->
  if manifest[src]
    src = "/dist/#{manifest[src]}"
  "/#{src}"

app.locals.dist = (src) ->
  if manifest[src]
    src = manifest[src]  
  "/dist/#{src}"

app.get '/', (req, res) ->
  res.render 'index/index'

app.listen config.port, config.host, (err) ->
  throw err if err

  console.log 'Application server started on',
    host: config.host
    port: config.port
