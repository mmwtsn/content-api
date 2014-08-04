/**
 *
 * Gulp.js! A task runner.
 *
 */

// Require Gulp
var gulp = require('gulp');

// Require our plug-ins
var sass       = require('gulp-sass');
var jshint     = require('gulp-jshint');
var concat     = require('gulp-concat');
var uglify     = require('gulp-uglify');
var rename     = require('gulp-rename');
var scsslint   = require('gulp-scss-lint');
var lintspaces = require('gulp-lintspaces');

// Define asset paths
var assetsPath = './public/assets';
var sassPath   = assetsPath + '/scss/**/*.scss';
var cssPath    = assetsPath + '/css';
var jsPath     = assetsPath + '/js/*.js';

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

// Concatenate JavaScript
gulp.task('concat', function() {
  gulp.src('config.js', 'create.js', 'toggle.js', 'init.js')
    .pipe(concat('scripts.js'));
});

// Uglify (minify and compress) JavaScript
gulp.task('uglify', function() {
  gulp.src(jsPath)
    .pipe(uglify());
});

// Watch files for changes
gulp.task('watch', function() {
  gulp.watch(sassPath, ['sass']);
  gulp.watch(jsPath, ['jshint']);
});

// Default task definition
gulp.task('default', ['jshint', 'scss-lint', 'concat', 'uglify', 'sass', 'watch']);
