(function() {
    'use strict';

    angular
        .module('app.core')
        .service('actionPointsService', actionPointsService);

    function actionPointsService($ionicPopup, $q, $rootScope, $translate, localStorageService, apiUrlService, tripService, dataService, lodash) {
        var _ = lodash;
        var service = {
            delete: deleteCache,
            get: get,
            getOfflineActionPoints: getOfflineActionPoints,
            getOfflineActionPointsCount: getOfflineActionPointsCount,
            setDraft: setCache,
            submitOfflineActionPoints: submitOfflineActionPoints
        };

        return service;

        function get(tripId, setCache) {
            setCache = typeof setCache !== 'undefined' ? setCache : true;
            // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
            var actionPoints = tripService.getTrip(tripId).actionpoint_set;

            if (setCache === true) {
                setCache(actionPoints);
            }

            return actionPoints;
        }

        function getOfflineActionPoints() {
            var country = localStorageService.getObject('currentUser').profile.country;
            var draftTrips = localStorageService.getObject('draft-' + country);
            var data = [];

            _.each(draftTrips, function(trip, tripId) {
                data.push({'tripId': tripId, 'actionPoints': trip.action_points});
            });

            return data;
        }

        function getOfflineActionPointsCount() {
            var offlineActionPoints = getOfflineActionPoints();
            var count = 0;

            _.each(offlineActionPoints, function(trips) {
                count = count + trips.actionPoints.length;
            });

            return count;
        }

        function deleteCache(tripId) {
            tripService.deleteDraft(tripId, 'action_points');
        }

        function setCache(tripId, actionPoints) {
            tripService.setDraft(tripId, 'action_points', actionPoints);
        }

        function submitOfflineActionPoints() {
            if (localStorageService.getObject('currentUser').hasOwnProperty('profile') === true) {
                var country = localStorageService.getObject('currentUser').profile.country;
                var draftTrips = localStorageService.getObject('draft-' + country);
                var promises = [];
                var tripIdWithActionPoints = [];

                _.each(draftTrips, function(trip, tripId) {
                    var actionPoints = trip.action_points;

                    _.each(actionPoints, function(actionPoint)  {
                        delete actionPoint.id;
                        promises.push(tripService.sendAP(tripId, actionPoint, function() {}, function() {}));
                        tripIdWithActionPoints.push(tripId);
                    });
                });

                $q.all(promises).then(function() {
                    if (tripIdWithActionPoints.length > 0) {
                        // delete action points drafts for each trip
                        _.each(tripIdWithActionPoints, function(tripdId) {
                            tripService.setDraft(tripdId, 'action_points', []);
                        });

                        // display message about action points uploaded and refresh trip data
                        dataService.getTripsRemote(
                            function() {
                                $ionicPopup.alert({
                                    title: $translate.instant('service.action_points.network_status.title'),
                                    template: ($translate.instant('service.action_points.network_status.connection') + '<p></p>' + $translate.instant('service.action_points.network_status.offline_uploaded', {action_points_count: tripIdWithActionPoints.length}))
                                });
                            },
                            function() {}
                        );
                    }
                });
            }
        }
    }

})();
