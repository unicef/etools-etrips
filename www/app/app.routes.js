(function() {
    'use strict';

    angular
        .module('app.core')
        .config(config);

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('app.dash.notes',{
                url: '/my_trips/:tripId/notes',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'templates/trip/notes.html',
                        controller: 'NotesCtrl'
                    }
                }
            })  

            .state('home', {
                url: '',
                data: {
                    requireLogin: false,
                    redirect: "app.dash.my_trips",
                }
            });

        $urlRouterProvider.otherwise('login');
    }
})();