(function() {
    'use strict';

    angular
        .module('app.report')
        .controller('Picture', Picture);

    Picture.$inject = ['$ionicPopup', 'localStorageService', '$stateParams', 'tripService', '$http', 'apiUrlService', 'errorHandler', 'networkService', '$translate'];

    function Picture($ionicPopup, localStorageService, $stateParams, tripService, $http, apiUrlService, errorHandler, networkService, $translate) {
        var vm = this;
        vm.data = {};
        vm.mobileUploadPhoto = mobileUploadPhoto;
        vm.takePicture = takePicture;
        vm.trip = tripService.getTrip($stateParams.tripId);
        vm.uploadExisting = uploadExisting;

        function mobileUploadPhoto(fileURI) {
            var options = new FileUploadOptions();
            options.fileKey = 'file';
            options.fileName = 'picture';
            options.mimeType = 'image/jpeg';
            options.params = { caption:(vm.data.caption) ? vm.data.caption : '' };
            options.chunkedMode = false;
            options.headers = {
                Authorization: 'JWT ' + localStorageService.get('jwtoken'),
                Connection: 'close'
            };

            var ft = new FileTransfer();
            ft.upload(fileURI,
                        encodeURI(apiUrlService.BASE() + '/trips/api/' + $stateParams.tripId + '/upload/'),
                        successful,
                        failed,
                        options,
                        true);

            function successful(mdata) {
                $ionicPopup.alert({
                    title: $translate.instant('controller.report.picture.upload.success.title'),
                    template: $translate.instant('controller.report.picture.upload.success.template')
                });
            }

            function failed(err) {
                if (networkService.isOffline() === true) {
                    networkService.showMessage(
                        $translate.instant('controller.report.picture.upload.fail.title'),
                        $translate.instant('controller.report.picture.upload.fail.template')
                    );
                }
            }
        }

        function takePicture() {
            navigator.camera.getPicture(mobileUploadPhoto,
                function(message) { 
                    alert('Failed to access camera'); 
                },
                {
                    quality: 50,
                    destinationType: navigator.camera.DestinationType.FILE_URI,
                    sourceType: navigator.camera.PictureSourceType.CAMERA,
                    saveToPhotoAlbum: true
                }
            );
        }

        function uploadExisting(){
            navigator.camera.getPicture(mobileUploadPhoto,
                function(message) { 
                    alert('Failed to access your library');
                },
                {   
                    quality: 50,
                    destinationType: navigator.camera.DestinationType.FILE_URI,
                    sourceType: navigator.camera.PictureSourceType.PHOTOLIBRARY
                }
            );
        }
    }

})();