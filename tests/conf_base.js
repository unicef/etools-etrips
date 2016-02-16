exports.config = {
    specs: [ 
        'login.js'
    ],

    exclude: [
        'conf_dev.js',
        'conf_base.js',
        'auth.js',
        '*.txt'
    ],

    framework: 'mocha',
    seleniumServerJar: '../node_modules/protractor/selenium/selenium-server-standalone-2.51.0.jar',
    chromeDriver: '../node_modules/protractor/selenium/chromedriver',

    mochaOpts: {        
        reporter: 'spec',
        timeout: 10000
    },

    onPrepare: function () {
        global._ = require('lodash');
        global.fs = require('fs');
        global.path = require('path');
        global.chai = require('chai');
        global.should = chai.should();
        global.chaiAsPromised = require('chai-as-promised');
        global.chai.use(chaiAsPromised);
        global.faker = require('faker');
        global.auth = require('./auth.js');

        global.waitForElement = function(selector) {
            browser.wait(function() {
                return element(by.css(selector)).isPresent();
            }, 10000);
        };

        Object.defineProperty(
            protractor.promise.Promise.prototype,
            'should',
            Object.getOwnPropertyDescriptor(Object.prototype, 'should')
        );

        browser.manage().window().setSize(640, 1136);
    }
};