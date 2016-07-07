#!/bin/bash
rm -f release_files/eTrips*
rm -f release_files/manifest.plist

gulp --env prod --build true

ionic platform remove ios
ionic platform add ios

ruby recreate_user_schemes.rb
fastlane ios_set_team_id
fastlane ios_build_provision_profile
fastlane ios_build_ipa

cp ./resources/icon.png ./release_files/eTrips-full-size-image.png
cp ./resources/ios/icon/icon.png ./release_files/eTrips-display-image.png
mv ./release_files/manifest.plist ./release_files/eTrips-manifest.plist