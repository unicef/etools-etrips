exports.config = {
    framework: 'mocha',
    specs: [ 'login.js'],
    exclude: ['conf_dev.js', 'conf_base.js', '*.txt'],

    mochaOpts: {        
        reporter: 'spec'
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

        Object.defineProperty(
            protractor.promise.Promise.prototype,
            'should',
            Object.getOwnPropertyDescriptor(Object.prototype, 'should')
        );

        browser.manage().window().setSize(640, 1136);
    },

    // capabilities: {
    //     browserName: 'chrome',
    //     shardTestFiles: true,
    //     maxInstances: 2
    // },    
}