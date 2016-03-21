(function() {
    'use strict';

    angular
        .module('app.report')
        .controller('ActionPointsEdit', ActionPointsEdit);

    ActionPointsEdit.$inject = ['$scope', '$stateParams', 'tripService', 'localStorageService', '$ionicLoading', '$ionicHistory', '$ionicPopup', '$state', 'dataService', 'errorHandler', '$locale', 'networkService', '$translate'];

    function ActionPointsEdit($scope, $stateParams, tripService, localStorageService, $ionicLoading, $ionicHistory, $ionicPopup, $state, dataService, errorHandler, $locale, networkService, $translate) {
        var vm = this;        
        vm.allMonths = $locale.DATETIME_FORMATS.SHORTMONTH;
        vm.isActionPointNew = false;
        vm.padded_num = paddedNumber;
        vm.submit = submit;
        vm.title = 'template.trip.report.action_point.edit.title';
        vm.today = new Date();
        vm.yearOptions = [vm.today.getFullYear() + '', vm.today.getFullYear() + 1 + ''];

        var currentTrip = tripService.getTrip($stateParams.tripId);

        if ($state.current.name.indexOf('new') > 0) {
            vm.title = 'template.trip.report.action_point.new';
            vm.isActionPointNew = true;
        }

        dataService.get_user_base(
            function(successData){
                vm.users = successData;
            },
            function(err){
                errorHandler.popError(err);
            }
        );

        if (vm.isActionPointNew === true) {
            var tomorrow = new Date(vm.today.getTime() + 24 * 60 * 60 * 1000);

            vm.ap = {'status':'open',
                         'due_year': tomorrow.getFullYear()+"",
                         'due_month': ("0" + (tomorrow.getMonth()+1)).slice(-2),
                         'due_day': ("0" + tomorrow.getDate()).slice(-2)
                        };
        } else {
            vm.ap = tripService.getAP(currentTrip, $stateParams.actionPointId);            
        }

        console.log(vm.ap);

        function paddedNumber(limit){
            var result = [];
            for (var i=1; i<limit+1; i++){
                result.push(i>9 ? i+'' : "0"+i);
            }
            return result;
        }

        function submit(){            
            vm.errors = {};
            vm.error = false;

            if (!vm.ap.person_responsible){
                vm.errors.person_responsible = true;
            }

            if (!vm.ap.description){
                vm.errors.description = true;
            }

            if (Object.keys(vm.errors).length){
                vm.error = true;
                return;
            } else {
                if (networkService.isOffline() === true) {
                    networkService.showMessage();
                } else {
                    var loadingMessage = 'updating_action_point';
                    var alertTitle = 'controller.trip.action_point.edit.title';
                    var alertTemplate = 'controller.trip.action_point.edit.template';

                    if (vm.isActionPointNew === true) {
                        loadingMessage = 'updating_action_point';
                        alertTitle = 'controller.trip.action_point.new.title';
                        alertTemplate = 'controller.trip.action_point.new.template';
                    }

                    $ionicLoading.show({
                        template: '<loading message="' + loadingMessage + '"></loading>'
                    });

                    tripService.sendAP(currentTrip.id, vm.ap,
                        function (success) {
                            $ionicLoading.hide();                            
                            tripService.localTripUpdate(currentTrip.id, success.data);
                            
                            $ionicPopup.alert({
                                title: $translate.instant(alertTitle),
                                template: $translate.instant(alertTemplate)
                            }).then(function(res){                                
                                $state.go('app.dash.reporting_action_point', { 'tripId' :  currentTrip.id });
                            });

                        }, function (err) {
                            errorHandler.popError(err);
                    });
                }
            }
        }
    }

})();