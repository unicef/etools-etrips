(function() {
    'use strict';

    angular
        .module('app.report')
        .controller('Picture', Picture);

    Picture.$inject = ['$q', '$ionicPopup', 'localStorageService', '$stateParams', 'tripService', '$http', 'apiUrlService', 'errorHandler', 'networkService', '$translate', 'lodash', 'md5'];

    function Picture($q, $ionicPopup, localStorageService, $stateParams, tripService, $http, apiUrlService, errorHandler, networkService, $translate, lodash, md5) {
        var vm = this;
        vm.data = {};
        vm.filesize = 0;
        vm.takePicture = takePicture;
        vm.trip = tripService.getTrip($stateParams.tripId);
        vm.uploadExisting = uploadExisting;

        var _ = lodash;
        var imageQuality = 50;   
        
        function takePicture() {
            navigator.camera.getPicture(
                saveSelectedPictureLocalStorage,
                selectPictureFail,
                {
                    quality: imageQuality,
                    destinationType: navigator.camera.DestinationType.FILE_URI,
                    sourceType: navigator.camera.PictureSourceType.CAMERA,
                    saveToPhotoAlbum: true
                }
            );
        }

        function uploadExisting(){
            navigator.camera.getPicture(
                saveSelectedPictureLocalStorage,
                selectPictureFail,                
                {   
                    quality: imageQuality,
                    destinationType: navigator.camera.DestinationType.FILE_URI,
                    sourceType: navigator.camera.PictureSourceType.PHOTOLIBRARY
                }
            );
        }

        function selectPictureFail(message) {
            $ionicPopup.alert({
                title: $translate.instant('controller.report.picture.upload.title'),
                template: $translate.instant('controller.report.picture.upload.selected.failed.template')
            });
        }

        function saveSelectedPictureLocalStorage(fileURI) {
            var picturesLocalStorage = tripService.getDraft($stateParams.tripId, 'pictures');

            if (_.isEmpty(picturesLocalStorage)) {
                picturesLocalStorage = [];
            }

            // remove selected picture from array if it exists
            picturesLocalStorage = _.filter(picturesLocalStorage, function(o) { return o.filepath !== fileURI; });

            getFileUriData(fileURI).then(function(file){
                var fileUriData = { 
                    'id' : md5.createHash(fileURI.toString()), 
                    'filepath' : fileURI, 
                    'caption' : (vm.data.caption ? vm.data.caption : '' ), 
                    'filesize' : file.size
                };

                var pictures = picturesLocalStorage.concat(fileUriData);
                tripService.setDraft($stateParams.tripId, 'pictures', pictures);

                $ionicPopup.alert({
                    title: $translate.instant('controller.report.picture.upload.title'),
                    template: $translate.instant('controller.report.picture.upload.selected.title')
                });
            });

            function getFileUriData(fileURI) {
                var deferred = $q.defer();
                
                window.resolveLocalFileSystemURL(fileURI, function(fileEntry){
                    fileEntry.file(function(file) {
                        deferred.resolve(file);
                    });
                });

                return deferred.promise;
            }
        }

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
    }

})();