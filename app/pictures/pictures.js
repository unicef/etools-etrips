(function() {
    'use strict';

    angular
        .module('app.pictures')
        .controller('Pictures', Pictures);

    Pictures.$inject = ['$ionicListDelegate', '$ionicModal', '$ionicPopup', '$scope', '$stateParams', '$translate', 'tripService', 'lodash'];

    function Pictures($ionicListDelegate, $ionicModal, $ionicPopup, $scope, $stateParams, $translate, tripService, _) {
        var tripId = $stateParams.tripId;
        var draftPictures = tripService.getDraft(tripId, 'pictures');

        var vm = this;
        vm.deletePicture = deletePicture;
        vm.openModal = openModal;
        vm.closeModal = closeModal;
        vm.modalPicture = {'filepath': ''};
        vm.pictures = draftPictures;
        vm.picturesFilesize = _.sumBy(draftPictures, function(picture) { return picture.filesize; });
        vm.tripId = tripId;

        setPicturesFilesize();

        $ionicModal.fromTemplateUrl('./templates/pictures/pictures_modal.html', {
            scope: $scope,
            animation: 'slide-in-up'
        }).then(function(modal) {
            $scope.modal = modal;
        });

        $scope.$on('$destroy', function() {
            $scope.modal.remove();
        });

        function openModal(picture) {
            $ionicListDelegate.closeOptionButtons();
            vm.modalPicture = picture;
            $scope.modal.show();
        }

        function closeModal() {
            $scope.modal.hide();
        }

        function setPicturesFilesize() {
            vm.picturesFilesize = _.sumBy(vm.pictures, function(picture) { return picture.filesize; });
        }

        function deletePicture(id) {
            $ionicPopup.confirm({
                title: $translate.instant('controller.report.picture.upload.delete.title'),
                template: $translate.instant('controller.report.picture.upload.delete.template'),
            }).then(function(result) {
                if (result) {

                    vm.pictures = _.filter(vm.pictures, function(picture) {
                        return picture.id !== id;
                    });

                    tripService.setDraft(tripId, 'pictures', vm.pictures);
                    setPicturesFilesize();

                } else {
                    $ionicListDelegate.closeOptionButtons();
                }
            });
        }
    }

})();
