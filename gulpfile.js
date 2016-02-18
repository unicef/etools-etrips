var gulp = require('gulp');
var gutil = require('gulp-util');
var bower = require('bower');
var concat = require('gulp-concat');
var sass = require('gulp-sass');
var minifyCss = require('gulp-minify-css');
var rename = require('gulp-rename');
var shell = require('gulp-shell');
var preprocess = require('gulp-preprocess');
var sh = require('shelljs');
var args = require('yargs').argv;  
var fs = require('fs');
var replace = require('gulp-replace-task');  
var _ = require('lodash');
var protractor = require("gulp-protractor").protractor;
var pg = require('pg');
var async = require('async');

var integrationTestDb = 'test_db';

var paths = {
  sass: ['./scss/**/*.scss']
};

gulp.task('default', ['sass']);

gulp.task('sass', function(done) {
  gulp.src('./scss/ionic.app.scss')
    .pipe(sass({
      errLogToConsole: true
    }))
    .pipe(gulp.dest('./www/css/'))
    .pipe(minifyCss({
      keepSpecialComments: 0
    }))
    .pipe(rename({ extname: '.min.css' }))
    .pipe(gulp.dest('./www/css/'))
    .on('end', done);
});

gulp.task('watch', function() {
  gulp.watch(paths.sass, ['sass']);
});

gulp.task('install', ['git-check'], function() {
  return bower.commands.install()
    .on('log', function(data) {
      gutil.log('bower', gutil.colors.cyan(data.id), data.message);
    });
});

gulp.task('git-check', function(done) {
  if (!sh.which('git')) {
    console.log(
      '  ' + gutil.colors.red('Git is not installed.'),
      '\n  Git, the version control system, is required to download Ionic.',
      '\n  Download git here:', gutil.colors.cyan('http://git-scm.com/downloads') + '.',
      '\n  Once git is installed, run \'' + gutil.colors.cyan('gulp install') + '\' again.'
    );
    process.exit(1);
  }
  done();
});

gulp.task('replace', function () {  
  var env = args.env || 'local';
  var filename = env + '.json';
  var settings = JSON.parse(fs.readFileSync('./config/' + filename, 'utf8'));

  gulp.src('src/js/constants.js')  
    .pipe(replace({
      patterns: _.map(_.keys(settings), function(key){ 
          return { match: key, replacement: settings[key] };
        })
      }))
    .pipe(gulp.dest('www/js'));

  gulp.src('src/*.html')
    .pipe(preprocess({context: { NODE_ENV: env }}))
    .pipe(gulp.dest('www/'));
});

// disconnect any exisiting db connections  
gulp.task('postgres_disconnect', function(){  
  var con = 'postgres://postgres:password@localhost:5432/' + integrationTestDb;
  var client = new pg.Client(con);

  async.series([
    function(callback){
      client.connect(function(err) {
        if(err) {
          return console.error('could not connect to postgres', err);
        }

        callback(null, true);
      });
    },
    function(callback){
        client.query('REVOKE CONNECT ON DATABASE ' + integrationTestDb + ' FROM public;', function(err, result) {
          if(err) {
            return console.error('error running query', err);
          }

          callback(null, true);
        });
    },
    function(callback){
        client.query('SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = \'' + integrationTestDb + '\';', function(err, result) {
          callback(null, true);
        });
    }
  ],  
  function(err, results){

    client.end();      
  });
});

gulp.task('restore_db', ['postgres_disconnect'], shell.task(
  ['dropdb ' + integrationTestDb + ' && createdb ' + integrationTestDb + ' && psql ' + integrationTestDb + ' < ./tests/fixtures/data.sql'])
);

gulp.task('protractor', function() {
  gulp.src(["./tests/*.js"])
    .pipe(protractor({
        configFile: "./tests/conf_dev.js"
    }))
    .on('error', function(e) { throw e; });
});

gulp.task('protractor_watch', function () {   
  gulp.watch(['./tests/**/*.js'], ['protractor']);
});