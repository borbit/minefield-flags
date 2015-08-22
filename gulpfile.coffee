fs              = require 'fs'
gulp            = require 'gulp'
gulpRev         = require 'gulp-rev'
gulpLess        = require 'gulp-less'
gulpClean       = require 'gulp-clean'
gulpBrowserify  = require 'gulp-browserify'
gulpReplace     = require 'gulp-replace'
gulpRename      = require 'gulp-rename'
gulpUglify      = require 'gulp-uglify'
gulpCSSO        = require 'gulp-csso'

globAllLess     = './public/!(dist)/**/*.less'
globAllCoffee   = './public/!(dist)/**/*.coffee'
globAllFiles    = './public/+(img|blocks|font)/**/*.{png,jpg,jpeg,gif,svg,woff,ico}'
globAssetsFiles = './public/dist/**/*.{png,jpg,jpeg,gif,svg,woff,ico}'
globAssetsCss   = './public/dist/**/*.css'
globAssetsJs    = './public/dist/**/*.js'

globPageLess    = './public/pages/*/*.less'
globPageCoffee  = './public/pages/*/*.coffee'
commonModule    = './public/coffee/common.coffee'
distDir         = './public/dist'

gulp.task 'compile-less', ->
  compile = gulpLess relativeUrls: yes
  compile.on 'error', (err) ->
    console.log err

  gulp
    .src(globPageLess)
    .pipe(compile)
    .pipe(gulp.dest distDir)

gulp.task 'compile-coffee', ->
  compile = gulpBrowserify
    extensions: ['.coffee']
    detectGlobals: no

  compile.on 'error', (err) ->
    console.log err

  compile.on 'prebundle', (bundler) ->
    bundler.transform 'browserify-ejs'
    bundler.transform {sourceMap: no, coffeeout: yes}, 'coffee-reactify'
    bundler.transform 'coffeeify'

    getExternalModules().forEach (module) ->
      bundler.exclude module.name

  gulp
    .src(globPageCoffee, read: no)
    .pipe(compile)
    .pipe(gulpRename extname: '.js')
    .pipe(gulp.dest distDir)

gulp.task 'compile-common', ->
  compile = gulpBrowserify
    transform: ['coffeeify']
    extensions: ['.coffee']
    detectGlobals: no

  compile.on 'error', (err) ->
    console.log err

  compile.on 'prebundle', (bundler) ->
    getExternalModules().forEach (module) ->
      bundler.require module.path, expose: module.name

  gulp
    .src(commonModule, read: no)
    .pipe(compile)
    .pipe(gulpRename extname: '.js')
    .pipe(gulp.dest distDir)

gulp.task 'compile', [
  'compile-less'
  'compile-common'
  'compile-coffee'
]

gulp.task 'watch', ['compile'], ->
  gulp.watch globAllLess, ['compile-less']
  gulp.watch globAllCoffee, ['compile-coffee']

gulp.task 'clean', ->
  gulp
    .src(distDir, read: no)
    .pipe(gulpClean())

gulp.task 'copy', ['clean'], ->
  gulp
    .src(globAllFiles)
    .pipe(gulp.dest distDir)

gulp.task 'rev', ['compile', 'copy'], ->
  filesToRev = [
    globAssetsFiles
    globAssetsCss
    globAssetsJs
  ]

  gulp.src(filesToRev)
    .pipe(gulpRev())
    .pipe(gulp.dest distDir)
    .pipe(gulpRev.manifest())
    .pipe(gulp.dest distDir)

gulp.task 'css-rev', ['rev'], ->
  regexp = /url\(['"]?([^\)'"]*)['"]?\)/gim
  manifest = require "#{distDir}/rev-manifest.json"
  replace = gulpReplace regexp, (_, url) ->
    distUrl = url

    if distUrl[0] == '/'
      distUrl = url.replace '/', ''
    if manifest[distUrl]?
      "url(\"/dist/#{manifest[distUrl]}\")"
    else
      "url(\"/#{url}\")"

  gulp.src(distDir + '/**/*.css')
    .pipe(replace)
    .pipe(gulp.dest distDir)

gulp.task 'css-csso', ['css-rev'], ->
  gulp.src(distDir + '/**/*.css')
    .pipe(gulpCSSO())
    .pipe(gulp.dest distDir)

gulp.task 'js-uglify', ['rev'], ->
  gulp.src(distDir + '/**/*.js')
    .pipe(gulpUglify())
    .pipe(gulp.dest distDir)

gulp.task 'default', [
  'watch'
]

gulp.task 'dist', [
  'rev'
  'css-rev'
  'css-csso'
  'js-uglify'
]

getExternalModules = ->
  if getExternalModules.modules?
    return getExternalModules.modules

  modules = fs.readFileSync commonModule
  modules = modules.toString().split '\n'
  modules = modules.filter (module) -> module.length
  modules = modules.map (module) ->
    path = module.split("'")[1]
    name = path.split('/').pop()
    
    return {
      path: path
      name: name
    }

  getExternalModules.modules = modules