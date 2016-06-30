(function() {
    'use strict';

    angular
        .module('app.report')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('app.dash.reporting', {
                url: '/my_trips/:tripId/reporting',
                views: {
                    'tab-trips': {
                        templateUrl: 'app/report/report.html',
                        controller: 'Report',
                        controllerAs: 'vm'
                    }
                }
            }
        );
    }

})();
