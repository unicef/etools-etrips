(function() {
    'use strict';

    angular
        .module('app.core')
        .service('loginService', loginService);

    function loginService($q, $rootScope, localStorageService, authentication, apiUrlService) {
        var service = {
            loginUser: loginUser,
            logout: logout,
            refreshLogin: refreshLogin            
        };

        return service;

        function loginUser(data, retSuccess, retFail) {
            authentication.login(data).then(
                function(res){
                    successfulAuthentication(res, retSuccess);
                },
                function(err){
                    retFail(err);
                }
            );
        }

        function logout() {
            localStorageService.delete('jwtoken');
            localStorageService.delete('currentUser');
            localStorageService.delete('trips');
            localStorageService.delete('users');
            localStorageService.delete('tokenClaims');
        }        

        function refreshLogin(retSuccess, retFail, data) {
            if (!data){
                data = localStorageService.getObject('relogin_cred');
            }

            if (!data){
                console.log('No credentials were provided for relogin');
                retFail();
                return;
            }

            authentication.login(data).then(
                function(res){
                    successfulAuthentication(res, retSuccess);
                },
                function(err){
                    retFail(err);
                }
            );
        }

        function successfulAuthentication(res, retSuccess) {
            var JWToken;
            
            if (apiUrlService.ADFS){
                console.log(res);
                var mys;
                var r;
                var encoded_token;
                mys = res.data.substr(res.data.indexOf('BinarySecurityToken'));
                r = mys.substr(mys.indexOf('>'));
                encoded_token = r.substr(1,r.indexOf('<')-1);

                JWToken = authentication.urlBase64Decode(encoded_token);
            } else {
                JWToken = res.data.token;
            }

            localStorageService.set('jwtoken', JWToken);
            localStorageService.setObject('tokenClaims', authentication.getTokenClaims());

            retSuccess(localStorageService.get('jwtoken'));
        }
    }

})();