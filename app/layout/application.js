(function() {
    'use strict';

    angular
        .module('app.layout')
        .controller('Application', Application);

    Application.$inject = ['$ionicPopup', 'loginService', 'localStorageService', '$state', 'networkService', 'actionPointsService', 'lodash', '$translate'];

    function Application($ionicPopup, loginService, localStorageService, $state, networkService, actionPointsService, _, $translate) {
        var vm = this;
        vm.currentUser = localStorageService.getObject('currentUser');
        vm.logout = logout;

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