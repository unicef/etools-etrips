(function() {
    'use strict';

    angular
        .module('app.core')
        .service('loginService', loginService);

    function loginService($q, $rootScope, localStorageService, authentication, apiUrlService, lodash) {
        var service = {
            loginUser: loginUser,
            logout: logout,
            refreshLogin: refreshLogin
        };

        return service;

        function loginUser(data, retSuccess, retFail) {
            authentication.login(data).then(
                function(res) {
                    successfulAuthentication(res, retSuccess);
                },
                function(err) {
                    retFail(err);
                }
            );
        }

        function logout() {
            if (localStorageService.getObject('currentUser').hasOwnProperty('profile') === true) {
                var _ = lodash;
                var country = localStorageService.getObject('currentUser').profile.country;
                var draftTrips = localStorageService.getObject('draft-' + country);

                _.each(draftTrips, function(trip) {
                    if (trip.hasOwnProperty('action_points')) {
                        // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
                        delete trip.action_points;
                    }
                });

                localStorageService.setObject('draft-' + country, draftTrips);
            }

            localStorageService.delete('jwtoken');
            localStorageService.delete('trips');
            localStorageService.delete('users');
            localStorageService.delete('tokenClaims');
            localStorageService.delete('currentUser');
        }

        function refreshLogin(retSuccess, retFail, data) {
            if (!data) {
                data = localStorageService.getObject('relogin_cred');
            }

            if (!data) {
                console.log('No credentials were provided for relogin');
                retFail();
                return;
            }

            authentication.login(data).then(
                function(res) {
                    successfulAuthentication(res, retSuccess);
                },
                function(err) {
                    retFail(err);
                }
            );
        }

        function successfulAuthentication(res, retSuccess) {
            var JWToken;

            if (apiUrlService.ADFS) {
                console.log(res);
                var mys;
                var r;
                var encodedToken;
                mys = res.data.substr(res.data.indexOf('BinarySecurityToken'));
                r = mys.substr(mys.indexOf('>'));
                encodedToken = r.substr(1, r.indexOf('<') - 1);

                JWToken = authentication.urlBase64Decode(encodedToken);
            } else {
                JWToken = res.data.token;
            }

            localStorageService.set('jwtoken', JWToken);
            localStorageService.setObject('tokenClaims', authentication.getTokenClaims());

            retSuccess(localStorageService.get('jwtoken'));
        }
    }

})();
