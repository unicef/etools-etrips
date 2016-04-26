(function() {
    'use strict';

    angular
        .module('app.trips')
        .config(config);

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('app.dash.my_trips', {
                url: '/my_trips',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/trips/my_trips.html',
                        controller: 'MyTrips',
                        controllerAs: 'vm'
                    }
                }
            });
    }
})();