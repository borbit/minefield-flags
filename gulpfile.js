var fs              = require('fs')
var gulp            = require('gulp')
var gulpRev         = require('gulp-rev')
var gulpLess        = require('gulp-less')
var gulpClean       = require('gulp-clean')
var gulpBrowserify  = require('gulp-browserify')
var gulpReplace     = require('gulp-replace')
var gulpRename      = require('gulp-rename')
var gulpUglify      = require('gulp-uglify')
var gulpCSSO        = require('gulp-csso')

var globAllLess     = './public/!(dist)/**/*.less'
var globAllCoffee   = './public/!(dist)/**/*.coffee'
var globAllFiles    = './public/!(dist)/**/*.{png,jpg,jpeg,gif,svg,woff,ico}'
var globAssetsFiles = './public/dist/**/*.{png,jpg,jpeg,gif,svg,woff,ico}'
var globAssetsCss   = './public/dist/**/*.css'
var globAssetsJs    = './public/dist/**/*.js'

var globPageLess    = './public/pages/*/*.less'
var globPageCoffee  = './public/pages/*/*.coffee'
var commonModule    = './public/coffee/common.coffee'
var distDir         = './public/dist'

gulp.task('compile-less', function() {
  var compile = gulpLess({
    relativeUrls: true
  })

  compile.on('error', function(err) {
    console.log(err)
  })

  return gulp
    .src(globPageLess)
    .pipe(compile)
    .pipe(gulp.dest(distDir))
})

gulp.task('compile-coffee', function() {
  var compile = gulpBrowserify({
    transform: ['coffeeify', 'browserify-ejs']
  , extensions: ['.coffee']
  , detectGlobals: false
  })

  compile.on('prebundle', function(bundler) {
    getExternalModules().forEach(function(module) {
      bundler.exclude(module.name)
    })
  })

  compile.on('error', function(err) {
    console.log(err)
  })

  return gulp
    .src(globPageCoffee, {read: false})
    .pipe(compile)
    .pipe(gulpRename({extname: '.js'}))
    .pipe(gulp.dest(distDir))
})

gulp.task('compile-common', function() {
  var compile = gulpBrowserify({
    transform: ['coffeeify']
  , extensions: ['.coffee']
  , detectGlobals: false
  })

  compile.on('prebundle', function(bundler) {
    getExternalModules().forEach(function(module) {
      bundler.require(module.path, {expose: module.name})
    })
  })

  compile.on('error', function(err) {
    console.log(err)
  })

  return gulp
    .src(commonModule, {read: false})
    .pipe(compile)
    .pipe(gulpRename({extname: '.js'}))
    .pipe(gulp.dest(distDir))
})

gulp.task('compile', [
  'compile-less',
  'compile-common',
  'compile-coffee'
])

gulp.task('watch', ['compile'], function() {
  gulp.watch(globAllLess, ['compile-less'])
  gulp.watch(globAllCoffee, ['compile-coffee'])
})

gulp.task('clean', function() {
  return gulp
    .src(distDir, {read: false})
    .pipe(gulpClean())
})

gulp.task('files', ['clean'], function() {
  return gulp
    .src(globAllFiles)
    .pipe(gulp.dest(distDir))
})

gulp.task('rev', ['compile', 'files'], function() {
  var filesToRev = [
    globAssetsFiles
  , globAssetsCss
  , globAssetsJs
  ]

  return gulp.src(filesToRev)
    .pipe(gulpRev())
    .pipe(gulp.dest(distDir))
    .pipe(gulpRev.manifest())
    .pipe(gulp.dest(distDir))
})

gulp.task('css-rev', ['rev'], function() {
  var regexp = /url\(['"]?([^\)'"]*)['"]?\)/gim
  var manifest = require(distDir + '/rev-manifest.json')
  var replace = gulpReplace(regexp, function(_, url) {
    distUrl = url

    if (distUrl[0] == '/')
      distUrl = url.replace('/', '')
    if (manifest[distUrl])
      return 'url("/dist/' + manifest[distUrl] + '")'
    else
      return 'url("/' + url + '")'
  })

  return gulp.src(distDir + '/**/*.css')
    .pipe(replace)
    .pipe(gulp.dest(distDir))
})

gulp.task('css-csso', ['css-rev'], function() {
  return gulp.src(distDir + '/**/*.css')
    .pipe(gulpCSSO())
    .pipe(gulp.dest(distDir))
})

gulp.task('js-uglify', ['rev'], function() {
  return gulp.src(distDir + '/**/*.js')
    .pipe(gulpUglify())
    .pipe(gulp.dest(distDir))
})

gulp.task('default', [
  'watch'
])

gulp.task('dist', [
  'rev'
, 'css-rev'
, 'css-csso'
, 'js-uglify'
])

function getExternalModules() {
  if (getExternalModules.modules)
    return getExternalModules.modules

  var modules = fs.readFileSync(commonModule)
  modules = modules.toString().split('\n')
  modules = modules.map(function(module) {
    var path = module.split("'")[1]
    var name = path.split('/').pop()
    return {
      path: path
    , name: name
    }
  })

  return getExternalModules.modules = modules
}