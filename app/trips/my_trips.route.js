(function() {
    'use strict';

    angular
        .module('app.trips')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('app.dash.my_trips', {
                url: '/my_trips?refreshed',
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
