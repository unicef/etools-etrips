exports.config = {
    seleniumAddress: 'http://localhost:4723/wd/hub',

    specs: [ 
        'all_tests.js'
    ],

    exclude: [
        'conf_dev.js',
        'conf_base.js',
        'auth.js',
        '*.txt'
    ],

    framework: 'mocha',
    
    mochaOpts: {        
        reporter: 'spec',
        timeout: 10000
    },


    capabilities: {
        platformName: 'android',
        platformVersion: '5.1.1',
        deviceName: 'oneplusone',
        browserName: "",
        autoWebview: true,        
        app: '/Users/chris/unicef/EquiTrackMobile/platforms/android/build/outputs/apk/android-debug.apk'        
    },
    baseUrl: 'http://10.0.2.2:8000',

    // configuring wd in onPrepare
    // wdBridge helps to bridge wd driver with other selenium clients
    // See https://github.com/sebv/wd-bridge/blob/master/README.md
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
        global.urlBase = 'http://192.168.1.254:8100';

        global.waitForElement = function(selector, timeout) {
            if (_.isUndefined(timeout)) {
                timeout = 10000;
            }

            browser.wait(function() {
                return element(by.css(selector)).isPresent();
            }, timeout);
        };

        var wd = require('wd'),
            protractor = require('protractor'),
            wdBridge = require('wd-bridge')(protractor, wd);
        wdBridge.initFromProtractor(exports.config);
    }
};
