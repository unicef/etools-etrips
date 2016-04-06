angular.module('app', [  
    /* shared modules */
    'app.core',
    'app.components',

    /* featured areas */
    'app.components',
    'app.layout',
    'app.login',
    'app.notes',
    'app.report',
    'app.pictures',
    'app.settings',    
    'app.trips'
]);

angular.module('app.core', [
    /* ionic core */
    'ionic',

    /* angular modules */
    'ngCookies',
    'ngCordova',
    'ngLodash',

    /* 3rd-party modules */
    'ngIOS9UIWebViewPatch',
    'pascalprecht.translate',
    'tmh.dynamicLocale'
]);