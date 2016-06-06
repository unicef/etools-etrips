(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('AddTrip', AddTrip);

    AddTrip.$inject = ['$scope', '$ionicHistory', '$ionicLoading', '$ionicPopup', '$state', '$translate', 'dataService', 'errorHandler', 'tripService', 'localStorageService', 'lodash', 'moment'];

    function AddTrip($scope, $ionicHistory, $ionicLoading, $ionicPopup, $state, $translate, dataService, errorHandler, tripService, localStorageService, _, moment) {
        var vm = this;
        vm.data = {};
        vm.error = {};
        vm.trip = {};
        vm.save = save;
        vm.title = '';
        vm.onValueChanged = onValueChanged;
        vm.isFormFieldValid = isFormFieldValid;

        var requiredFields = ['traveller', 'supervisor', 'purpose_of_travel', 'from_date', 'to_date'];

        // check if data type exists in local storage
        _.each(tripService.getAddTripDataTypes(), function(dataType) {
            var data = _.compact(localStorageService.getObject(dataType));

            if (data.length === 0) {
                dataService.getRemoteData(dataType, function() {}, function () {});
            }
        });

        ionic.Platform.ready(function(){
            _.each(tripService.getAddTripDataTypes(), function(dataType) {
                vm.data[dataType] = localStorageService.getObject(dataType);
            });

            vm.trans = $translate.instant('controller.trip.add_trip.save.title');
        });

        function onValueChanged(type, val) {
            if (!_.isUndefined(val)) {
                if (val.length > 0) {
                    vm.trip[type] = val;
                } else {
                    vm.trip[type] = [];
                }

                isFormFieldValid(type);
            }
        }

        function isFormValid() {
            var isFormValid = true;
            vm.error = {};

            // validate data
            if (!_.isUndefined(vm.trip.purpose_of_travel) && vm.trip.purpose_of_travel.length > 254) {
                vm.trip.purpose_of_travel = vm.trip.purpose_of_travel.substring(0, 254);
                isFormValid = false;
            }

            // validate required fields
            _.each(requiredFields, function(requiredField){
                isFormValid = isFormFieldValid(requiredField);
            });

            return isFormValid;
        }

        function isFormFieldValid(field) {
            var isFormValid = true;

            if (_.isUndefined(vm.trip[field]) || _.isNull(vm.trip[field]) || vm.trip[field].length === 0) {
                vm.error[field] = true;
                isFormValid = false;
            } else {
                vm.error[field] = false;
            }

            return isFormValid;
        }

        function save() {
            var isAddTripValid = isFormValid();

            if (isAddTripValid === true) {
                // format from_date and to_date from input date format to YYYY-MM-DD
                var dateFields = ['from_date', 'to_date'];

                _.each(dateFields, function(dateField){
                    var date = new Date(vm.trip[dateField]);
                    var formattedDate = moment(date).format('YYYY-MM-DD');
                    vm.trip[dateField] = formattedDate;
                });

                // copy traveller value to owner field
                vm.trip.owner = parseInt(vm.trip.traveller[0]);

                // set required fields to empty
                var emptyFields = ['triplocation_set', 'travelroutes_set', 'tripfunds_set', 'actionpoint_set'];

                _.each(emptyFields, function(emptyField) {
                    vm.trip[emptyField] = [];
                });

                // default values
                vm.trip.created_date = moment();
                vm.trip.travel_type = 'technical_support';

                $ionicLoading.show({
                    template: '<loading message="saving_trip"></loading>'
                });

                tripService.saveTrip(vm.trip).then(
                    function() {
                        $ionicLoading.hide();

                        $ionicPopup.alert({
                            title: $translate.instant('controller.trip.add_trip.save.title'),
                            template: $translate.instant('controller.trip.add_trip.save.template')
                        }).then(function() {
                            $ionicHistory.goBack();
                        });
                    },
                    function() {
                        var errText = '';
                        errorHandler.popError(errText, false, false);
                    }
                );
            }
        }
    }
})();