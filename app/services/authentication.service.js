(function() {
    'use strict';

    angular
        .module('app.core')
        .service('authentication', authentication);

    function authentication($http, localStorageService, apiUrlService, $window, soapEnvironmentService){
        var service = {
            signup: signUp,
            login: login,
            logout: logout,
            getTokenClaims: getClaimsFromToken,
            urlBase64Decode : urlBase64Decode
        };

        return service;

        function signUp(data, success, error) {
            $http.post(apiUrlService.BASE() + '/signup', data).success(success).error(error);
        }

        function login(data) {
           if (apiUrlService.ADFS){
               var req = {
                     method: 'POST',
                     url: soapEnvironmentService.adfsEndpoint,
                     headers: soapEnvironmentService.headers,
                     data: soapEnvironmentService.body(data.username, data.password)
                };

                return $http(req);
           } else {

               return $http.post(apiUrlService.BASE() + '/login/token-auth/', data);
           }
        }

        function logout(success) {
            localStorageService.delete('currentUser');
            localStorageService.delete('jwttoken');
            localStorageService.delete('trips');
            localStorageService.delete('users');
            localStorageService.delete('tokenClaims');
            success();
        }

        function urlBase64Decode(str) {
            var output = str.replace('-', '+').replace('_', '/');
            
            switch (output.length % 4) {
               case 0:
                   break;
               case 2:
                   output += '==';
                   break;
               case 3:
                   output += '=';
                   break;
               default:
                   throw 'Illegal base64url string!';
            }

            return $window.atob(output);
       }

       function getClaimsFromToken() {
           var token = localStorageService.get('jwtoken');        
           var user = {"no":"no"};

           if (typeof token !== 'undefined') {
               var encoded = token.split('.')[1];
               user = JSON.parse(urlBase64Decode(encoded));
           }

           return user;
       }       
    }

})();