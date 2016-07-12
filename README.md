eTrips
=====================

Installation
------------

Install required Cordova files:

```bash
$ sudo npm install -g cordova
```

Install required Ionic files:

```bash
$ sudo npm install -g ionic
```

Using git, clone to a local directory:

```bash
$ git clone https://github.com/unicef/eTools-eTrips
```

Install required development node.js packages:

```bash
$ npm install
```

Install Protractor testing framework:

```bash
$ sudo npm install -g protractor
```

Install Mocha for reporting and testing:

```bash
$ sudo npm install -g mocha
```

Install Bower for building:

```bash
$ npm install -g bower
```

Install required Ionic platforms:

```bash
$ mkdir www
$ ionic state reset
```

Install Bower components (and select latest version of Angular):

```bash
$ bower install
```

Update Selenium webdriver for integration tests:

```bash
$ ./node_modules/protractor/bin/webdriver-manager update
```

Build application and start Express server

```bash
$ gulp default --env [local/prod/test]
```

Optional: Integration tests can also be run using Docker
- install Docker Toolbox: https://www.docker.com/products/docker-toolbox


Build Application
-----------------

To build and copy the application from a temporary to www folder (to run Ionic commands):

```bash
$ gulp build_www --env [local/prod/test]
```

Build Application (iOS)
---------------------------

To build an iOS app (IPA), run the following commands to install the required components:

```bash
$ sudo gem install xcodeproj
$ sudo gem install fastlane --verbose
```

To generate the IPA file:

```bash
$ ./build_ios.sh
```

The IPA file can be installed to an iOS device using Xcode (Window -> Devices) and drag / drop the file.

Build Application (Android)
---------------------------

To build an Android app, run the following command with the required parameters:

```bash
./build_android.sh [path_to_properties_file] [path_to_keystore] [crosswalk | native | all]
./build_android.sh ~/Desktop/eTrips.properties ~/Desktop/eTrips.keystore native
```

path_to_properties_file = path of the file that defines the keystore file name and password for keystore integrity
path_to_keystore = path of the keystore
crosswalk = create a build with Crosswalk included (https://crosswalk-project.org/) - a Chromiun browser. Used to create build for older browsers.
native = create a native build
all = create crosswalk and native builds


Bump Application Version
------------------------

To bump and sync config.xml, package.json and bower.json semantic versions:

```bash
$ gulp bump --patch
$ gulp bump --minor
$ gulp bump --major
$ gulp bump --setversion=2.1.0
```

Run Application
---------------

In a browser:

```bash
$ gulp serve --env [local/prod/test]
```

In a simulated device:

```bash
$ gulp --build [ios/android] --env [local/prod/test]
$ gulp --emulate [ios/android] --env [local/prod/test]
```

On an attached device

```bash
$ gulp --build [ios/android] --env [local/prod/test]
$ gulp --run [ios/android] --env [local/prod/test]
```

Run Integration Tests (local browser)
-------------------------------------

Start Selenium webdriver:

```bash
$ ./node_modules/protractor/bin/webdriver-manager start
```

In a separate terminal, start Ionic service:

```bash
$ gulp serve --env [local/prod/test]
```

Run protractor tests:

```bash
$ protractor tests/conf_dev.js
```

Optional: Run Integration Tests (Docker)
----------------------------------------

Start Docker Quickstart Terminal:

```bash
Applications => Docker => Docker Quickstart Terminal
```

Start Docker Selenium Grid (Chrome):

```bash
$ cd <eTrips directory>
$ gulp docker_selenium_start
```

Run protractor tests:

```bash
$ gulp protractor_docker
```

Access the Docker Selenium Grid image using VNC (optional):

```bash
$ gulp docker_selenium_vnc
```

Optional: Run Integration Tests (Android device)
------------------------------------------------

Appium will be used to run the tests on an Android (non-emulator) device. Appium is an open source test automation framework for use with native, hybrid and mobile web apps. It drives iOS and Android apps using the WebDriver protocol.

To enable the tests to be run on the device:
1. Connect the device to your local computer via USB
2. Enable Android Debugging (Settings => Developer options => "Android Debugging")

Install Appium and WebDriver Protocol:

```bash
npm install -g appium
npm install -g wd
```

Update tests/conf_android.js to match the Android device values:

```js
  capabilities: {
        platformName: 'android',
        platformVersion: '5.1.1',
        deviceName: 'oneplusone',
        browserName: "",
        autoWebview: true,
        app: '/Users/chris/unicef/eTrips/platforms/android/build/outputs/apk/android-debug.apk'
    },
```

Generate APK:

```bash
$ ionic build android
```

Start Appium:

```bash
$ appium
```

Run tests using Gulp:

```bash
gulp protractor_android
```
