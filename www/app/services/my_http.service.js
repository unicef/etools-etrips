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

        function get(path, ignore_expiration) {
            return httpWrap('GET', path, false, ignore_expiration);
        }

        function post(path, data, ignore_expiration) {
            return httpWrap('POST', path, data, ignore_expiration);
        }

        function patch(path, data, ignore_expiration) {
            return httpWrap('PATCH', path, data, ignore_expiration);
        }

        function httpWrap(method, path, data, ignore_expiration) {
            var def = $q.defer();
            var req = {
                  method: method,
                  url: path
                };

            if (method != 'GET'){
                req.data = data;
            }

            if ((!ignore_expiration) && (tokenService.isTokenExpired())){
                $ionicLoading.hide();
                showConfirm(                  
                  $translate.instant('service.my_http.failed_relogin'),
                  confirmed_reLogin, 
                  failed_reLogin
                );
            } else {
                $http(req).then(
                    function(res){def.resolve(res);},
                    function(rej){def.reject(rej);}
                );
            }

            return def.promise;

            function confirmed_reLogin(res){
                $ionicLoading.show( { template: "<loading></loading>" });

                var relogin_cred = localStorageService.getObject('relogin_cred');
                relogin_cred.password = res;
                loginService.refreshLogin(
                    function(succ){
                        // continue with the action
                        console.log('managed to relogin', succ);
                        $http(req).then(
                            function(res){$ionicLoading.hide(); def.resolve(res);},
                            function(rej){$ionicLoading.hide(); def.reject(rej);}
                        );
                    },
                    function(fail){
                        def.reject(fail);
                    }
                    //relogin_cred;
                );
            }

            function failed_reLogin(){
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
            confirmPopup.then(function (res) {
                if (res) {
                    succ(res);
                } else {
                    fail(res);
                }
            });
        }               
    }

})();