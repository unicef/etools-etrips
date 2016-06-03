(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('AddTrip', AddTrip);

    AddTrip.$inject = ['$ionicHistory', '$ionicLoading', '$ionicPopup', '$state', '$translate', 'dataService', 'errorHandler', 'tripService'];

    function AddTrip($ionicHistory, $ionicLoading, $ionicPopup, $state, $translate, dataService, errorHandler, tripService) {
        var vm = this;
        vm.save = save;
        vm.title = '';

        var data = {};

        function save() {
            $ionicLoading.show({
                template: '<loading message="saving_trip"></loading>'
            });

            tripService.saveTrip(data).then(
                function() {
                    $ionicLoading.hide();

                    $ionicPopup.alert({
                        title: $translate.instant('controller.trip.add_trip.save.title'),
                        template: $translate.instant('controller.trip.add_trip.save.template')
                    }).then(function() {
                        $ionicHistory.backView().stateParams = {refreshed:true};
                        $ionicHistory.goBack();
                    });
                },
                function(err) {
                    errorHandler.popError(err);
                }
            );
        }
    }
})();