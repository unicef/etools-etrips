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

Install required Ionic platforms:

```bash
$ ionic platform add ios
$ ionic platform add android

Update Selenium webdriver for integration tests:

```bash
$ webdriver-manager update
```

Run Application
---------------

In a browser:

```bash
$ ionic serve
```

Or in iOS or Android:

```bash
$ ionic build [ios/android]
$ ionic emulate [ios/android]
```

Run Integration Tests
---------------------

Start Selenium webdriver:

```bash
$ webdriver-manager start
```

In a separate terminal, start Ionic service:

```bash
$ ionic serve
```

Run protractor tets:

```bash
$ protractor tests/config_dev.js
```