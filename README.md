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
$ webdriver-manager update
```

Optional: Integration tests can also be run using Docker
- install Docker Toolbox: https://www.docker.com/products/docker-toolbox


Run Application
---------------

In a browser:

```bash
$ ionic serve --all
```

Or in iOS or Android:

```bash
$ ionic build [ios/android]
$ ionic emulate [ios/android]
```

Run Integration Tests (local browser)
-------------------------------------

Start Selenium webdriver:

```bash
$ webdriver-manager start
```

In a separate terminal, start Ionic service:

```bash
$ ionic serve
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

Setting Environment Variables
-----------------------------

Certain files must be modified based on the target environment (e.x. API hosts). To update those files:

```bash
$ gulp replace --env [prod | local | test]
```
