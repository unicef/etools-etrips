(function() {
    'use strict';

    angular
        .module('app.trips')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('app.dash.my_trip-detail', {
                url: '/my_trips/:tripId',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/trips/trip_details.html',
                        controller: 'TripDetails',
                        controllerAs: 'vm'
                    }
                }
            })
            .state('app.dash.supervised-detail', {
                url: '/supervised/:tripId',
                views: {
                    'tab-supervised': {
                        templateUrl: 'app/trips/trip_details.html',
                        controller: 'TripDetails',
                        controllerAs: 'vm'
                    }
                }
            });
    }
})();
