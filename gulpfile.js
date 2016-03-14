var gulp = require('gulp-help')(require('gulp'));
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
var confBase = require('./tests/conf_base.js')

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
  var env = args.env || 'prod';
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

gulp.task('replace-circleci', function () {  
  var settings = {
    "apiHostDevelopment" : args.ip,
    "defaultConnection" : 0
  };

  gulp.src('src/js/constants.js')  
    .pipe(replace({
      patterns: _.map(_.keys(settings), function(key){ 
          return { match: key, replacement: settings[key] };
        })
      }))
    .pipe(gulp.dest('www/js'));

  gulp.src('src/*.html')
    .pipe(preprocess({context: { NODE_ENV: 'test' }}))
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

gulp.task('dump_db', shell.task(
  ['pg_dump ' + integrationTestDb + ' > ./tests/fixtures/data.sql'])
);


gulp.task('restore_db', ['postgres_disconnect'], shell.task(
    ['sleep 0.5 && dropdb ' + integrationTestDb + ' && createdb ' + integrationTestDb + ' && psql --output=restore_db.log --quiet ' + integrationTestDb + ' < ./tests/fixtures/data.sql']
  )
);

var exec = require('child_process').exec;
var dockerSeleniumDebugIpPorts = '';

gulp.task('docker_selenium_start', function(cb) {  
  exec('docker run --name standalone-chrome-debug -d -P selenium/standalone-chrome-debug', function(err, stdout, stderr) {
    if (err) {
      console.log(err);    
    } else {
      console.log('started: docker selenium');
    }
  });
});

gulp.task('docker_selenium_stop', function(cb) {  
  exec('docker rm -f standalone-chrome-debug', function(err, stdout, stderr) {
    if (err) {
      console.log(err);
    } else {
      console.log('stopped: docker selenium');
    }
  });
});

gulp.task('docker_selenium_debug_ip_ports', function(cb) {  
  async.series([
      function(callback){
        exec('docker-machine ip', function(err, stdout, stderr) {
          callback(null, stdout.replace(/(\r\n|\n|\r)/gm,""));
        });
      },
      function(callback){
        exec('docker port standalone-chrome-debug 4444', function(err, stdout, stderr) {
          callback(null, stdout.replace(/(\r\n|\n|\r)/gm,"").split('0.0.0.0:')[1] );
        });
      },
      function(callback){
        exec('docker port standalone-chrome-debug 5900', function(err, stdout, stderr) {
          callback(null, stdout.replace(/(\r\n|\n|\r)/gm,"").split('0.0.0.0:')[1] );
        });
      }      
  ],
  function(err, results){
    var data = {
      'ip' : results[0],
      'selenium_port' : results[1],
      'vnc_port' : results[2]
    };
    dockerSeleniumDebugIpPorts = data;    
    cb();
  });
});

gulp.task('docker_selenium_vnc', ['docker_selenium_debug_ip_ports'], function(cb) {  
  exec('open vnc://user:secret@' + dockerSeleniumDebugIpPorts.ip + ':' + dockerSeleniumDebugIpPorts.vnc_port);  
});

gulp.task('protractor', function() {
  gulp.src(["./tests/*.js"])
    .pipe(protractor({
        configFile: "./tests/conf_dev.js"
    }))
    .on('error', function(e) { throw e; });
});

gulp.task('protractor_docker', ['docker_selenium_debug_ip_ports'], function() {  
  gulp.src(["./tests/*.js"])
    .pipe(protractor({
        configFile: "./tests/conf_dev.js",
        args: ['--seleniumAddress', 'http://' + dockerSeleniumDebugIpPorts.ip + ':' + dockerSeleniumDebugIpPorts.selenium_port + '/wd/hub']
    }))
    .on('error', function(e) { throw e; });    
});

var allTestsFilename = 'all_tests.js';

gulp.task('protractor_concat_tests', function() {
  var specs = confBase.config.specs;
  var testPath = './tests/';
  var files = [testPath + 'includes.js'];

  _.each(specs, function(spec){
    files.push(testPath + spec);    
  })

  return gulp.src(files)
    .pipe(concat(allTestsFilename))
    .pipe(gulp.dest('./tests/'));
});

gulp.task('protractor_android', ['protractor_concat_tests'], function() {
   gulp.src(["./tests/all_tests.js"])
    .pipe(protractor({
        configFile: "./tests/conf_android.js"        
    }))
    .on('error', function(e) { throw e; });
});

gulp.task('protractor_watch', function () {   
  gulp.watch(['./tests/**/*.js'], ['protractor']);
});