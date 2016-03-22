angular.module('app', [  
    /* shared modules */
    'app.core',
    'app.components',

    /* featured areas */
    'app.layout',
    'app.login',
    'app.settings',
    'app.trips'
]);

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
    'app.components'
]);

angular.module('app.notes', [
]);

angular.module('app.report', [
]);

angular.module('app.settings', [
]);

angular.module('app.trips', [
    'app.notes',
    'app.report'
]);

angular.module('app.components', [
]);
