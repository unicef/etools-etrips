(function() {
    'use strict';

    angular
        .module('app.core')
        .service('myHttpService', myHttpService);

    function myHttpService($q, $http, localStorageService, $ionicPopup, loginService, $ionicLoading, tokenService, $translate) {
        var service = {
            get: get,
            post: post,
            patch: patch,
        };

        return service;

        function get(path, ignoreExpiration) {
            return httpWrap('GET', path, false, ignoreExpiration);
        }

        function post(path, data, ignoreExpiration) {
            return httpWrap('POST', path, data, ignoreExpiration);
        }

        function patch(path, data, ignoreExpiration) {
            return httpWrap('PATCH', path, data, ignoreExpiration);
        }

        function httpWrap(method, path, data, ignoreExpiration) {
            var def = $q.defer();
            var req = {
                method: method,
                url: path
            };

            if (method !== 'GET') {
                req.data = data;
            }

            if ((!ignoreExpiration) && (tokenService.isTokenExpired())) {
                $ionicLoading.hide();
                showConfirm(
                    $translate.instant('service.my_http.failed_relogin'),
                    confirmedRelogin,
                    failedRelogin
                );
            } else {
                $http(req).then(
                    function(res) {
                        def.resolve(res);
                    },
                    function(rej) {
                        def.reject(rej);
                    }
                );
            }

            return def.promise;

            function confirmedRelogin(res) {
                $ionicLoading.show({
                    template: '<loading></loading>'
                });

                var reloginCredentials = localStorageService.getObject('relogin_cred');
                reloginCredentials.password = res;
                loginService.refreshLogin(
                    function(succ) {
                        // continue with the action
                        console.log('managed to relogin', succ);
                        $http(req).then(
                            function(res) {
                                $ionicLoading.hide();
                                def.resolve(res);
                            },
                            function(rej) {
                                $ionicLoading.hide();
                                def.reject(rej);
                            }
                        );
                    },
                    function(fail) {
                        def.reject(fail);
                    }
                );
            }

            function failedRelogin() {
                def.reject('Cancelled by user');
            }
        }

        function showConfirm(template, succ, fail) {
            var confirmPopup = $ionicPopup.prompt({
                title: $translate.instant('service.my_http.session_expired.title'),
                template: template,
                inputType: 'password',
                inputPlaceholder: $translate.instant('service.my_http.session_expired.password')
            });
            confirmPopup.then(function(res) {
                if (res) {
                    succ(res);
                } else {
                    fail(res);
                }
            });
        }
    }

})();
