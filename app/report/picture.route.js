(function() {
    'use strict';

    angular
        .module('app.report')
        .config(config);

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('app.dash.reporting_picture',{
                url: '/my_trips/:tripId/reporting/picture',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/report/picture.html',
                        controller: 'Picture',
                        controllerA: 'vm'
                    }
                }
            }
        );
    }

})();