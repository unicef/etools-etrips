(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('TripDetails', TripDetails);

    TripDetails.$inject = ['$scope', '$stateParams', 'tripService', 'localStorageService', '$ionicLoading', '$ionicHistory', '$state', '$ionicPopup', 'errorHandler', 'networkService', '$translate'];

    function TripDetails($scope, $stateParams, tripService, localStorageService, $ionicLoading, $ionicHistory, $state, $ionicPopup, errorHandler, networkService, $translate) {
        var vm = this;
        var uid = localStorageService.getObject('currentUser').user_id;

        vm.approve = approve;
        vm.complete_trip = completeTrip;
        vm.go_report = goReport; 
        vm.showConfirm = showConfirm;
        vm.submit = submit;
        vm.take_notes = takeNotes;
        vm.trip = tripService.getTrip($stateParams.tripId);

        vm.checks = {
            supervisor: vm.trip.supervisor == uid,
            owner: vm.trip.traveller_id == uid,
            is_approved: vm.trip.status == "approved",
            not_supervisor_approved: (!vm.trip.approved_by_supervisor),
            is_planned: vm.trip.status == "planned",
            is_canceled: vm.trip.status == "cancelled",
            is_submitted: vm.trip.status == "submitted",
            report_filled: vm.trip.main_observations
        };

        function approve(tripId){
            if (networkService.isOffline() === true) {
                networkService.showMessage();
            } else {
                $ionicLoading.show({ template: '<loading message="sending_report"></loading>' });
                tripService.tripAction(tripId, 'approved', {}).then(
                    function(actionSuccess){
                        $ionicLoading.hide();
                        tripService.localTripUpdate(tripId, actionSuccess.data);
                        
                        $ionicPopup.alert({
                            title: $translate.instant('controller.trip.detail.approved.title'),
                            template: $translate.instant('controller.trip.detail.approved.template')
                        }).then(function(res){
                            $ionicHistory.goBack();//('app.dash.my_trips');                            
                        });
                    },
                    function(err){
                        errorHandler.popError(err);
                    }
                );
            }
        }

        function completeTrip(tripId) {            
            var now = new Date();
            now.setHours(0,0,0,0);

            var tripEnd = new Date($scope.trip.to_date);
            
            if (now < tripEnd){
                $scope.showConfirm($translate.instant('controller.trip.detail.complete.title'), execute_req);
                return;
            }

            executeRequest();

            function executeRequest() {
                if (networkService.isOffline() === true) {
                    networkService.showMessage();
                } else {
                    $ionicLoading.show({ template: '<loading message="submitting_trip"></loading>' });
                    
                    tripService.tripAction(tripId, 'completed', {}).then(
                        function (actionSuccess) {
                            $ionicLoading.hide();
                            tripService.localTripUpdate(tripId, actionSuccess.data);

                            $ionicPopup.alert({
                                title: $translate.instant('controller.trip.complete.title'),
                                template: $translate.instant('controller.trip.complete.template')
                            }).then(function(res){
                                $state.go('app.dash.my_trips');
                            });                            
                        },
                        function (err) {
                            errorHandler.popError(err);
                        }
                    );
                }
            }
        }

        function goReport(tripId) {
            $state.go('app.dash.reporting', { 'tripId' : tripId });
        }

        function showConfirm(template, succ, fail) {
            $ionicPopup.confirm({
                title: $translate.instant('controller.trip.detail.confirm.title'),
                okText: $translate.instant('controller.trip.detail.confirm.ok'),
                cancelText: $translate.instant('controller.trip.detail.confirm.cancel'),
                template: template
            }).then(function(res) {
                if (res) {
                    succ();                
                }
           });
        }

        function submit(tripId) {
            if (networkService.isOffline() === true) {
                networkService.showMessage();
            } else {
                $ionicLoading.show({ template: '<loading message="submitting_trip"></loading>' });
                tripService.tripAction(tripId, 'submitted', {}).then(
                
                function(actionSuccess){
                    $ionicLoading.hide();
                    tripService.localSubmit(tripId);

                    $ionicPopup.alert({
                        title: $translate.instant('controller.trip.submit.title'),
                        template: $translate.instant('controller.trip.submit.template')
                    }).then(function(res){
                        $ionicHistory.goBack();//('app.dash.my_trips');
                    });
                },
                function(err){
                    errorHandler.popError(err);
                }
            );
          }
        }

        function takeNotes(tripId) {
            $state.go('app.dash.notes', {"tripId":tripId});
        }
    }

})();