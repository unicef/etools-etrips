(function() {
    'use strict';

    angular
        .module('app.core')
        .config(config);

    // TODO: move states to individual modules
    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('app.dash.reporting', {      
                url: '/my_trips/:tripId/reporting',
                views: {
                    'tab-trips': {
                        templateUrl: 'templates/trip/reporting.html',
                        controller: 'Report as vm',              
                    }
                }
            })

            .state('app.dash.reporting_text',{
                url: '/my_trips/:tripId/reporting/text',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'templates/trip/reporting-text.html',
                        controller: 'ReportingText as vm'
                    }
                }
            })

            .state('app.dash.reporting_picture',{
                url: '/my_trips/:tripId/reporting/picture',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'templates/trip/reporting-picture.html',
                        controller: 'ReportingPicture as vm'
                    }
                }
            })

            .state('app.dash.reporting_action_point',{      
                url: '/my_trips/:tripId/reporting/action_point',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'templates/trip/reporting-action-point.html',
                        controller: 'ReportingActionPoint as vm'
                    }
                }
            })

            .state('app.dash.reporting_action_point_new', {      
                url: '/my_trips/:tripId/reporting/action_point/new',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'templates/trip/reporting-action-point-edit.html',
                        controller: 'ReportingActionPointEdit as vm'
                    }
                }
            })

            .state('app.dash.reporting_action_point_edit', {    
                url: '/my_trips/:tripId/reporting/action_point/:actionPointId',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'templates/trip/reporting-action-point-edit.html',
                        controller: 'ReportingActionPointEdit as vm'
                    }
                }
            })

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