var argv = require('yargs').argv;
var clear = require('clear');
var colors = require('colors');
var fs = require('fs');
var _ = require('lodash');

require('shelljs/global');

var typeVariables = ['crosswalk', 'native', 'all'];
var buildMode = '';

clear();
console.time('Build time');
console.log(colors.underline.bold.white('eTrips Build: Android\n'));

if (_.isUndefined(argv.properties) === true) {
  console.log(colors.bold.red('ERROR:'));
  console.log(colors.red('Missing/Invalid argument: --properties=[path of properties file]'));
  console.log('');
  return false;
}

try {
  var stats = fs.statSync(argv.properties);
} catch(err) {
  console.log(colors.bold.red('ERROR:'));
  console.log(colors.red('Invalid properties file path'));
  console.log('');
  return false;
}

if (_.isUndefined(argv.keystore) === true) {
  console.log(colors.bold.red('ERROR:'));
  console.log(colors.red('Missing/Invalid argument: --properties=[path of keystore file]'));
  console.log('');
  return false;
}

try {
  var stats = fs.statSync(argv.keystore);
} catch(err) {
  console.log(colors.bold.red('ERROR:'));
  console.log(colors.red('Invalid keystore file path'));
  console.log('');
  return false;
}

if (_.isUndefined(argv.type) === true || _.includes(typeVariables, argv.type) === false) {
  console.log(colors.bold.red('ERROR:'));
  console.log(colors.red('Missing/Invalid argument: --type=[crosswalk | native | all]'));
  console.log('');
  return false;
} else {
  buildMode = argv.type;
}

exec('gulp --env prod --build android');
rm('-fr', './platforms/android/build/outputs/*');
rm('-f', './release_files/android-*');

if (argv.type === 'crosswalk') {
    consoleLogTimestamp('Building Crosswalk');

} else if (argv.type === 'native') {
    consoleLogTimestamp('Building native view (5+)');
}

if (buildMode === 'crosswalk' || buildMode === 'all') {
    consoleLogTimestamp('Building Release mode for Crosswalk android...');
    consoleLogTimestamp('--------------------------------------------');
    consoleLogTimestamp('Adding Crosswalk...');
    exec('ionic plugin add cordova-plugin-crosswalk-webview');

    consoleLogTimestamp('Adding Ionic Platform: Android');
    exec('ionic platform remove android');
    exec('ionic platform add android');

    consoleLogTimestamp('Building Android Bundle');
    cp(argv.properties, './platforms/android/release-signing.properties');
    cp(argv.keystore, './platforms/android/');
    exec('ionic build android --release');
    cp('./platforms/android/build/outputs/apk/android-armv7-release.apk', 'release_files/');
    cp('./platforms/android/build/outputs/apk/android-x86-release.apk', 'release_files/');

    consoleLogTimestamp('--------------------------------------------');
    consoleLogTimestamp('Build complete. See release_files directory.');
    consoleLogTimestamp('');
}

if (buildMode === 'native' || buildMode === 'all') {
    consoleLogTimestamp('nBuilding Release mode for Android 5+...');
    consoleLogTimestamp('--------------------------------------------');

    consoleLogTimestamp('Adding default browser...');
    exec('ionic plugin remove cordova-plugin-crosswalk-webview');
    exec('ionic platform remove android');
    exec('ionic platform add android');

    consoleLogTimestamp('Building Android Bundle');
    cp(argv.properties, './platforms/android/release-signing.properties');
    cp(argv.keystore, './platforms/android/');
    exec('ionic build android --release -- --minSdkVersion=21');

    consoleLogTimestamp('Copied files to release_files');
    cp('./platforms/android/build/outputs/apk/android-release.apk', 'release_files/');
    consoleLogTimestamp('--------------------------------------------');
    consoleLogTimestamp('Build complete. See release_files directory.');
}

console.log('');
console.timeEnd('Build time');
console.log('');

function consoleLogTimestamp(val) {
    var date = new Date();
    console.log(colors.green('[' + date.toISOString() + '] ' + val));
}