(function() {
    'use strict';

    angular
        .module('app.core')
        .service('pictureService', pictureService);

    function pictureService($cordovaFile, $cordovaFileTransfer, $ionicHistory, $ionicPopup, $q, $state, $stateParams, $translate, apiUrlService, localStorageService, lodash, md5, tripService){
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

            if (type === 'camera') {
                _.assignIn(
                    pictureOptions, {
                        destinationType: navigator.camera.DestinationType.FILE_URI,
                        sourceType: navigator.camera.PictureSourceType.CAMERA,
                        saveToPhotoAlbum: true
                    }
                );

            } else if (type === 'photolibrary') {
                _.assignIn(
                    pictureOptions, {
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
            var picturesLocalStorage = tripService.getDraft($stateParams.tripId, 'pictures');

            if (_.isEmpty(picturesLocalStorage)) {
                picturesLocalStorage = [];
            }

            getFileUriData(fileURI).then(function(file){
                if (cordova.file.tempDirectory === null) {
                    selectPictureSuccess(file, fileURI, fileURI, picturesLocalStorage);

                } else {
                    var fileExt = '.' + file.name.split('.').pop();
                    var newFileName = md5.createHash(file.name + Math.random()) + fileExt;

                    $cordovaFile.copyFile(cordova.file.tempDirectory, file.name, cordova.file.dataDirectory, newFileName).then(
                        function(success) {
                            selectPictureSuccess(file, cordova.file.dataDirectory + newFileName, fileURI, picturesLocalStorage);
                        },
                        selectPictureFail
                    );
                }
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

            function selectPictureSuccess(file, filepath, fileURI, picturesLocalStorage) {
                var fileUriData = {
                            'id' : md5.createHash(fileURI.toString()),
                            'filepath' : filepath,
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
            }
        }

        function selectPictureFail() {
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
            options.params = {
                caption: (data.caption) ? data.caption : ''
            };
            options.chunkedMode = false;
            options.encodeURI = true;
            options.headers = {
                Authorization: 'JWT ' + localStorageService.get('jwtoken'),
                Connection: 'close'
            };

            // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
            var uploadUrl = apiUrlService.BASE() + '/trips/api/' + data.trip_id + '/upload/';

            return $cordovaFileTransfer.upload(uploadUrl, data.filepath, options, true);
        }
    }

})();
