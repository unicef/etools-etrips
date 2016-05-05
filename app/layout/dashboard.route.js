(function() {
    'use strict';

    angular
        .module('app.login')
        .config(config);

    function config($stateProvider) {
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
            }
        );
    }
})();
