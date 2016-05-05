(function() {
    'use strict';

    angular
        .module('app.core')
        .service('tokenService', tokenService);

    function tokenService(localStorageService) {
        var service = {
            getClaimsFromToken: getClaimsFromToken,
            isTokenExpired: isTokenExpired
        };

        return service;

        function getClaimsFromToken() {
            var token = localStorageService.get('jwtoken');
            //console.log("getclaims", token);
            var user = {
                'no': 'no'
            };
            if (typeof token !== 'undefined') {
                var encoded = token.split('.')[1];
                user = JSON.parse(urlBase64Decode(encoded));
            }

            return user;
        }

        function isTokenExpired() {
            var token = localStorageService.getObject('tokenClaims');
            var now = new Date();

            if ((!Object.keys(token).length) ||
                ((token.exp * 1000) < now.getTime())) {
                return true;
            } else {
                return false;
            }
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
    }

})();
