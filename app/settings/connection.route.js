(function() {
    'use strict';

    angular
        .module('app.settings')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('app.connection', {
                url: '/settings/connection',
                views: {
                    'menuContent': {
                        templateUrl: 'app/settings/connection.html',
                        controller: 'Connection',
                        controllerAs: 'vm'
                    }
                },
                data: {
                    requireLogin: false
                }
            });
    }
})();
