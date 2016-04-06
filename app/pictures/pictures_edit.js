(function() {
    'use strict';

    angular
        .module('app.pictures')
        .controller('PicturesEdit', PicturesEdit);

    PicturesEdit.$inject = ['$stateParams', 'pictureService'];

    function PicturesEdit($stateParams, pictureService) {
        var vm = this;
        vm.data = {};
        vm.filesize = 0;
        vm.takePicture = getPictureCamera;
        vm.uploadExisting = getPicturePhotoLibrary;

        function getPictureCamera() {
           pictureService.getPicture('camera', vm.data);
        }

        function getPicturePhotoLibrary(){
            pictureService.getPicture('photolibrary', vm.data);
        }
    }

})();