(function() {
    'use strict';

    angular
        .module('app.login')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('login', {
                url: '/login',
                cache: false,
                templateUrl: 'app/login/login.html',
                controller: 'Login',
                controllerAs: 'vm',
                data: {
                    requireLogin: false
                }
            });
    }
})();
