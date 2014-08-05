// Require Gulp and Co.
var gulp = require('gulp');
var sass       = require('gulp-sass');
var jshint     = require('gulp-jshint');
var concat     = require('gulp-concat');
var uglify     = require('gulp-uglify');
var scsslint   = require('gulp-scss-lint');
var lintspaces = require('gulp-lintspaces');

// Base asset paths
var root       = './public';
var distPath   = root + '/dist';
var assetsPath = root + '/assets';

// Individual asset paths
var sassPath   = assetsPath + '/scss/**/*.scss';
var jsPath     = assetsPath + '/js/**/*.js';

// Ordered scripts path
var jsOrdered  = [
  assetsPath + '/js/vendor/rails.js',
  assetsPath + '/js/config.js',
  assetsPath + '/js/toggle.js',
  assetsPath + '/js/create.js',
  assetsPath + '/js/init.js'
];

// Configuration objects
var sassConfig = {'outputStyle': 'compressed'};
var lintConfig = {'config': '.scss-lint.yml'};

// JavaScript tasks
gulp.task('scripts', function() {
  return gulp.src( jsOrdered )
    .pipe(jshint())
    .pipe(jshint.reporter('default'))
    .pipe(concat('scripts.js'))
    .pipe(uglify())
    .pipe(gulp.dest(distPath));
});

// SASS tasks
gulp.task('styles', function() {
  return gulp.src([sassPath, '!' + assetsPath + '/scss/vendor/**/*.scss'])
    .pipe(scsslint( lintConfig ))
    .pipe(sass( sassConfig ))
    .pipe(gulp.dest(distPath));
});

// Watch files for changes
gulp.task('watch', function() {
  gulp.watch(sassPath, ['styles']);
  gulp.watch(jsPath, ['scripts']);
});

// Default task definition
gulp.task('default', ['scripts', 'styles', 'watch']);
