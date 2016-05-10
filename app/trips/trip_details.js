(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('TripDetails', TripDetails);

    TripDetails.$inject = ['$ionicModal', '$scope', '$stateParams', 'tripService', 'localStorageService', '$ionicLoading', '$ionicHistory', '$state', '$ionicPopup', 'errorHandler', 'networkService', '$translate', 'lodash'];

    function TripDetails($ionicModal, $scope, $stateParams, tripService, localStorageService, $ionicLoading, $ionicHistory, $state, $ionicPopup, errorHandler, networkService, $translate, _) {
        var vm = this;
        vm.approve = approve;
        vm.closeModal = closeModal;
        vm.dateFormat = 'dd/MM/yyyy HH:mm';
        vm.completeTrip = completeTrip;
        vm.goReport = goReport;
        vm.modalPicture = {'filepath': ''};
        vm.openModal = openModal;
        vm.showConfirm = showConfirm;
        vm.submit = submit;
        vm.takeNotes = takeNotes;
        vm.timezone = '';
        vm.trip = tripService.getTrip($stateParams.tripId);
        vm.pictureDimension = 0;

        var pictures = _.map(vm.trip.files, function(picture) {
            return {
                filepath: 'http://lorempixel.com/800/800/',//picture.file,
                caption: picture.caption
            };
        });

        vm.pictures = pictures;

        // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
        var uid = localStorageService.getObject('currentUser').user_id;

        vm.checks = {
            supervisor: vm.trip.supervisor === uid,
            owner: vm.trip.traveller_id === uid,
            is_approved: vm.trip.status === 'approved',
            not_supervisor_approved: (!vm.trip.approved_by_supervisor),
            is_planned: vm.trip.status === 'planned',
            is_canceled: vm.trip.status === 'cancelled',
            is_submitted: vm.trip.status === 'submitted',
            report_filled: vm.trip.main_observations
        };

        $ionicModal.fromTemplateUrl('./templates/pictures/pictures_modal.html', {
            scope: $scope,
            animation: 'slide-in-up'
        }).then(function(modal) {
            $scope.modal = modal;
        });

        $scope.$on('$destroy', function() {
            $scope.modal.remove();
        });

        ionic.Platform.ready(function() {
            var pictureGridCount = 3;
            vm.pictureDimension = parseInt(window.innerWidth / pictureGridCount) - pictureGridCount * 4;

            if (navigator.globalization !== undefined) {
                navigator.globalization.getDatePattern(function(obj) {
                    if (obj.timezone !== undefined) {
                        vm.timezone = obj.timezone;
                    }
                });
            }
        });

        function openModal(picture) {
            vm.modalPicture = picture;
            $scope.modal.show();
        }

        function closeModal() {
            $scope.modal.hide();
        }

        function approve(tripId) {
            if (networkService.isOffline() === true) {
                networkService.showMessage();
            } else {
                $ionicLoading.show({
                    template: '<loading message="sending_report"></loading>'
                });
                tripService.tripAction(tripId, 'approved', {}).then(
                    function(actionSuccess) {
                        $ionicLoading.hide();
                        tripService.localTripUpdate(tripId, actionSuccess.data);

                        $ionicPopup.alert({
                            title: $translate.instant('controller.trip.detail.approved.title'),
                            template: $translate.instant('controller.trip.detail.approved.template')
                        }).then(function() {
                            $ionicHistory.goBack(); //('app.dash.my_trips');
                        });
                    },
                    function(err) {
                        errorHandler.popError(err);
                    }
                );
            }
        }

        function completeTrip(tripId) {
            var now = new Date();
            now.setHours(0, 0, 0, 0);

            var tripEnd = new Date(vm.trip.to_date);

            if (now < tripEnd) {
                vm.showConfirm($translate.instant('controller.trip.detail.complete.title'), executeRequest);
                return;
            }

            executeRequest();

            function executeRequest() {
                if (networkService.isOffline() === true) {
                    networkService.showMessage();
                } else {
                    $ionicLoading.show({
                        template: '<loading message="submitting_trip"></loading>'
                    });

                    tripService.tripAction(tripId, 'completed', {}).then(
                        function(actionSuccess) {
                            $ionicLoading.hide();
                            tripService.localTripUpdate(tripId, actionSuccess.data);

                            $ionicPopup.alert({
                                title: $translate.instant('controller.trip.complete.title'),
                                template: $translate.instant('controller.trip.complete.template')
                            }).then(function() {
                                $state.go('app.dash.my_trips');
                            });
                        },
                        function(err) {
                            errorHandler.popError(err);
                        }
                    );
                }
            }
        }

        function goReport(tripId) {
            $state.go('app.dash.reporting', {
                'tripId': tripId
            });
        }

        function showConfirm(template, succ) {
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
                $ionicLoading.show({
                    template: '<loading message="submitting_trip"></loading>'
                });
                tripService.tripAction(tripId, 'submitted', {}).then(

                    function() {
                        $ionicLoading.hide();
                        tripService.localSubmit(tripId);

                        $ionicPopup.alert({
                            title: $translate.instant('controller.trip.submit.title'),
                            template: $translate.instant('controller.trip.submit.template')
                        }).then(function() {
                            $ionicHistory.goBack(); //('app.dash.my_trips');
                        });
                    },
                    function(err) {
                        errorHandler.popError(err);
                    }
                );
            }
        }

        function takeNotes(tripId) {
            $state.go('app.dash.notes', {
                'tripId': tripId
            });
        }
    }

})();
