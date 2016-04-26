(function() {
    'use strict';

    angular
        .module('app.report')
        .controller('ActionPoints', ActionPoints);

    ActionPoints.$inject = ['$ionicPopup', '$ionicListDelegate', '$stateParams', '$translate', 'tripService', 'networkService', 'DATE_FORMAT', 'localStorageService', 'lodash', '$q', 'dataService'];

    function ActionPoints($ionicPopup, $ionicListDelegate, $stateParams, $translate, tripService, networkService, DATE_FORMAT, localStorageService, _, $q, dataService) {
        var tripId = $stateParams.tripId;

        var vm = this;
        vm.dateFormat = DATE_FORMAT;
        vm.deleteActionPoint = deleteActionPoint;
        vm.trips = tripService.getTrip($stateParams.tripId);
        vm.trip_id = $stateParams.tripId;
        vm.offline = (networkService.isOffline() === undefined ? false : networkService.isOffline());

        if (vm.offline === true) {
            var offlineActionPoints = tripService.getDraft($stateParams.tripId, 'action_points');
            vm.offlineActionPoints = offlineActionPoints;
        }

        function deleteActionPoint(id) {
            $ionicPopup.confirm({
                title: $translate.instant('controller.trip.action_point.delete.title'),
                template: $translate.instant('controller.trip.action_point.delete.template'),
            }).then(function(result) {
                if (result) {
                    vm.offlineActionPoints = _.filter(vm.offlineActionPoints, function(actionPoint) {                     
                        return actionPoint.id != id;
                    });

                    tripService.setDraft(tripId, 'action_points', vm.offlineActionPoints);

                } else {
                    $ionicListDelegate.closeOptionButtons();
                }
            });
        }
    }

})();