(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('AddTrip', AddTrip);

    AddTrip.$inject = ['$locale', '$ionicPickerI18n', '$scope', '$ionicHistory', '$ionicLoading', '$ionicModal', '$ionicPopup', '$state', '$translate', 'dataService', 'errorHandler', 'tripService', 'localStorageService', 'lodash', 'moment', 'DATE_FORMAT', 'DATE_TIME_FORMAT'];

    function AddTrip($locale, $ionicPickerI18n, $scope, $ionicHistory, $ionicLoading, $ionicModal, $ionicPopup, $state, $translate, dataService, errorHandler, tripService, localStorageService, _, moment, DATE_FORMAT, DATE_TIME_FORMAT) {
        var vm = this;
        vm.closeModal = closeModal;
        vm.data = {};
        vm.dateFormat = DATE_FORMAT;
        vm.dateTimeFormat = DATE_TIME_FORMAT;
        vm.deleteMultiAddItem = deleteMultiAddItem;
        vm.error = {};
        vm.isFormFieldValid = isFormFieldValid;
        vm.modal = {};
        vm.onValueChanged = onValueChanged;
        vm.openModal = openModal;
        vm.save = save;
        vm.saveModal = saveModal;
        vm.titleArriveDateTime = $translate.instant('controller.add_trip.modal.arrive_date_time');
        vm.titleDepartDateTime = $translate.instant('controller.add_trip.modal.depart_date_time');
        vm.titleStartDate = $translate.instant('controller.add_trip.modal.start_date');
        vm.titleEndDate = $translate.instant('controller.add_trip.modal.end_date');
        vm.title = '';
        vm.trip = {};

        var requiredFields = ['traveller', 'supervisor', 'purpose_of_travel', 'section', 'office', 'start_date', 'end_date', 'travel_focal_point'];
        var fundingModalRequiredFields = ['wbs', 'grant', 'percentage'];
        var travelItineraryModalRequiredFields = ['origin', 'destination', 'depart', 'arrive'];

        // check if data type exists in local storage
        _.each(tripService.getAddTripDataTypes(), function(dataType) {
            if (_.isUndefined(localStorageService.getObject(dataType).length)) {
                dataService.getRemoteData(dataType, function() {}, function () {});
            }
        });

        ionic.Platform.ready(function(){
            $ionicPickerI18n.weekdays = $locale.DATETIME_FORMATS.SHORTDAY;
            $ionicPickerI18n.months = $locale.DATETIME_FORMATS.MONTH;
            $ionicPickerI18n.ok = $translate.instant('template.ok');
            $ionicPickerI18n.cancel = $translate.instant('template.cancel');

            _.each(tripService.getAddTripDataTypes(), function(dataType) {
                vm.data[dataType] = localStorageService.getObject(dataType);
            });

            vm.trans = $translate.instant('controller.trip.add_trip.save.title');

            vm.trip.tripfunds_set = [];
            vm.trip.travelroutes_set = [];

            $ionicModal.fromTemplateUrl(
                'templates/trips/add_trip_modal_custom_template.html', {
                    scope: $scope,
                    animation: 'slide-in-up'
                }).then(function(modal) {
                    $scope.modal = modal;
                }
            );
        });

        function deleteMultiAddItem(type, item) {
            var headerTypeTitle = '';
            var itemData = {};

            if (type === 'funding') {
                headerTypeTitle = $translate.instant('template.trip.add_trip.funding');
                itemData = 'tripfunds_set';

            } else if (type === 'travel_itinerary') {
                headerTypeTitle = $translate.instant('template.trip.add_trip.travel_itinerary');
                itemData = 'travelroutes_set';
            }

            $ionicPopup.confirm({
                title: $translate.instant('template.trip.add_trip.multi_add_item.delete.title', { 'type' : headerTypeTitle }),
                template: $translate.instant('template.trip.add_trip.multi_add_item.delete.template')
            }).then(function(res) {
                if (res === true) {
                    vm.trip[itemData] = _.filter(vm.trip[itemData], function(itemDataElement) {
                        return itemDataElement.$$hashKey !== item.$$hashKey;
                    });
                }
            });
        }

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
            var fields = [];


            if (!_.isUndefined(vm.modal.type)) {

                if (vm.modal.type === 'funding') {
                    fields = fundingModalRequiredFields;

                } else if (vm.modal.type === 'travel_itinerary') {
                    fields = travelItineraryModalRequiredFields;
                }

            } else {
                if (!_.isUndefined(vm.trip.purpose_of_travel) && vm.trip.purpose_of_travel.length > 254) {
                    vm.trip.purpose_of_travel = vm.trip.purpose_of_travel.substring(0, 254);
                    isFormValid = false;
                }

                fields = requiredFields;
            }

            // validate required fields
            var hasOneInvalidField = false;

            _.each(fields, function(requiredField){
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

            // start_date must be less than end_date
            if (!_.isUndefined(vm.trip.start_date) && !_.isUndefined(vm.trip.end_date)) {
                var startDateEpoch = moment(new Date(vm.trip.start_date)).valueOf();
                var endDateEpoch = moment(new Date(vm.trip.end_date)).valueOf();

                if (startDateEpoch > endDateEpoch) {
                    vm.error.start_date = true;
                    vm.error.start_date_message = 'template.trip.add_trip.error.end_date_less_than_start';
                    vm.error.end_date = true;
                    vm.error.end_date_message = 'template.trip.add_trip.error.end_date_less_than_start';
                    isFormValid = false;

                } else {
                    vm.error.start_date = false;
                    vm.error.end_date = false;
                }
            }

            if (!_.isUndefined(vm.trip.origin) && !_.isUndefined(vm.trip.arrive)) {
                if (moment(new Date(vm.trip.origin)).valueOf() > moment(new Date(vm.trip.arrive)).valueOf()) {
                    vm.error.origin = true;
                    vm.error.origin_message = 'template.trip.add_trip.error.arrive_less_than_origin';
                    vm.error.arrive = true;
                    vm.error.arrive_message = 'template.trip.add_trip.error.arrive_less_than_origin';
                    isFormValid = false;

                } else {
                    vm.error.start_date = false;
                    vm.error.end_date = false;
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

            // percentage check
            if (!_.isUndefined(vm.trip.percentage)){

                if (_.isNull(vm.trip.percentage) || (vm.trip.percentage.length > 0 && !_.isInteger(vm.trip.percentage.length))) {
                    vm.error.percentage = true;
                    vm.error.percentage_message = 'template.trip.add_trip.error.percentage_must_be_an_integer';
                    isFormValid = false;

                } else {
                    vm.error.percentage = false;
                }
            }

            return isFormValid;
        }

        function save() {
            var isAddTripValid = isFormValid();

            // validate funding percentage totals 100
            if (!_.isUndefined(vm.trip.tripfunds_set) && vm.trip.tripfunds_set.length > 0) {
                var totalPercent = _.reduce(vm.trip.tripfunds_set, function(sum, funding) {
                  return sum + parseInt(funding.amount);
                }, 0);

                if (totalPercent !== 100) {
                    vm.error.funding = true;
                    vm.error.funding_message = 'template.trip.add_trip.error.total_funds_equal_100_percent';
                    isAddTripValid = false;
                }
            }

            if (isAddTripValid === true) {
                // create new trip object;
                var trip =  _.cloneDeep(vm.trip);

                // format start_date and end_date from input date format to YYYY-MM-DD
                var dateFields = {
                    'start_date' : 'from_date',
                    'end_date' : 'to_date'
                };

                _.each(dateFields, function(dateField, formField){
                    var date = new Date(vm.trip[formField]);
                    var formattedDate = moment(date).format('YYYY-MM-DD');
                    trip[dateField] = formattedDate;
                });

                // copy traveller value to owner field
                trip.owner = parseInt(vm.trip.traveller[0]);

                // select travel focal point
                trip.travel_assistant = parseInt(vm.trip.travel_focal_point[0]);

                // set required fields to empty
                var emptyFields = ['triplocation_set', 'actionpoint_set'];

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

        function saveModal() {
            var isModalValid = isFormValid();

            if (isModalValid === true) {
                if (vm.modal.type === 'funding') {
                    var wbs = _.find(vm.data['reports/results'], function(o){
                        return parseInt(o.id) === parseInt(vm.trip.wbs);
                    });

                    var grantItem = _.find(vm.data['funds/grants'], function(o){
                        return parseInt(o.id) === parseInt(vm.trip.grant);
                    });

                    var funding = {
                        'wbs' : wbs.id,
                        'wbs_name' : wbs.wbs,
                        'grant' : grantItem.id,
                        'grant_name' : grantItem.name,
                        'amount' : parseInt(vm.trip.percentage)
                    };

                    if (!_.isUndefined(vm.modal.$$hashKey)){
                        var indexFunding = _.indexOf(vm.trip.tripfunds_set, _.find(vm.trip.tripfunds_set, {$$hashKey: vm.modal.$$hashKey}));
                        vm.trip.tripfunds_set.splice(indexFunding, 1, funding);
                    } else {
                        vm.trip.tripfunds_set.push(funding);
                    }
                }

                if (vm.modal.type === 'travel_itinerary') {
                    var travelroute = {
                        'origin' : vm.trip.origin,
                        'destination' : vm.trip.destination,
                        'remarks' : vm.trip.remarks
                    };

                    var dateFields = ['depart', 'arrive'];

                    _.each(dateFields, function(dateField) {
                        var date = new Date(vm.trip[dateField]);
                        travelroute[dateField] = moment(date).format('YYYY-MM-DD HH:mm');
                    });

                    if (!_.isUndefined(vm.modal.$$hashKey)){
                        var indexTravelItinerary = _.indexOf(vm.trip.travelroutes_set, _.find(vm.trip.travelroutes_set, {$$hashKey: vm.modal.$$hashKey}));
                        vm.trip.travelroutes_set.splice(indexTravelItinerary, 1, travelroute);
                    } else {
                        vm.trip.travelroutes_set.push(travelroute);
                    }
                }

                closeModal();
            }
        }

        function openModal(field, item) {
            item = typeof item !== 'undefined' ? item : false;

            if (item === false) {
                resetModalData();
                vm.modal.headerText = $translate.instant('template.trip.add_trip.' + field + '.add.button.text');

            } else {
                if (field === 'funding') {
                    delete vm.error[field];
                    vm.trip.wbs = item.wbs;
                    vm.trip.grant = item.grant;
                    vm.trip.percentage = item.amount;

                } else if (field === 'travel_itinerary') {
                    delete vm.error[field];
                    vm.trip.origin = item.origin;
                    vm.trip.destination = item.destination;
                    vm.trip.depart = new Date(item.depart);
                    vm.trip.arrive = new Date(item.arrive);
                    vm.trip.remarks = item.remarks;
                }

                vm.modal.headerText = $translate.instant('template.trip.add_trip.' + field + '.edit.button.text');
                vm.modal.$$hashKey = item.$$hashKey;
            }

            vm.modal.type = field;

            $scope.modal.show();
        }

        function closeModal() {
            resetModalData();
            $scope.modal.hide();
        }

        function resetModalData() {
            var modalFields = ['wbs', 'grant', 'percentage', 'funding', 'origin', 'destination', 'arrive', 'depart', 'remarks'];

            _.each(modalFields, function(modalField) {
                delete vm.trip[modalField];
                delete vm.error[modalField];
            });

            vm.modal = {};
        }

        $scope.$on('$destroy', function() {
            $scope.modal.remove();
        });
    }
})();
