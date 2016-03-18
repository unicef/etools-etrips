angular.module('equitrack', [  
    /* shared modules */
    'app.core',
    'app.widgets',
    'equitrack.tripControllers',

    /* featured areas */
    'app.layout',
    'app.login',
    'app.settings',
    'app.trips'
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

angular.module('app.layout', [
]);

angular.module('app.login', [
    'app.core',
    'app.widgets'
]);

angular.module('app.report', [
]);

angular.module('app.settings', [
]);

angular.module('app.trips', [
    'app.report'
]);

angular.module('app.widgets', [
]);
