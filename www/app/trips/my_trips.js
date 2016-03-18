(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('MyTrips', MyTrips);

    MyTrips.$inject = ['$scope', 'localStorageService', 'dataService', '$state', 'tripService', '$stateParams', '$ionicLoading', '$ionicPopup', '$ionicListDelegate', '$filter', 'errorHandler', '$ionicHistory', 'networkService', '$translate'];

    function MyTrips($scope, localStorageService, dataService, $state, tripService, $stateParams, $ionicLoading, $ionicPopup, $ionicListDelegate, $filter, errorHandler, $ionicHistory, networkService, $translate) {
        var vm = this;

        vm.doRefresh = doRefresh;
        vm.go_report = goReport;
        vm.onlyMe = onlyMe;
        vm.submit = submit;

        dataService.get_trips(dataSuccess, dataFailed, $stateParams.refreshed);

        function doRefresh() {
            dataService.get_trips(function(res){
                vm.filteredTrips = $filter('filter')(res, vm.onlyMe);
                $scope.$broadcast('scroll.refreshComplete');
                
            }, function(err){
                $scope.$broadcast('scroll.refreshComplete');
                errorHandler.popError(err, false, true);
            }, true);
        }

        function goReport(tripId) {
            $state.go('app.reporting.text', {"tripId":tripId});
        }

        function onlyMe(trip) {
            return trip.traveller_id == localStorageService.getObject('currentUser').user_id;
        }

        function submit(tripId) {
            if (networkService.isOffline() === true) {
                networkService.showMessage();

            } else {
                $ionicListDelegate.closeOptionButtons();
                $ionicLoading.show({ template: '<loading message="submitting_trip"></loading>' });
                
                tripService.tripAction(tripId, 'submitted', {}).then(
                    function(actionSuccess){
                        $ionicLoading.hide();
                        tripService.localSubmit(tripId);

                        var alertPopup = $ionicPopup.alert({
                            title: $translate.instant('controller.my_trips.title'),
                            template: $translate.instant('controller.my_trips.template')
                        });
                    },
                    function(err){
                        errorHandler.popError(err);
                    }
                );
          }
        }

        function dataSuccess(res){
            vm.filteredTrips = $filter('filter')(res, vm.onlyMe);
        }

        function dataFailed(err){
            errorHandler.popError(err);
        }
    }

})();