(function() {
    'use strict';

    angular
        .module('app.trips')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('app.dash.add_trip', {
                url: '/add_trip',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/trips/add_trip.html',
                        controller: 'AddTrip',
                        controllerAs: 'vm'
                    }
                }
            });
    }
})();
