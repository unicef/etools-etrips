(function() {
    'use strict';

    angular
        .module('app.notes')
        .controller('Notes', Notes);

    Notes.$inject = ['$scope', '$stateParams', 'tripService', '$ionicLoading', '$ionicHistory', '$state', '$ionicPopup', 'errorHandler', '$translate', '$ionicPlatform'];

    function Notes($scope, $stateParams, tripService, $ionicLoading, $ionicHistory, $state, $ionicPopup, errorHandler, $translate, $ionicPlatform) {
        var vm = this;
        vm.discardNotes = discardNotes;
        vm.notes = tripService.getDraft($stateParams.tripId, 'notes');
        vm.saveNotes = saveNotes;
        vm.trip = tripService.getTrip($stateParams.tripId);

        $ionicPlatform.ready(function() {
            resetData();
        });

        function discardNotes() {
            tripService.setDraft($stateParams.tripId, 'notes', {});
            vm.notes = tripService.getDraft($stateParams.tripId, 'notes');
            resetData();
            $ionicPopup.alert({
                        title: $translate.instant('controller.notes.discard.title'),
                        template: $translate.instant('controller.notes.discard.template')
                    });
        }

        function saveNotes() {
            tripService.setDraft($stateParams.tripId, 'notes', vm.data);
            $ionicPopup.alert({
                        title: $translate.instant('controller.notes.save.title'),
                        template: $translate.instant('controller.notes.save.template')
                    });
        }

        function resetData() {
            vm.data = {
                text: (vm.notes.text) ? vm.notes.text : '',
            };
        }
    }

})();
