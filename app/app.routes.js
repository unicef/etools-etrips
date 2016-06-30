(function() {
    'use strict';

    angular
        .module('app.core')
        .config(config);

    function config($stateProvider, $urlRouterProvider) {
        $urlRouterProvider.otherwise('login');
    }
})();
