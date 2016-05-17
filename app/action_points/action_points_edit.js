(function() {
    'use strict';

    angular
        .module('app.action_points')
        .controller('ActionPointsEdit', ActionPointsEdit);

    ActionPointsEdit.$inject = ['$ionicHistory', '$ionicLoading', '$ionicPopup', '$locale', '$scope', '$state', '$stateParams', '$translate', 'dataService', 'errorHandler', 'localStorageService', 'lodash', 'md5', 'networkService', 'tripService'];

    function ActionPointsEdit($ionicHistory, $ionicLoading, $ionicPopup, $locale, $scope, $state, $stateParams, $translate, dataService, errorHandler, localStorageService, _, md5, networkService, tripService) {
        var currentTrip = tripService.getTrip($stateParams.tripId);
        var vm = this;
        vm.allMonths = $locale.DATETIME_FORMATS.SHORTMONTH;
        vm.isActionPointNew = false;
        vm.isPersonResponsibleCurrentUser = isPersonResponsibleCurrentUser;
        vm.paddedNumber = paddedNumber;
        vm.personResponsibleIsCurrentUser = false;
        vm.submit = submit;
        vm.title = 'template.trip.report.action_point.edit.title';
        vm.today = new Date();
        vm.yearOptions = [vm.today.getFullYear() + '', vm.today.getFullYear() + 1 + ''];

        // new / edit state
        if ($state.current.name.indexOf('new') > 0) {
            vm.title = 'template.trip.report.action_point.new';
            vm.isActionPointNew = true;
        }

        // get users
        dataService.getUserBase(
            function(users){
                vm.users = users;
            },
            function(err){
                errorHandler.popError(err);
            }
        );

        // set current date
        if (vm.isActionPointNew === true) {
            var tomorrow = new Date(vm.today.getTime() + 24 * 60 * 60 * 1000);

            vm.ap = {'status':'open',
                         'due_year': tomorrow.getFullYear()+"",
                         'due_month': ("0" + (tomorrow.getMonth()+1)).slice(-2),
                         'due_day': ("0" + tomorrow.getDate()).slice(-2)
                        };
        } else {
            if (networkService.isOffline() === true) {
                var offlineActionPoints = tripService.getDraft(currentTrip.id, 'action_points');
                vm.ap = _.find(offlineActionPoints, function(actionPoint) { return actionPoint.id === $stateParams.actionPointId; });

            } else {
                vm.ap = tripService.getAP(currentTrip, $stateParams.actionPointId);
            }
        }

        function isPersonResponsibleCurrentUser(){
            if (parseInt(vm.ap.person_responsible) === parseInt(localStorageService.getObject('currentUser').id)) {
                vm.personResponsibleIsCurrentUser = true;
            } else {
                vm.personResponsibleIsCurrentUser = false;
            }
        }

        function paddedNumber(limit) {
            var result = [];
            for (var i = 1; i < limit + 1; i++) {
                result.push(i > 9 ? i + '' : '0' + i);
            }
            return result;
        }

        function submit() {
            vm.errors = {};

            // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
            if (!vm.ap.person_responsible) {
                // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
                vm.errors.person_responsible = true;
            }

            if (!vm.ap.description) {
                vm.errors.description = true;
            }

            if (Object.keys(vm.errors).length) {
                var template = '';

                if (vm.errors.description === true) {
                    template = $translate.instant('template.trip.report.action_point.edit.error.description.template');
                } else if (vm.errors.person_responsible === true) {
                    template = $translate.instant('template.trip.report.action_point.edit.error.person_responsible.template');
                }

                $ionicPopup.alert({
                    title: $translate.instant('template.trip.report.action_point.edit.error.title'),
                    template: template
                });

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

                if (networkService.isOffline() === true) {
                    $ionicLoading.hide();

                    // add additional fields
                    if (vm.isActionPointNew === true) {
                        vm.ap.id = md5.createHash((new Date()).getTime().toString());
                    }

                    vm.ap.person_responsible_name = _.find(vm.users, function(user) {
                        return parseInt(user.user_id) === parseInt(vm.ap.person_responsible);
                    }).full_name;

                    vm.ap.due_date = vm.ap.due_day + '/' + vm.ap.due_month + '/' + vm.ap.due_year;
                    vm.ap.completed_date = vm.ap.completed_date_day + '/' + vm.ap.completed_date_month + '/' + vm.ap.completed_date_year;

                    // add to exisiting action points if applicable
                    var offlineActionPoints = tripService.getDraft(currentTrip.id, 'action_points');

                    if (_.size(offlineActionPoints) > 0) {
                        // delete existing action point
                        offlineActionPoints = _.filter(offlineActionPoints, function(actionPoint) { return actionPoint.id !== vm.ap.id; });

                        // add action point being edited
                        offlineActionPoints.push(vm.ap);
                        vm.ap = offlineActionPoints;
                    } else {
                        vm.ap = [vm.ap];
                    }

                    tripService.setDraft(currentTrip.id, 'action_points', vm.ap);
                    displayPopup();

                } else {

                    tripService.sendAP(currentTrip.id, vm.ap,
                        function(success) {
                            $ionicLoading.hide();
                            tripService.localTripUpdate(currentTrip.id, success.data);
                            displayPopup();

                        }, function(err) {
                            errorHandler.popError(err);
                        }
                    );
                }
            }

            function displayPopup() {
                $ionicPopup.alert({
                    title: $translate.instant(alertTitle),
                    template: $translate.instant(alertTemplate)
                }).then(function() {
                    $ionicHistory.goBack(-1);
                    //$state.go('app.dash.reporting_action_point', { 'tripId' :  currentTrip.id });
                });
            }
        }
    }

})();
