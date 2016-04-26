(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('TripDetails', TripDetails);

    TripDetails.$inject = ['$stateParams', 'tripService', 'localStorageService', '$ionicLoading', '$ionicHistory', '$state', '$ionicPopup', 'errorHandler', 'networkService', '$translate', 'DATE_FORMAT'];

    function TripDetails($stateParams, tripService, localStorageService, $ionicLoading, $ionicHistory, $state, $ionicPopup, errorHandler, networkService, $translate, DATE_FORMAT) {
        var vm = this;
        var uid = localStorageService.getObject('currentUser').user_id;

        vm.approve = approve;
        vm.dateFormat = 'dd/MM/yyyy HH:mm';
        vm.completeTrip = completeTrip;
        vm.goReport = goReport; 
        vm.showConfirm = showConfirm;
        vm.submit = submit;
        vm.takeNotes = takeNotes;
        vm.timezone = '';
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

        ionic.Platform.ready(function(){
            if (navigator.globalization !== undefined) {
                navigator.globalization.getDatePattern(function(obj){
                    if (obj.timezone !== undefined) {
                        vm.timezone = obj.timezone;
                    }
                });
            }
        });

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

            var tripEnd = new Date(vm.trip.to_date);
            
            if (now < tripEnd){
                vm.showConfirm($translate.instant('controller.trip.detail.complete.title'), executeRequest);
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