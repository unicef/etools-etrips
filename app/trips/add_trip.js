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

            // validate purpose_of_travel
            if (!_.isUndefined(vm.trip.purpose_of_travel) && vm.trip.purpose_of_travel.length > 254) {
                vm.trip.purpose_of_travel = vm.trip.purpose_of_travel.substring(0, 254);
                isFormValid = false;

            }

            // validate required fields
            var hasOneInvalidField = false;

            _.each(requiredFields, function(requiredField){
                if (isFormFieldValid(requiredField) === false) {
                    hasOneInvalidField = true;
                }
            });

            if (hasOneInvalidField === true) {
                isFormValid = false;
            }

            return isFormValid;
        }

        function isFormFieldValid(field) {
            var isFormValid = true;

            // empty field
            if (_.isUndefined(vm.trip[field]) || _.isNull(vm.trip[field]) || vm.trip[field].length === 0) {
                vm.error[field] = true;
                vm.error[field + '_message'] = 'template.trip.add_trip.error.cant_leave_empty';
                isFormValid = false;

            } else {
                vm.error[field] = false;
                isFormValid = true;
            }

            // from_date must be less than to_date
            if (!_.isUndefined(vm.trip.from_date) && !_.isUndefined(vm.trip.to_date)) {
                var fromDateEpoch = moment(new Date(vm.trip.from_date)).valueOf();
                var toDateEpoch = moment(new Date(vm.trip.to_date)).valueOf();

                if (fromDateEpoch > toDateEpoch) {
                    vm.error.from_date = true;
                    vm.error.from_date_message = 'template.trip.add_trip.error.to_date_less_than_from';
                    vm.error.to_date = true;
                    vm.error.to_date_message = 'template.trip.add_trip.error.to_date_less_than_from';
                    isFormValid = false;

                } else {
                    vm.error.from_date = false;
                    vm.error.to_date = false;
                }
            }

            // a supervisor can't be a traveller
            if (!_.isUndefined(vm.trip.traveller) && !_.isUndefined(vm.trip.supervisor)){

                if (vm.trip.traveller.length > 0 &&
                    vm.trip.supervisor > -1 &&
                    _.intersection(vm.trip.traveller, [vm.trip.supervisor.toString()]).length > 0) {

                    vm.error.traveller = true;
                    vm.error.traveller_message = 'template.trip.add_trip.error.owner_is_supervisor';
                    vm.error.supervisor = true;
                    vm.error.supervisor_message = 'template.trip.add_trip.error.owner_is_supervisor';
                    isFormValid = false;

                } else {
                    vm.error.traveller = false;
                    vm.error.supervisor = false;
                }
            }

            return isFormValid;
        }

        function save() {
            var isAddTripValid = isFormValid();

            if (isAddTripValid === true) {
                // create new trip object;
                var trip =  _.cloneDeep(vm.trip);

                // format from_date and to_date from input date format to YYYY-MM-DD
                var dateFields = ['from_date', 'to_date'];

                _.each(dateFields, function(dateField){
                    var date = new Date(vm.trip[dateField]);
                    var formattedDate = moment(date).format('YYYY-MM-DD');
                    trip[dateField] = formattedDate;
                });

                // copy traveller value to owner field
                trip.owner = parseInt(vm.trip.traveller[0]);

                // set required fields to empty
                var emptyFields = ['triplocation_set', 'travelroutes_set', 'tripfunds_set', 'actionpoint_set'];

                _.each(emptyFields, function(emptyField) {
                    trip[emptyField] = [];
                });

                // default values
                trip.created_date = moment();
                trip.travel_type = 'technical_support';

                $ionicLoading.show({
                    template: '<loading message="saving_trip"></loading>'
                });

                tripService.saveTrip(trip).then(
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