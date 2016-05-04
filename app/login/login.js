(function() {
    'use strict';

    angular
        .module('app.login')
        .controller('Login', Login);

    Login.$inject = ['$ionicPlatform', '$ionicHistory','$ionicLoading', '$ionicPopup', '$state', '$translate', 'actionPointsService', 'apiUrlService', 'authentication', 'dataService', 'localStorageService', 'loginService', 'networkService', 'lodash', 'tokenService'];

    function Login($ionicPlatform, $ionicHistory, $ionicLoading, $ionicPopup, $state, $translate, actionPointsService, apiUrlService, authentication, dataService, localStorageService, loginService, networkService, _, tokenService) {
        if (Object.keys(localStorageService.getObject('currentUser'))) {
            $state.go('app.dash.my_trips');
        }

        var vm = this;
        vm.data = localStorageService.getObject('user_cred');
        vm.login = login;
        vm.other = {};

        function login() {
            var loginData = vm.data;

            if (vm.other.rememberMe) {
                localStorageService.setObject('user_cred', {
                    username: loginData.username,
                    password: ''
                });
            } else {
                localStorageService.delete('user_cred');
            }

            if (networkService.isOffline()) {
                networkService.showMessage(
                    $translate.instant('controller.login.network_offline.title'),
                    $translate.instant('controller.login.network_offline.template')
                );

            } else {
                $ionicLoading.show({
                    template: '<loading></loading>'
                });
                localStorageService.setObject('relogin_cred', {
                    username: loginData.username,
                    password: ''
                }); //store the username in the background for re-login
                loginService.loginUser(loginData, loginSuccess, loginFail);
            }

            vm.data = {};
        }

        function loginSuccess() {
            dataService.getProfile(function() {
                    getTrips();
                },
                profileFail
            );

            dataService.getUsersRemote(function() {});

<<<<<<< HEAD
=======
            dataService.getUsersRemote(function(success){});

>>>>>>> a8514ce11a5eba129bd11429ab5798a69671cf59
            function getTrips() {
                dataService.getTrips(
                    function() {
                        $ionicLoading.hide();
                        $ionicHistory.nextViewOptions({
                            disableBack: true
                        });

                        $state.go('app.dash.my_trips');
                    },
                    function() {
                        $ionicLoading.hide();

                        $ionicPopup.alert({
                            title: $translate.instant('controller.login.success.title'),
                            template: $translate.instant('controller.login.success.template')
                        });
                    }, true
                );
            }

            function profileFail(error) {
                // user does not have a country yet or something went wrong on
                $ionicLoading.hide();

                var title = $translate.instant('controller.login.country.title');
                var template = $translate.instant('controller.login.country.template');

                if (error.data.detail === 'No country found for user') {
                    title = $translate.instant('controller.login.no_country.title');
                    template = $translate.instant('controller.login.no_country.template');
                }

                $ionicPopup.alert({
                    title: title,
                    template: template
                });

                return error;
            }
        }

        function loginFail() {
            $ionicLoading.hide();

            $ionicPopup.alert({
                title: $translate.instant('controller.login.fail.title'),
                template: $translate.instant('controller.login.fail.template')
            });
        }
    }

})();
