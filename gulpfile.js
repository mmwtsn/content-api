/**
 *
 * Gulp.js! A task runner.
 *
 */

// Require Gulp
var gulp = require('gulp');

// Require our plug-ins
var sass   = require('gulp-sass');
var jshint = require('gulp-jshint');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
var jshint = require('gulp-jshint');
var scsslint = require('gulp-scss-lint');
var lintspaces = require('gulp-lintspaces');

// Define asset paths
var assetsPath = './public/assets';
var sassPath   = assetsPath + '/scss/**/*.scss';
var cssPath    = assetsPath + '/css';
var jsPath     = assetsPath + '/js/*.js';

// TODO - Add these!
// gulp-imagemin
// gulp-minify-css
// gulp-uglify

// JavaScript lint task
gulp.task('jshint', function() {
  return gulp.src(jsPath)
    .pipe(jshint())
    .pipe(jshint.reporter('default'));
});

// SCSS lint task
gulp.task('scss-lint', function() {
  return gulp.src(sassPath)
    .pipe(scsslint({
      'config': '.scss-lint.yml'
    }));
});

// SASS compilation task
gulp.task('sass', function() {
  return gulp.src(sassPath)
    .pipe(sass({
      'outputStyle': 'compressed'
    }))
    .pipe(gulp.dest(cssPath));
});

// Watch files for changes
gulp.task('watch', function() {
  gulp.watch(sassPath, ['sass']);
  gulp.watch(jsPath, ['jshint']);
});

// Default task definition
gulp.task('default', ['jshint', 'scss-lint', 'sass', 'watch']);
