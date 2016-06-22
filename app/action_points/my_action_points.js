(function() {
    'use strict';

    angular
        .module('app.action_points')
        .controller('MyActionPoints', MyActionPoints);

    MyActionPoints.$inject = ['$scope', 'localStorageService', 'dataService', '$state', 'tripService', '$stateParams', '$ionicLoading', '$ionicPopup', '$ionicListDelegate', '$filter', 'errorHandler', '$ionicHistory', 'networkService', '$translate', 'DATE_FORMAT', 'lodash'];

    function MyActionPoints($scope, localStorageService, dataService, $state, tripService, $stateParams, $ionicLoading, $ionicPopup, $ionicListDelegate, $filter, errorHandler, $ionicHistory, networkService, $translate, DATE_FORMAT, _) {
        var vm = this;

        vm.dateFormat = DATE_FORMAT;
        vm.doRefresh = doRefresh;
        vm.goAction = goAction;
        vm.onlyMe = onlyMe;
        //vm.submit = submit;

        dataService.getTrips(dataSuccess, dataFailed, $stateParams.refreshed);

        function doRefresh() {
            dataService.getTrips(function(res){
                vm.filteredTrips = $filter('filter')(res, vm.onlyMe);
                $scope.$broadcast('scroll.refreshComplete');
                
            }, function(err){
                $scope.$broadcast('scroll.refreshComplete');
                errorHandler.popError(err, false, true);
            }, true);
        }

        function goAction(tripId) {
            $state.go('app.dash.reporting_text', {'tripId':tripId});
        }

        function onlyMe(trip) {
            return trip.traveller_id === localStorageService.getObject('currentUser').user_id;
        }

        function dataSuccess(res){
            vm.filteredTrips = $filter('filter')(res, vm.onlyMe);
            var userActionPoints = [];

            _.each(vm.filteredTrips, function(userTrip) {
                var userActionPointSet = userTrip.actionpoint_set;

                _.each(userActionPointSet, function(actionPoint) {
                    if (actionPoint.person_responsible === localStorageService.getObject('currentUser').user_id) {

                        actionPoint.trip_id = userTrip.id;
                        userActionPoints.push(actionPoint);
                    }
                });
            });

            vm.actionPoints = userActionPoints;
        }

        function dataFailed(err){
            errorHandler.popError(err);
        }
    }

})();