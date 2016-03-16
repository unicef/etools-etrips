angular.module('equitrack', [
  'ionic',
  'ngIOS9UIWebViewPatch',
  'equitrack.controllers',
  'equitrack.services',
  'equitrack.utils',
  'equitrack.tripControllers',
  'equitrack.directives',
  'ngCookies',
  'pascalprecht.translate',// angular-translate
  'tmh.dynamicLocale'// angular-dynamic-locale
])

.run(function($ionicPlatform, $rootScope, $state, $http, API_urls, $localStorage) {

    $rootScope.$on('$stateChangeStart', function (event, toState, toParams) {

        var requireLogin = toState.data.requireLogin;

        if (requireLogin && !Object.keys($localStorage.getObject('currentUser')).length) {
          event.preventDefault();
          $state.go('login');
          // get me to the login page!
        }
        if (toState.data.redirect){
            event.preventDefault();
            $state.go(toState.data.redirect);
        }
    });
    $ionicPlatform.ready(function() {
        // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
        // for form inputs)
        //if (window.cordova && window.cordova.plugins.Keyboard) {
        //  cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
        //  cordova.plugins.Keyboard.disableScroll(true);
        //
        //};
        if (window.StatusBar) {
          // org.apache.cordova.statusbar required
          StatusBar.styleDefault();
        }
    });
})

.config(function($translateProvider, LOCALES) {
  $translateProvider.useMissingTranslationHandlerLog();
  $translateProvider.useSanitizeValueStrategy('escape');

  $translateProvider.useStaticFilesLoader({
    prefix: 'i18n/',
    suffix: '.json'
  });

  $translateProvider.preferredLanguage(LOCALES.preferredLocale);
  $translateProvider.useLocalStorage();
})

.config(function(tmhDynamicLocaleProvider) {
  tmhDynamicLocaleProvider.localeLocationPattern('locales/angular-locale_{{locale}}.js');
})

.config(["$stateProvider", "$urlRouterProvider", "$httpProvider",
        function($stateProvider, $urlRouterProvider, $httpProvider) {

  $httpProvider.interceptors.push(['$q', '$location', '$localStorage', function ($q, $location, $localStorage) {
       return {
           'request': function (config) {
               config.headers = config.headers || {};
               if ($localStorage.get('jwtoken')) {
                   config.headers.Authorization = 'JWT  ' + $localStorage.get('jwtoken');
               }
               return config;
           },
           'responseError': function (response) {
               if (response.status === 401 || response.status === 403) {
                   $location.path('/login');
               }
               return $q.reject(response);
           }
       };
  }]);

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
  .state('login', {
      url: '/login',
      cache: false,
      templateUrl: 'templates/login.html',
      controller: 'LoginCtrl',
      data: {
        requireLogin: false
      }
  })
  .state('home', {
      url: '',
      data: {
        requireLogin: false,
        redirect: "app.dash.my_trips",
      }
  });
  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('login');


}])

.constant('TripVars', {'checkboxes':['ta_drafted', 'security_granted'],
                       'cards': ['travel_routes', 'files', 'action_points',
                                 'trip_funds']
                      }
)

.filter('underscoreless', function () {
  return function (input) {
      return input.replace(/_/g, ' ');
  };
})
.filter('TitleCase', function(){
    return function(input){
        return input.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
    };
});