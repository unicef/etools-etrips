(function() {
    'use strict';

    angular
        .module('app.core')
        .config(config);

    // TODO: move states to individual modules
    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('app', {
                url: '/app',
                abstract: true,
                templateUrl: 'templates/menu.html',
                controller: 'AppCtrl',
                data: {
                    requireLogin: true // this property, if set on app will apply to all of its children
                }
            })
            
            .state('app.settings',{
                url: '/settings',
                views: {
                    'menuContent': {
                        templateUrl: 'templates/settings/settings.html',
                        controller: 'SettingsCtrl'
                    }
                }
            })

            .state('app.connection',{
                url: '/settings/connection',
                views: {
                    'menuContent': {
                        templateUrl: 'templates/settings/connection.html',
                        controller: 'SettingsConnectionCtrl'
                    }
                },
                data: {
                    requireLogin: false
                }
            })

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

            .state('app.dash', {
                url: '/dash',
                abstract: true,
                views: {
                    'menuContent': {
                        templateUrl: 'templates/dash.html',
                        controller: 'DashCtrl'
                    }
                }
            })

            .state('app.dash.my_trip-detail', {
                url: '/my_trips/:tripId',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'templates/dash/trip.html',
                        controller: 'TripDetailCtrl'
                    }
                }
            })

            .state('app.dash.my_trips', {
                url: '/my_trips',
                views: {
                    'tab-trips': {
                        templateUrl: 'templates/dash/my-trips.html',
                        controller: 'MyTripsCtrl'
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

            .state('app.dash.supervised', {
                url: '/supervised',
                views: {
                    'tab-supervised': {
                        templateUrl: 'templates/dash/supervised.html',
                        controller: 'SupervisedCtrl'
                    }
                }
            })

            .state('app.dash.supervised-detail', {
                url: '/supervised/:tripId',
                views: {
                    'tab-supervised': {
                        templateUrl: 'templates/dash/trip.html',
                        controller: 'TripDetailCtrl'
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
    }
})();