(function() {
    'use strict';

    angular
        .module('app.layout')
        .controller('Application', Application);

    Application.$inject = ['$cordovaAppVersion', '$ionicPlatform','$ionicPopup', '$state', '$translate', 'actionPointsService', 'localStorageService', 'loginService', 'networkService', 'lodash'];

    function Application($cordovaAppVersion,$ionicPlatform, $ionicPopup, $state, $translate, actionPointsService, localStorageService, loginService, networkService, _) {
        var vm = this;
        vm.currentUser = localStorageService.getObject('currentUser');
        vm.logout = logout;
        vm.version = '';

        ionic.Platform.ready(function() {
            if (ionic.Platform.isWebView() === true) {
                $cordovaAppVersion.getVersionNumber().then(function (version) {
                    vm.version = version;
                });
            }
        });

        function logout() {
            if (networkService.isOffline() === true) {
                if (actionPointsService.getOfflineActionPointsCount() > 0) {
                    $ionicPopup.confirm({
                        title: $translate.instant('controller.application.logout.offline.title'),
                        template: $translate.instant('controller.application.logout.offline.template'),
                    }).then(function(result) {
                        if (result) {
                            $state.go('login');
                            loginService.logout();
                        }
                    });
                }
            } else {
                $state.go('login');
                loginService.logout();
            }
        }
    }

})();