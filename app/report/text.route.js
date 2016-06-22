(function() {
    'use strict';

    angular
        .module('app.report')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('app.dash.reporting_text',{
                url: '/my_trips/:tripId/reporting/text',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/report/text.html',
                        controller: 'Text',
                        controllerAs: 'vm'
                    }
                }
            }
        );
    }

})();
