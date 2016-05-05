(function() {
    'use strict';

    angular
        .module('app.login')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('app', {
                url: '/app',
                abstract: true,
                templateUrl: 'app/layout/application.html',
                controller: 'Application',
                controllerAs: 'vm',
                data: {
                    requireLogin: true
                }
            });
    }
})();
