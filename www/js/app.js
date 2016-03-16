angular.module('equitrack', [  
    'app.core',
    'equitrack.controllers',
    'equitrack.services',
    'equitrack.utils',
    'equitrack.tripControllers',
    'equitrack.directives'
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