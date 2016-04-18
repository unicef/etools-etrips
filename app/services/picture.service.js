(function() {
    'use strict';

    angular
        .module('app.core')
        .service('pictureService', pictureService);

    function pictureService($cordovaFileTransfer, $ionicHistory, $ionicPopup, $q, $state, $stateParams, $translate, apiUrlService, localStorageService, lodash, md5, tripService){
        var _ = lodash;
        var pictureData = null;
        var service = {
            getPicture: getPicture,
            upload: upload
        };

        return service;

        function getPicture(type, data) {
            pictureData = data;
            var pictureOptions = {
                targetWidth: 1024,
                targetHeight: 1024,
                quality: 50
            };

            if (type == 'camera') {
                _.assignIn(
                    pictureOptions,
                    {
                        destinationType: navigator.camera.DestinationType.FILE_URI,
                        sourceType: navigator.camera.PictureSourceType.CAMERA,
                        saveToPhotoAlbum: true
                    }                    
                );

            } else if (type == 'photolibrary') {
                _.assignIn(
                    pictureOptions,
                    {
                        destinationType: navigator.camera.DestinationType.FILE_URI,
                        sourceType: navigator.camera.PictureSourceType.PHOTOLIBRARY
                    }                    
                );
            }

            navigator.camera.getPicture(
                saveSelectedPictureLocalStorage,
                selectPictureFail,
                pictureOptions
            );
        }

        function saveSelectedPictureLocalStorage(fileURI) {
            if (fileURI.substring(0,21)=="content://com.android") {
                var photo_split = fileURI.split("%3A");
                fileURI = "content://media/external/images/media/" + photo_split[1];
            }

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
                    'caption' : (pictureData.caption ? pictureData.caption : '' ), 
                    'filesize' : file.size
                };

                var pictures = picturesLocalStorage.concat(fileUriData);
                tripService.setDraft($stateParams.tripId, 'pictures', pictures);

                $ionicPopup.alert({
                    title: $translate.instant('controller.report.picture.upload.title'),
                    template: $translate.instant('controller.report.picture.upload.selected.title')
                }).then(function(){
                    $ionicHistory.goBack(-1);
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

        function selectPictureFail(message) {
            $ionicPopup.alert({
                title: $translate.instant('controller.report.picture.upload.title'),
                template: $translate.instant('controller.report.picture.upload.selected.failed.template')
            });
        }

        function upload(data) {
            var options = new FileUploadOptions();
            options.fileKey = 'file';
            options.fileName = 'picture';
            options.mimeType = 'image/jpeg';
            options.params = { caption:(data.caption) ? data.caption : '' };
            options.chunkedMode = false;
            options.encodeURI = true;
            options.headers = {
                Authorization: 'JWT ' + localStorageService.get('jwtoken'),
                Connection: 'close'
            };

            var uploadUrl = apiUrlService.BASE() + '/trips/api/' + data.trip_id + '/upload/';

            return $cordovaFileTransfer.upload(uploadUrl, data.filepath, options, true);     
        }
    }

})();