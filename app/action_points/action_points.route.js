(function() {
    'use strict';

    angular
        .module('app.action_points')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('app.dash.reporting_action_point',{
                url: '/my_trips/:tripId/reporting/action_point',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/action_points/action_points.html',
                        controller: 'ActionPoints',
                        controllerAs: 'vm'
                    }
                }
            }
        );
    }

})();
