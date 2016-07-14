var clear = require('clear');
var colors = require('colors');
require('shelljs/global');

clear();
console.time('Build time');
console.log(colors.underline.bold.white('eTrips Build: iOS\n'));

rm('-f', './release_files/eTrips*');
rm('-f', './release_files/manifest.plist');

exec('gulp --env prod --build true');
exec('ionic platform remove ios');
exec('ionic platform add ios');

exec('ruby recreate_user_schemes.rb');
exec('fastlane ios_set_team_id');
exec('fastlane ios_build_provision_profile');
exec('fastlane ios_build_ipa');

cp('./resources/icon.png', './release_files/eTrips-full-size-image.png');
cp('./resources/ios/icon/icon.png', './release_files/eTrips-display-image.png');
mv('./release_files/manifest.plist', './release_files/eTrips-manifest.plist');

console.log('');
console.timeEnd('Build time');
console.log('');