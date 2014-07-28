module.exports =
  port : process.env.PORT || '9000',
  host : process.env.HOST || '0.0.0.0'
  dist_manifest_path: __dirname + '/public/dist/rev-manifest'
  flags_dir_path: __dirname + '/public/img/flags'
  redis_url: process.env.REDIS_URL