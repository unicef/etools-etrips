angular.module('equitrack', [  
    'app.core',
    'app.widgets',
    'equitrack.controllers',
    'equitrack.services',
    'equitrack.tripControllers'    
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
    'equitrack.services'
]);