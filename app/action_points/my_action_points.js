(function() {
    'use strict';

    angular
        .module('app.action_points')
        .controller('MyActionPoints', MyActionPoints);

    MyActionPoints.$inject = ['$scope', 'localStorageService', 'dataService', '$state', 'tripService', '$stateParams', '$ionicLoading', '$ionicPopup', '$ionicListDelegate', '$filter', 'errorHandler', '$ionicHistory', 'networkService', '$translate', 'DATE_FORMAT'];

    function MyActionPoints($scope, localStorageService, dataService, $state, tripService, $stateParams, $ionicLoading, $ionicPopup, $ionicListDelegate, $filter, errorHandler, $ionicHistory, networkService, $translate, DATE_FORMAT) {
        var vm = this;

        vm.dateFormat = DATE_FORMAT;
        vm.doRefresh = doRefresh;

        vm.actionPoints = [
            {
                "id": 3,
                "trip_id": 8,
                "person_responsible": 4,
                "person_responsible_name": "rey",
                "status": "ongoing",
                "description": "Sed magna purus, fermentum eu, tincidunt eu, varius ut, felis. Pellentesque commodo eros a enim. Pellentesque auctor neque nec urna. In consectetuer turpis ut velit. Nulla porta dolor.\n\nIn hac habitasse platea dictumst. Cras ultricies mi eu turpis hendre",
                "due_date": "2017-01-01",
                "comments": "In turpis. Etiam ultricies nisi vel augue. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc, quis gravida magna mi a libero. Curabitur at lacus ac velit ornare lobortis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\n\nCras risus ipsum, faucibus ut, ullamcorper id, varius ac, leo. Vivamus in erat ut urna cursus vestibulum. Maecenas ullamcorper, dui et placerat feugiat, eros pede varius nisi, condimentum viverra felis nunc et lorem. Suspendisse feugiat. Nunc interdum lacus sit amet orci.\n\nEtiam rhoncus. Quisque ut nisi. Sed lectus. Mauris turpis nunc, blandit et, volutpat molestie, porta ut, ligula. Phasellus leo dolor, tempus non, auctor et, hendrerit quis, nisi.\n\nCras sagittis. Proin sapien ipsum, porta a, auctor quis, euismod ut, mi. Phasellus volutpat, metus eget egestas mollis, lacus lacus blandit dui, id egestas quam mauris ut lacus. Cras id dui. Nunc egestas, augue at pellentesque laoreet, felis eros vehicula leo, at malesuada velit leo quis pede.\n\nPraesent vestibulum dapibus nibh. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Integer ante arcu, accumsan a, consectetuer eget, posuere ut, mauris. Aenean vulputate eleifend tellus. Donec mollis hendrerit risus."
            },
            {
                "id": 2,
                "trip_id": 8,
                "person_responsible": 4,
                "person_responsible_name": "rey",
                "status": "open",
                "description": "Sed a libero. Fusce convallis metus id felis luctus adipiscing. Nullam cursus lacinia erat. Etiam sit amet orci eget eros faucibus tincidunt. Etiam iaculis nunc ac metus.",
                "due_date": "2016-01-01",
                "comments": " Sed consequat"
            }
        ];

        //vm.goAction = goAction;
        // vm.onlyMe = onlyMe;
        //vm.submit = submit;

        // dataService.getTrips(dataSuccess, dataFailed, $stateParams.refreshed);

        function doRefresh() {
            // dataService.getTrips(function(res){
            //     vm.filteredTrips = $filter('filter')(res, vm.onlyMe);
            //     $scope.$broadcast('scroll.refreshComplete');
                
            // }, function(err){
            //     $scope.$broadcast('scroll.refreshComplete');
            //     errorHandler.popError(err, false, true);
            // }, true);
        }

        //function goAction(tripId) {
        //     $state.go('app.dash.reporting_text', {"tripId":tripId});
        // }

        // function onlyMe(trip) {
        //     return trip.traveller_id == localStorageService.getObject('currentUser').user_id;
        // }

        // function submit(tripId) {
        //     if (networkService.isOffline() === true) {
        //         networkService.showMessage();

        //     } else {
        //         $ionicListDelegate.closeOptionButtons();
        //         $ionicLoading.show({ template: '<loading message="submitting_trip"></loading>' });
                
        //         tripService.tripAction(tripId, 'submitted', {}).then(
        //             function(actionSuccess){
        //                 $ionicLoading.hide();
        //                 tripService.localSubmit(tripId);

        //                 var alertPopup = $ionicPopup.alert({
        //                     title: $translate.instant('controller.my_trips.title'),
        //                     template: $translate.instant('controller.my_trips.template')
        //                 });
        //             },
        //             function(err){
        //                 errorHandler.popError(err);
        //             }
        //         );
        //   }
        // }

        // function dataSuccess(res){
        //     vm.filteredTrips = $filter('filter')(res, vm.onlyMe);
        // }

        // function dataFailed(err){
        //     errorHandler.popError(err);
        // }
    }

})();