angular.module('equitrack', [  
    /* shared modules */
    'app.core',
    'app.widgets',
    'equitrack.controllers',
    'equitrack.tripControllers',

    /* featured areas */
    'app.login'
])

angular.module('app.core', [
    /* ionic core */
    'ionic',

    /* angular modules */
    'ngCookies',

    /* 3rd-party modules */
    'ngIOS9UIWebViewPatch',
    'pascalprecht.translate',
    'tmh.dynamicLocale'
]);

angular.module('app.widgets', [
]);

angular.module('app.login', [
    'app.core',
    'app.widgets'
]);