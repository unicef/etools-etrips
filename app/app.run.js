(function() {
    'use strict';

    angular
        .module('app.core')
        .run(runBlock);

    runBlock.$inject = ['$ionicPlatform', '$rootScope', '$state', '$http', 'apiUrlService', 'localStorageService', 'actionPointsService'];

    function runBlock($ionicPlatform, $rootScope, $state, $http, apiUrlService, localStorageService, actionPointsService) {
        $rootScope.$on('$stateChangeStart', function (event, toState, toParams) {
            var requireLogin = toState.data.requireLogin;

            if (requireLogin && !Object.keys(localStorageService.getObject('currentUser')).length) {
                event.preventDefault();
                $state.go('login');
            }

            if (toState.data.redirect) {
                event.preventDefault();
                $state.go(toState.data.redirect);
            }
        });

        $rootScope.$on('$cordovaNetwork:online', function(event, networkState){
            actionPointsService.submitOfflineActionPoints();
        });
 
        $ionicPlatform.ready(function() {
            if (window.StatusBar) {
                StatusBar.styleDefault();
            }
        });
    }    
})();
