(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('MyTrips', MyTrips);

    MyTrips.$inject = ['$scope', 'localStorageService', 'dataService', '$state', 'tripService', '$stateParams', '$ionicLoading', '$ionicPopup', '$ionicListDelegate', '$filter', 'errorHandler', '$ionicHistory', 'networkService', '$translate', 'DATE_FORMAT'];

    function MyTrips($scope, localStorageService, dataService, $state, tripService, $stateParams, $ionicLoading, $ionicPopup, $ionicListDelegate, $filter, errorHandler, $ionicHistory, networkService, $translate, DATE_FORMAT) {
        var vm = this;

        vm.dateFormat = DATE_FORMAT;
        vm.doRefresh = doRefresh;
        vm.goReport = goReport;
        vm.onlyMe = onlyMe;
        vm.submit = submit;

        dataService.getTrips(dataSuccess, dataFailed, $stateParams.refreshed);

        function doRefresh() {
            dataService.getTrips(function(res) {
                vm.filteredTrips = $filter('filter')(res, vm.onlyMe);
                $scope.$broadcast('scroll.refreshComplete');

            }, function(err){
                $scope.$broadcast('scroll.refreshComplete');

                if (err.status === 0 && err.statusText === '' && networkService.isOffline() === true) {
                    networkService.showMessage();
                } else {
                    errorHandler.popError(err, false, true);
                }

            }, true);
        }

        function goReport(tripId) {
            $state.go('app.dash.reporting_text', {
                'tripId': tripId
            });
        }

        function onlyMe(trip) {
            // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
            return trip.traveller_id === localStorageService.getObject('currentUser').user_id;
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
