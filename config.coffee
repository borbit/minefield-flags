module.exports =
  port : process.env.PORT || '9000',
  host : process.env.HOST || '0.0.0.0'
  dist_manifest_path: __dirname + '/public/dist/rev-manifest'