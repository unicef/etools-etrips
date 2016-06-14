(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('MyTrips', MyTrips);

    MyTrips.$inject = ['$scope', 'localStorageService', 'dataService', '$state', 'tripService', '$stateParams', '$ionicLoading', '$ionicPopup', '$ionicListDelegate', '$filter', 'errorHandler', '$ionicHistory', 'networkService', '$translate', 'DATE_FORMAT', 'lodash'];

    function MyTrips($scope, localStorageService, dataService, $state, tripService, $stateParams, $ionicLoading, $ionicPopup, $ionicListDelegate, $filter, errorHandler, $ionicHistory, networkService, $translate, DATE_FORMAT, _) {
        var vm = this;

        vm.dateFormat = DATE_FORMAT;
        vm.doRefresh = doRefresh;
        vm.goReport = goReport;
        vm.onlyMe = onlyMe;
        vm.showAddButton = true;
        vm.submit = submit;

        dataService.getTrips(dataSuccess, dataFailed, ($stateParams.refreshed === 'true'));

        ionic.Platform.ready(function(){
            if (networkService.isOffline() === true) {
                vm.showAddButton = false;
            } else {
                // pre-fetch all data for adding a trip if greater than expiry timestamp
                 _.each(tripService.getAddTripDataTypes(), function(dataType) {
                    var expires = new Date();
                    var expiresDataType = localStorageService.getObject(dataType + '_timestamp');

                    if (_.isInteger(expiresDataType) === false || expires.getMinutes() > expiresDataType) {
                        dataService.getRemoteData(dataType, function() {}, function () {});
                    }
                });
            }
        });

        function doRefresh() {
            $scope.$broadcast('scroll.refreshComplete');

            if (networkService.isOffline() === true) {
                networkService.showMessage();
            } else {
                dataService.getTrips(function(res) {
                    vm.filteredTrips = $filter('filter')(res, vm.onlyMe);

                }, function(err) {
                    errorHandler.popError(err, false, true);
                }, true);
            }
        }

        function goReport(tripId) {
            $state.go('app.dash.reporting_text', {
                'tripId': tripId
            });
        }

        function onlyMe(trip) {
            // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
            return trip.owner === localStorageService.getObject('currentUser').user_id;
        }

        function submit(tripId) {
            if (networkService.isOffline() === true) {
                networkService.showMessage();

            } else {
                $ionicListDelegate.closeOptionButtons();

                $ionicLoading.show({
                    template: '<loading message="submitting_trip"></loading>'
                });

                tripService.tripAction(tripId, 'submitted', {}).then(
                    function() {
                        $ionicLoading.hide();
                        tripService.localSubmit(tripId);

                        $ionicPopup.alert({
                            title: $translate.instant('controller.my_trips.title'),
                            template: $translate.instant('controller.my_trips.template')
                        });
                    },
                    function(err) {
                        errorHandler.popError(err);
                    }
                );
            }
        }

        function dataSuccess(res) {
            vm.filteredTrips = $filter('filter')(res, vm.onlyMe);
        }

        function dataFailed(err) {
            errorHandler.popError(err);
        }
    }

})();
