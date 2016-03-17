(function() {
    'use strict';

    angular
        .module('app.login')
        .config(config);

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('login', {
                url: '/login',
                cache: false,
                templateUrl: 'app/login/login.html',
                controller: 'Login as vm',
                data: {
                    requireLogin: false
                }
            });
    }
})();