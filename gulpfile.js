(function() {
    'use strict';

  var gulp = require('gulp-help')(require('gulp'));
  var plugins = require('gulp-load-plugins')();

  var _ = require('lodash');
  var async = require('async');
  var beep = require('beepbeep');
  var connectLr = require('connect-livereload');
  var del = require('del');
  var express = require('express');
  var fs = require('fs');
  var open = require('open');
  var path = require('path');
  var pg = require('pg');
  var replace = require('gulp-replace-task');
  var runSequence = require('run-sequence');
  var sh = require('shelljs');
  var stylish = require('jshint-stylish');
  var streamqueue = require('streamqueue');

  var allTestsFilename = 'all_tests.js';
  var appName = 'app';
  var confBase = require('./tests/conf_base.js');
  var integrationTestDb = 'test_db';
  var paths = {
    sass: ['./scss/**/*.scss']
  };

  // this is the express server which will be initiated when gulp serve
  var server = null;

  /**
   * Parse arguments
   */
  var args = require('yargs')
      .alias('e', 'emulate')
      .alias('b', 'build')
      .alias('r', 'run')
      .alias('env', 'environment')
      // remove all debug messages (console.logs, alerts etc) from release build
      .alias('release', 'strip-debug')      
      .default('build', false)
      .default('port', 8100)
      .default('strip-debug', false)
      .default('environment', 'prod')
      .argv;

  var build = !!(args.build || args.emulate || args.run);
  var emulate = args.emulate;
  var run = args.run;
  var port = args.port;
  var buildApp = args.build;
  var stripDebug = !!args.stripDebug;
  var tmpDirectory = '.tmp';
  var wwwDirectory = 'www';
  var targetDir = path.resolve(build ? wwwDirectory : tmpDirectory);

  // if we just use emulate or run without specifying platform, we assume iOS in this case the value returned from yargs would just be true
  if (emulate === true) {
      emulate = 'ios';
  }
  
  if (run === true) {
      run = 'ios';
  }

  // clean target dir
  gulp.task('clean', function(done) {  
    if (args.dir !== undefined && args.dir.length > 0) {      
      targetDir = path.resolve(args.dir);      
    }

    return del([targetDir], done);
  });

  // precompile styles and concat with ionic.css
  gulp.task('styles', function() {

    var options = build ? { style: 'compressed' } : { style: 'expanded' };

    var cssStream = gulp.src('app/styles/**/*.css')
      .pipe(plugins.concatCss('all.min.css'))
      .on('error', function(err) {
        console.log('err: ', err);
        beep();
      });

    var ionicStream = gulp.src('bower_components/ionic/scss/ionic.scss')
      .pipe(plugins.cached('styles'))
      .pipe(plugins.sass(options))
      .pipe(plugins.remember('styles'))
      .on('error', function(err) {
          console.log('err: ', err);
          beep();
        });

    return streamqueue({ objectMode: true }, ionicStream, cssStream)
      .pipe(plugins.autoprefixer('last 1 Chrome version', 'last 3 iOS versions', 'last 3 Android versions'))
      .pipe(plugins.concat('main.css'))
      .pipe(plugins.cleanCss())
      .pipe(plugins.if(build, plugins.stripCssComments()))
      .pipe(plugins.if(build && !emulate, plugins.rev()))
      .pipe(gulp.dest(path.join(targetDir, 'styles')))
      .on('error', errorHandler);
  });

  // build templatecache, copy scripts.
  // if build: concat, minsafe, uglify and versionize
  gulp.task('scripts', function() {
    var dest = path.join(targetDir, 'scripts');

    var minifyConfig = {
      collapseWhitespace: true,
      collapseBooleanAttributes: true,
      removeAttributeQuotes: true,
      removeComments: true
    };

    // prepare angular template cache from html templates
    // (remember to change appName var to desired module name)
    var templateStream = gulp
      .src('**/*.html', { cwd: 'app'})
      .pipe(plugins.angularTemplatecache('templates.js', {
        root: 'app/',
        module: 'app.core',
        htmlmin: build && minifyConfig
      }));

    var scriptStream = gulp
      .src(
      [
        'templates.js', 
        'app.module.js', 
        'app.run.js', 
        'app.config.js', 
        'app.routes.js', 
        'app.constants.js', 
        'app.filters.js',
        '!app.constants.template.js',
        '**/*.module.js',
        '**/*.js'
      ], 
        { cwd: 'app' })

      .pipe(plugins.if(!build, plugins.changed(dest)));

    return streamqueue({ objectMode: true }, scriptStream, templateStream)
      .pipe(plugins.if(build, plugins.ngAnnotate()))
      .pipe(plugins.if(stripDebug, plugins.stripDebug()))
      .pipe(plugins.if(build, plugins.concat('app.js')))
      .pipe(plugins.if(build, plugins.uglify()))
      .pipe(plugins.if(build && !emulate, plugins.rev()))

      .pipe(gulp.dest(dest))

      .on('error', errorHandler);
  });

  // copy fonts
  gulp.task('fonts', function() {
    return gulp
      .src(['app/fonts/*.*', 'bower_components/ionic/fonts/*.*'])

      .pipe(gulp.dest(path.join(targetDir, 'fonts')))

      .on('error', errorHandler);
  });

  // copy templates
  gulp.task('templates', function() {
    return gulp.src('app/**/*.html')
      .pipe(gulp.dest(path.join(targetDir, 'templates')))

      .on('error', errorHandler);
  });

  // copy images
  gulp.task('images', function() {
    return gulp.src('app/images/**/*.*')
      .pipe(gulp.dest(path.join(targetDir, 'img')))

      .on('error', errorHandler);
  });

  // lint js sources based on .jshintrc ruleset
  gulp.task('jsHint', function(done) {
    return gulp
      .src(['app/**/*.js', '!app/app.constants.template.js'])
      .pipe(plugins.jshint())
      .pipe(plugins.jshint.reporter(stylish))

      .on('error', errorHandler);
  });

  // concatenate and minify vendor sources
  gulp.task('vendor', function() {
    var vendorFiles = require('./vendor.json');

    return gulp.src(vendorFiles)
      .pipe(plugins.concat('vendor.js'))
      .pipe(plugins.if(build, plugins.uglify()))
      .pipe(plugins.if(build, plugins.rev()))

      .pipe(gulp.dest(targetDir))

      .on('error', errorHandler);
  });

  // copy i18n files
  gulp.task('i18n', function() {
    return gulp.src(['i18n/**/*'])
      .pipe(gulp.dest(targetDir));
  });

  // inject the files in index.html
  gulp.task('index', ['jsHint', 'scripts'], function() {

    // build has a '-versionnumber' suffix
    var cssNaming = 'styles/main*';

    return gulp.src('app/index.html')
      // inject css
      .pipe(_inject(gulp.src(cssNaming, { cwd: targetDir }), 'app-styles'))
      // inject vendor.js
      .pipe(_inject(gulp.src('vendor*.js', { cwd: targetDir }), 'vendor'))
      // inject app.js (build) or all js files indivually (dev)
      .pipe(plugins.if(build,
        _inject(gulp.src('scripts/app*.js', { cwd: targetDir }), 'app'),
        _inject(_getAllScriptSources(), 'app')
      ))
      .pipe(gulp.dest(targetDir))
      .on('error', errorHandler);

      // injects 'src' into index.html at position 'tag'
    function _inject(src, tag) {
      return plugins.inject(src, {
        starttag: '<!-- inject:' + tag + ':{{ext}} -->',      
        addRootSlash: false
      });
    }

    // get all our javascript sources
    // in development mode, it's better to add each file seperately.
    // it makes debugging easier.
    function _getAllScriptSources() {
      var scriptStream = gulp.src([
        'scripts/app.module.js', 
        'scripts/app.run.js', 
        'scripts/app.config.js', 
        'scripts/app.routes.js', 
        'scripts/app.constants.js', 
        'scripts/app.filters.js',
        'scripts/**/*.module.js',
        'scripts/**/*.js'
      ], { cwd: targetDir });
      return streamqueue({ objectMode: true }, scriptStream);
    }
  });

  // start local express server
  gulp.task('serve', function(done) {
    fs.exists(targetDir,  function(err, stat) {
        if (err == null) {
            runSequence(
              'serve_app',
              done);
        } else {
            runSequence(  
              'build',
              'serve_app',
              done);
        }
    });
  });

  gulp.task('serve_app', function() {
    express()
        .use(!build ? connectLr() : function(){})
        .use(express.static(targetDir))
        .listen(port);
  });

  // ionic emulate wrapper
  gulp.task('ionic:emulate', plugins.shell.task([
    'ionic emulate ' + emulate + ' --livereload --consolelogs'
  ]));

  // ionic run wrapper
  gulp.task('ionic:run', plugins.shell.task([
    'ionic run ' + run
  ]));

  // ionic build wrapper
  gulp.task('ionic:build', plugins.shell.task([
    'ionic build ' + buildApp
  ]));

  // start watchers
  gulp.task('watchers', function() {
    plugins.livereload.listen();
    gulp.watch(['app/styles/**/*.scss', 'app/styles/**/*.css'], ['styles']);
    gulp.watch('app/fonts/**', ['fonts']);
    //gulp.watch('app/icons/**', ['iconfont']);
    gulp.watch('app/images/**', ['images']);
    gulp.watch('app/**/*.js', ['index']);
    gulp.watch('./vendor.json', ['vendor']);
    gulp.watch('app/**/*.html', ['index']);
    gulp.watch('app/index.html', ['index']);
    gulp.watch(targetDir + '/**')
      .on('change', plugins.livereload.changed)
      .on('error', errorHandler);
  });

  // no-op = empty function
  gulp.task('noop', function() {});

  gulp.task('install', ['git-check'], function() {
    return bower.commands.install()
      .on('log', function(data) {
        plugins.gutil.log('bower', plugins.gutil.colors.cyan(data.id), data.message);
      });
  });

  gulp.task('git-check', function(done) {
    if (!sh.which('git')) {
      console.log(
        '  ' + plugins.gutil.colors.red('Git is not installed.'),
        '\n  Git, the version control system, is required to download Ionic.',
        '\n  Download git here:', plugins.gutil.colors.cyan('http://git-scm.com/downloads') + '.',
        '\n  Once git is installed, run \'' + plugins.gutil.colors.cyan('gulp install') + '\' again.'
      );
      process.exit(1);
    }
    done();
  });

  gulp.task('update_constants_app', function () {
    var env = args.env || 'prod';
    var filename = env + '.json';
    var settings = JSON.parse(fs.readFileSync('./config/' + filename, 'utf8'));

    return updateConstants(settings);
  });

  gulp.task('update_constants_circleci', function () {  
    var settings = {
      "apiHostDevelopment" : args.ip,
      "defaultConnection" : 0
    };

    return updateConstants(settings);
  });

  function updateConstants(settings) {
    return gulp.src('app/app.constants.template.js')  
      .pipe(replace({
        patterns: _.map(_.keys(settings), function(key){ 
            return { match: key, replacement: settings[key] };
          })
        }))
      .pipe(plugins.rename('app.constants.js'))
      .pipe(gulp.dest('app'));
  }

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

  gulp.task('dump_db', plugins.shell.task(
    ['pg_dump ' + integrationTestDb + ' > ./tests/fixtures/data.sql'])
  );

  gulp.task('restore_db', ['postgres_disconnect'], plugins.shell.task(
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
      .pipe(plugins.protractor.protractor({
          configFile: "./tests/conf_dev.js"
      }))
      .on('error', function(e) { throw e; });
  });

  gulp.task('protractor_docker', ['docker_selenium_debug_ip_ports'], function() {  
    gulp.src(["./tests/*.js"])
      .pipe(plugins.protractor.protractor({
          configFile: "./tests/conf_dev.js",
          args: ['--seleniumAddress', 'http://' + dockerSeleniumDebugIpPorts.ip + ':' + dockerSeleniumDebugIpPorts.selenium_port + '/wd/hub']
      }))
      .on('error', function(e) { throw e; });    
  });

  gulp.task('protractor_android',  function() {
    gulp.src(['./tests/*.js'])
      .pipe(plugins.protractor.protractor({
          configFile: "./tests/conf_android.js"        
      }))
      .on('error', function(e) { throw e; });
  });

  gulp.task('protractor_watch', function () {   
    gulp.watch(['./tests/**/*.js'], ['protractor']);
  });

  gulp.task('build', function(done) {
    runSequence(
      'update_constants_app',      
      'clean',
      [
        'fonts',
        'templates',
        'styles',
        'images',
        'vendor',
        'i18n'
      ],
      'index',
      done);
  });

  gulp.task('copy_tmp_to_www', function(done) {
    return gulp.src([tmpDirectory + '/**/*'])          
          .pipe(gulp.dest(wwwDirectory));
  });

  gulp.task('build_www', function(done) {
    runSequence(
      'build',
      'copy_tmp_to_www',
      done);      
  });

  gulp.task('default', function(done) {
    runSequence(
      'build',
      build ? 'noop' : 'watchers',
      build ? 'noop' : 'serve',
      emulate ? ['ionic:emulate', 'watchers'] : 'noop',
      run ? 'ionic:run' : 'noop',
      buildApp ? 'ionic:build' : 'noop',
      done);
  });

  // global error handler
  function errorHandler(error) {
    console.log('error: ', error);
    beep();
    if (build) {
      throw error;
    } else {
      plugins.util.log(error);
    }
  }
})();