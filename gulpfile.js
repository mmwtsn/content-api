// Require Gulp and Co.
var gulp       = require( 'gulp' );
var sass       = require( 'gulp-sass' );
var jshint     = require( 'gulp-jshint' );
var filter     = require( 'gulp-filter' );
var concat     = require( 'gulp-concat' );
var uglify     = require( 'gulp-uglify' );
var scsslint   = require( 'gulp-scss-lint' );
var lintspaces = require( 'gulp-lintspaces' );

// Base asset paths
var root       = 'public';
var distPath   = root + '/dist';
var assetsPath = root + '/assets';

// Individual asset paths
var sassPath   = assetsPath + '/scss/**/*.scss';
var jsPath     = assetsPath + '/js/**/*.js';

// Ignored asset paths
var sassIgnore = '!' + assetsPath + '/scss/vendor/**/*.scss';
var jsIgnore   = '!' + assetsPath + '/js/vendor/**/*.js';

// Configuration objects
var sassConfig = { 'outputStyle': 'compressed' };
var lintConfig = { 'config': '.scss-lint.yml' };

// JavaScript tasks
gulp.task( 'scripts', function() {
var vendorFilter = filter( jsIgnore );

  return gulp.src( jsPath ) // Pass in all scripts
    .pipe( vendorFilter ) // Filter out vendor scripts
    .pipe( jshint() )
    .pipe( jshint.reporter('default') )
    .pipe( vendorFilter.restore() ) // Restore vendor scripts
    .pipe( concat('scripts.js') )
    .pipe( uglify() )
    .pipe( gulp.dest(distPath) );
});

// SASS tasks
gulp.task( 'styles', function() {
  return gulp.src( [sassPath, sassIgnore] )
    .pipe(scsslint( lintConfig ))
    .pipe( sass(sassConfig) )
    .pipe(gulp.dest( distPath ));
});

// Watch files for changes
gulp.task( 'watch', function() {
  gulp.watch( sassPath, ['styles'] );
  gulp.watch( jsPath, ['scripts'] );
});

// Default task definition
gulp.task( 'default', ['scripts', 'styles', 'watch'] );
