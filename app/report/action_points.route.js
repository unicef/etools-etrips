(function() {
    'use strict';

    angular
        .module('app.report')
        .config(config);

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('app.dash.reporting_action_point',{      
                url: '/my_trips/:tripId/reporting/action_point',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/report/action_points.html',
                        controller: 'ActionPoints',
                        controllerAs: 'vm'
                    }
                }
            }
        );        
    }

})();