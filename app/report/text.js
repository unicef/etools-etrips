(function() {
    'use strict';

    angular
        .module('app.report')
        .controller('Text', Text);

    Text.$inject = ['$scope', '$stateParams', 'tripService', '$ionicLoading', '$ionicHistory', '$ionicPopup', 'errorHandler', 'networkService', '$translate'];

    function Text($scope, $stateParams, tripService, $ionicLoading, $ionicHistory, $ionicPopup, errorHandler, networkService, $translate) {
        var vm = this;
        vm.trip = tripService.getTrip($stateParams.tripId);
        vm.autosave = autosave;
        vm.submit = submit;

        var fields = ['main_observations', 'constraints', 'lessons_learned', 'opportunities'];
        var main_obs_template = $translate.instant('controller.report.text.observations.access') + '\n \n \n \n' +
        $translate.instant('controller.report.text.observations.quality') + '\n \n \n \n' +
        $translate.instant('controller.report.text.observations.utilisation') + '\n \n \n \n' +
        $translate.instant('controller.report.text.observations.enabling') + '\n \n \n \n';
        
        if (vm.trip.main_observations.length > 0) {
            vm.data = {
                main_observations : vm.trip.main_observations,
                constraints : vm.trip.constraints,
                lessons_learned : vm.trip.lessons_learned,
                opportunities: vm.trip.opportunities
            };
        } else {
     
            var reportText = {};

            fields.forEach(function(field) {
                var data = tripService.getDraft($stateParams.tripId, field);

                if (data.length > 0) {
                    reportText[field] = data;
                } else {
                    if (field === 'main_observations') {
                        reportText[field] = main_obs_template;
                    } else {
                        reportText[field] = '';
                    }
                }
            });

            vm.data = reportText;
        }

        function autosave() {
            if (vm.trip.main_observations.length === 0) {
                fields.forEach(function(field) {
                    tripService.setDraft($stateParams.tripId, field, vm.data[field]);    
                });
            }
        }

        function submit(){
            if (networkService.isOffline() === true) {
                networkService.showMessage();

            } else {
                $ionicLoading.show( { template: '<loading message="sending_report"></loading>' } );

                tripService.reportText(vm.data, vm.trip.id, 
                    function(succ){
                        $ionicLoading.hide();
                        $ionicHistory.goBack(-1);

                        tripService.localTripUpdate(vm.trip.id, succ.data);

                        fields.forEach(function(field) {
                            tripService.deleteDraft($stateParams.tripId, field);    
                        });

                        $ionicPopup.alert({
                            title: $translate.instant('controller.report.text.submitted.title'),
                            template: $translate.instant('controller.report.text.submitted.template')
                        });
                    }, function(err){
                        errorHandler.popError(err);
                    }
                );
            }
        }
    }

})();