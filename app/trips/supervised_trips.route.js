(function() {
    'use strict';

    angular
        .module('app.trips')
        .config(config);

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('app.dash.supervised', {
                url: '/supervised',
                views: {
                    'tab-supervised': {
                        templateUrl: 'app/trips/supervised_trips.html',
                        controller: 'SupervisedTrips',
                        controllerAs: 'vm'
                    }
                }
            });
    }
})();