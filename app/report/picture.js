(function() {
    'use strict';

    angular
        .module('app.report')
        .controller('Picture', Picture);

    Picture.$inject = ['$stateParams', 'pictureService'];

    function Picture($stateParams, pictureService) {
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