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

// Define asset paths
var assetsPath = './public/assets';
var sassPath   = assetsPath + '/scss/*.scss';
var cssPath    = assetsPath + '/css';
var jsPath     = assetsPath + '/js/*.js';

// TODO - Add these!
// gulp-imagemin
// gulp-minify-css
// gulp-uglify
// gulp-jslint
// gulp-scss-lint
// gulp-lintspaces

// JavaScript lint task
gulp.task('lint', function() {
  return gulp.src(jsPath)
    .pipe(jshint())
    .pipe(jshint.reporter('default'));
});

// SASS compilation task
gulp.task('sass', function() {
  return gulp.src(sassPath)
    .pipe(sass({
      includePaths: require('node-bourbon').includePaths,
      includePaths: require('node-neat').includePaths
    }))
    .pipe(gulp.dest(cssPath));
});

// Watch files for changes
gulp.task('watch', function() {
  gulp.watch(sassPath, ['sass']);
  gulp.watch(jsPath, ['lint']);
});

// Default task definition
gulp.task('default', ['lint', 'sass', 'watch']);
