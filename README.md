EquiTrackMobile
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
$ git clone https://github.com/UNICEFLebanonInnovation/EquiTrackMobile .
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

Install required Ionic platforms:

```bash
$ ionic platform add ios
$ ionic platform add android
```

Update Selenium webdriver for integration tests:

```bash
$ ./node_modules/protractor/bin/webdriver-manager update
```

Build application and start Express server

```bash
$ gulp default
```

Optional: Integration tests can also be run using Docker
- install Docker Toolbox: https://www.docker.com/products/docker-toolbox


Run Application
---------------

In a browser:

```bash
$ gulp serve
```

In a simulated device:

```bash
$ gulp --build [ios/android]
$ gulp --emulate [ios/android]
```

On an attached device

```bash
$ gulp --build [ios/android]
$ gulp --run [ios/android]
```

Run Integration Tests (local browser)
-------------------------------------

Start Selenium webdriver:

```bash
$ ./node_modules/protractor/bin/webdriver-manager start
```

In a separate terminal, start Ionic service:

```bash
$ gulp serve
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
$ cd <EquiTrackMobile directory>
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
        app: '/Users/chris/unicef/EquiTrackMobile/platforms/android/build/outputs/apk/android-debug.apk'        
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


Setting Environment Variables
-----------------------------

Certain files must be modified based on the target environment (e.x. API hosts). To update those files:

```bash
$ gulp replace --env [prod | local | test]
```
