(function() {
    'use strict';

    angular
        .module('app.layout')
        .controller('Application', Application);

    Application.$inject = ['$ionicPlatform','$ionicPopup', '$state', '$translate', 'actionPointsService', 'localStorageService', 'loginService', 'networkService', 'lodash', 'VERSION'];

    function Application($ionicPlatform, $ionicPopup, $state, $translate, actionPointsService, localStorageService, loginService, networkService, _, VERSION) {
        var vm = this;
        vm.currentUser = localStorageService.getObject('currentUser');
        vm.logout = logout;
        vm.version = VERSION;

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
