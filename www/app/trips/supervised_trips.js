(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('SupervisedTrips', SupervisedTrips);

    SupervisedTrips.$inject = ['$scope', 'localStorageService', 'dataService', 'tripService', '$ionicLoading', '$state', '$ionicListDelegate', '$filter', 'errorHandler', 'networkService'];

    function SupervisedTrips($scope, localStorageService, dataService, tripService, $ionicLoading, $state, $ionicListDelegate, $filter, errorHandler, networkService) {
        var vm = this;

        vm.approve = approve;
        vm.doRefresh = doRefresh;
        vm.onlySupervised = onlySupervised;

        dataService.get_trips(
            function(res){
                vm.filteredTrips = $filter('filter')(res, vm.onlySupervised);

                console.log("got trips", res);
            },
            function(err){
                errorHandler.popError(err);
            }
        );

        function approve(tripId){
            if (networkService.isOffline() === true) {
                networkService.showMessage();
            } else {
                $ionicListDelegate.closeOptionButtons();
                $ionicLoading.show({ template: '<loading message="approving_trip"></loading>' });
                tripService.tripAction(tripId, 'approved', {}).then(
                    function(actionSuccess){
                        $ionicLoading.hide();
                        tripService.localTripUpdate(tripId, actionSuccess.data);
                        $state.go('app.dash.supervised');
                    },
                    function(err){
                        errorHandler.popError(err);
                    }
                );
            }
        }

        function doRefresh() {
            dataService.get_trips(function(res){
                vm.filteredTrips = $filter('filter')(res, vm.onlySupervised);
                $scope.$broadcast('scroll.refreshComplete');                
            }, function(err){
                vm.$broadcast('scroll.refreshComplete');
                errorHandler.popError(err);
            }, true);
        }

        function onlySupervised(trip) {
            return trip.supervisor == localStorageService.getObject('currentUser').user_id;
        }        
    }

})();