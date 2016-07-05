#!/bin/bash
gulp --env prod --build android

if [ ! -f "$1" ]; then
    printf "\nAndroid properties not found\n\n"
    exit
fi

if [ ! -f "$2" ]; then
    printf "\nAndroid keystore not found\n\n"
    exit
fi

rm -fr platforms/android/build/outputs/*
rm -f release_files/android*

BUILD_MODE="all"
KEYSTORE_PATH="$2"

if [ "$3" = "crosswalk" ]; then
    BUILD_MODE="crosswalk"
    printf "\nBuilding Crosswalk\n"
fi

if [ "$3" = "native" ]; then
    BUILD_MODE="native"
    printf "\nBuilding native view (5+)\n"
fi

if [ "$BUILD_MODE" = "crosswalk" ] || [ "$BUILD_MODE" = "all" ]; then
    printf "\nBuilding Release mode for Crosswalk android...\n"
    printf "\n--------------------------------------------\n"
    printf "\nAdding Crosswalk...\n"
    ionic plugin add cordova-plugin-crosswalk-webview

    printf "\nAdding Ionic Platform: Android\n"
    ionic platform remove android
    ionic platform add android

    printf "\nBuilding Android Bundle\n"
    cp $1 platforms/android/release-signing.properties
    cp $2 platforms/android/
    ionic build android --release
    cp platforms/android/build/outputs/apk/android-armv7-release.apk release_files/
    cp platforms/android/build/outputs/apk/android-x86-release.apk release_files/

    printf "\n--------------------------------------------\n"
    printf "\nBuild complete. See release_files directory.\n"
    printf "\n"
fi

if [ "$BUILD_MODE" = "native" ] || [ "$BUILD_MODE" = "all" ]; then
    printf "\nBuilding Release mode for Android 5+...\n"
    printf "\n--------------------------------------------\n"
    rm -fr platforms/android/build/outputs/*
    mkdir -p release_files

    printf "\nAdding default browser...\n"
    ionic plugin remove cordova-plugin-crosswalk-webview
    ionic platform remove android
    ionic platform add android

    printf "\nBuilding Android Bundle\n"
    cp $1 platforms/android/release-signing.properties
    cp $2 platforms/android/
    ionic build android --release -- --minSdkVersion=21

    printf "\nCopied files to release_files\n"
    cp platforms/android/build/outputs/apk/android-release.apk release_files/
    printf "\n--------------------------------------------\n"
    printf "\nBuild complete. See release_files directory.\n"
    printf "\n"
fi