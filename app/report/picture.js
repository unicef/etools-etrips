(function() {
    'use strict';

    angular
        .module('app.report')
        .controller('Picture', Picture);

    Picture.$inject = ['$stateParams', 'pictureService', 'tripService'];

    function Picture($stateParams, pictureService, tripService) {
        var vm = this;
        vm.data = {};
        vm.filesize = 0;
        vm.takePicture = getPictureCamera;
        vm.trip = tripService.getTrip($stateParams.tripId);
        vm.uploadExisting = getPicturePhotoLibrary;

        function getPictureCamera() {
           pictureService.getPicture('camera', vm.data);
        }

        function getPicturePhotoLibrary(){
            pictureService.getPicture('photolibrary', vm.data);
        }
    }

})();