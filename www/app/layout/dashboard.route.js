(function() {
    'use strict';

    angular
        .module('app.login')
        .config(config);

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('app.dash', {
                url: '/dash',
                abstract: true,
                views: {
                    'menuContent': {
                        templateUrl: 'app/layout/dashboard.html',
                        controller: 'Dashboard',
                        controllerAs: 'vm'
                    }
                }
            })

    }
})();