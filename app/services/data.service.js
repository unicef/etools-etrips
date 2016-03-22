(function() {
    'use strict';

    angular
        .module('app.core')
        .service('dataService', dataService);

    function dataService($timeout, apiUrlService, localStorageService, myHttpService) {
        var service = {
           getProfile: getProfile,
           getTrips: getTrips,
           getUserBase: getUserBase,
           refreshTrips: refreshTrips,
           patchTrip: patchTrip,
        };

        return service;

        function getProfile(success, error) {
           myHttpService.get(apiUrlService.BASE() + '/users/api/profile/').then(
               function(succ){
                   var myUser = succ.data;
                   myUser.user_id = myUser.id;                
                   localStorageService.setObject('currentUser', myUser);
                   success(succ);
               },
               error
            );
        }

        function getTrips(success, error, refresh) {
            if ((refresh === true) || (!Object.keys(localStorageService.getObject('trips')).length)){
                getTripsRemote(success, error);
            } else {
                return success(localStorageService.getObject('trips'));
            }
        }

        function getUserBase(success, error, refresh) {
           if ((refresh === true) ||
               (!Object.keys(localStorageService.getObject('users')).length) ||
               (!checkTimestamp('users_timestamp'))){
                
                getUsersRemote(success, error);

            } else {
                return success(localStorageService.getObject('users'));
            }
        }

        function refreshTrips(){
            getTripsRemote(function(){}, function(){});
        }

        function patchTrip(tripId, data, success, fail){
            return myHttpService.patch(apiUrlService.BASE() + '/trips/api/' + tripId +"/", data).then(
                function(succ){
                    success(succ);
                },
                function(err){
                    fail(err);
                }
            );
        }        

        function checkTimestamp(resource){
            var myt = localStorageService.get(resource);
            if (!myt) {
                return false;
            }
            myt = new Date(Number(myt));
            var now = new Date();

            return (now < myt);
        }

        function getTripsRemote(success, error){
            return myHttpService.get(apiUrlService.BASE() + '/api/trips/').then(
               function(succ){
                   localStorageService.setObject('trips',succ.data);
                   success(succ.data);
               },
               function(err){
                   error(err);
               }
            );
        }

        function getUsersRemote(success, error){
            return myHttpService.get(apiUrlService.BASE() + '/users/api/').then(
               function(succ){
                   localStorageService.setObject('users', succ.data);

                   var expires = new Date();
                   expires.setMinutes(expires.getMinutes()+5);
                   localStorageService.set('users_timestamp', expires.getTime()+'');
                   success(succ.data);
               },
               function(err){
                   error(err);
               }
            );
        } 
    }

})();