(function() {
    'use strict';

    angular
        .module('app.report')
        .controller('Text', Text);

    Text.$inject = ['$filter', '$ionicHistory', '$ionicLoading', '$ionicPopup', '$q', '$stateParams', '$translate', 'errorHandler', 'networkService', 'pictureService', 'tripService', 'lodash'];

    function Text($filter, $ionicHistory, $ionicLoading, $ionicPopup, $q, $stateParams, $translate, errorHandler, networkService, pictureService, tripService, _) {
        var selectedPicturesFilesizeLimit = 250000;

        var vm = this;
        vm.trip = tripService.getTrip($stateParams.tripId);
        vm.autosave = autosave;
        vm.submit = submit;
        vm.pictureFileSizeTotal = 0;

        var fields = ['main_observations', 'constraints', 'lessons_learned', 'opportunities', 'pictures'];
        var mainObservationsTemplate = $translate.instant('controller.report.text.observations.access') + '\n \n \n \n' +
        $translate.instant('controller.report.text.observations.quality') + '\n \n \n \n' +
        $translate.instant('controller.report.text.observations.utilisation') + '\n \n \n \n' +
        $translate.instant('controller.report.text.observations.enabling') + '\n \n \n \n';

        // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
        if (vm.trip.main_observations !== undefined && vm.trip.main_observations !== null && vm.trip.main_observations.length > 0) {
            vm.data = {
                main_observations: vm.trip.main_observations,
                constraints: vm.trip.constraints,
                lessons_learned: vm.trip.lessons_learned,
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
                        reportText[field] = mainObservationsTemplate;
                    } else {
                        reportText[field] = '';
                    }
                }
            });

            vm.data = reportText;
        }

        function autosave() {
            if (vm.trip.main_observations === undefined || vm.trip.main_observations === null || vm.trip.main_observations.length === 0) {
                fields.forEach(function(field) {
                    tripService.setDraft($stateParams.tripId, field, vm.data[field]);
                });
            }
        }

        function submit() {
            if (networkService.isOffline() === true) {
                networkService.showMessage();

            } else {
                var picturesLocalStorage = tripService.getDraft($stateParams.tripId, 'pictures');

                if (picturesLocalStorage !== undefined) {
                    var totalFileSize = 0;
                    var promises = [];

                    _.each(picturesLocalStorage, function(picture) {
                        var data = {
                            'caption': picture.caption,
                            'filepath': picture.filepath,
                            'trip_id': $stateParams.tripId
                        };

                        totalFileSize = totalFileSize + picture.filesize;
                        promises.push(pictureService.upload(data));
                    });

                    if (totalFileSize >= selectedPicturesFilesizeLimit) {
                        $ionicPopup.confirm({
                            title: $translate.instant('controller.report.text.title'),
                            template: $translate.instant('controller.report.text.picture.template', {
                                selected_pictures_filesize: $filter('bytes')(totalFileSize),
                                filesize_limit: '250 kB'
                            })
                        }).then(function(res) {
                            if (res) {
                                submitDeferredReportText(promises);
                            } else {
                                promises = [];
                            }
                        });
                    } else {
                        submitDeferredReportText(promises);
                    }
                } else {
                    submitReportText();
                }
            }

            function submitDeferredReportText(promises) {
                $ionicLoading.show({
                    template: '<loading message="submitting_report"></loading>'
                });

                $q.all(promises).then(function() {
                    submitReportText();
                });
            }

            function submitReportText() {
                tripService.reportText(vm.data, vm.trip.id,
                    function(succ) {
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
                    }, function(err) {
                        errorHandler.popError(err);
                    }
                );
            }
        }
    }

})();
