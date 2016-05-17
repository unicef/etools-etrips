(function() {
    'use strict';

    angular
        .module('app.core')
        .service('dataService', dataService);

    function dataService($timeout, $translate, apiUrlService, localStorageService, myHttpService, networkService) {
        var service = {
            getProfile: getProfile,
            getTrips: getTrips,
            getTripsRemote: getTripsRemote,
            getUserBase: getUserBase,
            getUsersRemote: getUsersRemote,
            refreshTrips: refreshTrips,
            patchTrip: patchTrip,
        };

        return service;

        function getProfile(success, error) {
            myHttpService.get(apiUrlService.BASE() + '/users/api/profile/').then(
                function(succ) {
                    var myUser = succ.data;
                    // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
                    myUser.user_id = myUser.id;
                    localStorageService.setObject('currentUser', myUser);
                    success(succ);
                },
                error
            );
        }

        function getTrips(success, error, refresh) {
            if ((refresh === true) || (!Object.keys(localStorageService.getObject('trips')).length)) {
                getTripsRemote(success, error);
            } else {
                return success(localStorageService.getObject('trips'));
            }
        }

        function getUserBase(success, error, refresh) {
            if ((refresh === true) ||
                (!Object.keys(localStorageService.getObject('users')).length) ||
                (!isUserListValid('users_timestamp'))) {

                if (isUserListValid('users_timestamp') === false && networkService.isOffline() === true) {
                    error($translate.instant('service.data.user_list_expired.template'));
                } else {
                    getUsersRemote(success, error);
                }

            } else {
                return success(localStorageService.getObject('users'));
            }
        }

        function refreshTrips() {
            getTripsRemote(function() {}, function() {});
        }

        function patchTrip(tripId, data, success, fail) {
            return myHttpService.patch(apiUrlService.BASE() + '/trips/api/' + tripId + '/', data).then(
                function(succ) {
                    success(succ);
                },
                function(err) {
                    fail(err);
                }
            );
        }

        function isUserListValid(resource) {
            var userListTimestamp = localStorageService.get(resource);
            if (!userListTimestamp) {
                return false;
            }
            userListTimestamp = new Date(Number(userListTimestamp));
            var now = new Date();

            return (now < userListTimestamp);
        }

        function getTripsRemote(success, error) {
            return myHttpService.get(apiUrlService.BASE() + '/api/trips/').then(
                function(succ) {
                    localStorageService.setObject('trips', succ.data);
                    success(succ.data);
                },
                function(err) {
                    error(err);
                }
            );
        }

        function getUsersRemote(success, error) {
            return myHttpService.get(apiUrlService.BASE() + '/users/api/').then(
                function(succ) {
                    localStorageService.setObject('users', succ.data);

                    var expires = new Date();
                    expires.setMinutes(expires.getMinutes() + 5);
                    localStorageService.set('users_timestamp', expires.getTime() + '');
                    success(succ.data);
                },
                function(err) {
                    error(err);
                }
            );
        }
    }

})();
