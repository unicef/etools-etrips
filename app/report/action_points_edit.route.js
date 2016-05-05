(function() {
    'use strict';

    angular
        .module('app.report')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('app.dash.reporting_action_point_new', {
                url: '/my_trips/:tripId/reporting/action_point/new',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/report/action_points_edit.html',
                        controller: 'ActionPointsEdit',
                        controllerAs: 'vm'
                    }
                }
            })

            .state('app.dash.reporting_action_point_edit', {
                url: '/my_trips/:tripId/reporting/action_point/:actionPointId',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/report/action_points_edit.html',
                        controller: 'ActionPointsEdit',
                        controllerAs: 'vm'
                    }
                }
            }
        );
    }

})();
