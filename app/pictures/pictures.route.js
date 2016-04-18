(function() {
    'use strict';

    angular
        .module('app.pictures')
        .config(config);

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('app.dash.reporting_picture',{
                url: '/my_trips/:tripId/pictures',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/pictures/pictures.html',
                        controller: 'Pictures',
                        controllerAs: 'vm'
                    }
                }
            })

            .state('app.dash.reporting_picture_edit',{
                url: '/my_trips/:tripId/pictures_edit',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/pictures/pictures_edit.html',
                        controller: 'PicturesEdit',
                        controllerAs: 'vm'
                    }
                }
            }
        );
    }

})();