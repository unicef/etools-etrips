angular.module('equitrack.tripControllers', [])

.controller('Report', function($stateParams){
    var vm = this;
    vm.trip_id = $stateParams.tripId;
})

.controller('ReportingText', function($scope, $stateParams, tripService, $ionicLoading, $ionicHistory, $ionicPopup, errorHandler, networkService, $translate){    
  var fields = ['main_observations', 'constraints', 'lessons_learned', 'opportunities'];
  var main_obs_template = $translate.instant('controller.report.text.observations.access') + '\n \n \n \n' +
  $translate.instant('controller.report.text.observations.quality') + '\n \n \n \n' +
  $translate.instant('controller.report.text.observations.utilisation') + '\n \n \n \n' +
  $translate.instant('controller.report.text.observations.enabling') + '\n \n \n \n';

  $scope.trip = tripService.getTrip($stateParams.tripId);

  // report submitted
  if ($scope.trip.main_observations.length > 0) {
    $scope.data = {
        main_observations : $scope.trip.main_observations,
        constraints : $scope.trip.constraints,
        lessons_learned : $scope.trip.lessons_learned,
        opportunities: $scope.trip.opportunities
    };
  } else {          
    var reportText = {};

    fields.forEach(function(field) {
      var data = tripService.getDraft($stateParams.tripId, field);

      if (data.length > 0) {
        reportText[field] = data;
      } else {
        if (field === 'main_observations') {
          reportText[field] = main_obs_template;
        } else {
          reportText[field] = '';
        }
      }
    });

    $scope.data = reportText;
  }

  $scope.autosave = function() {
    if ($scope.trip.main_observations.length === 0) {            
      fields.forEach(function(field) {
        tripService.setDraft($stateParams.tripId, field, $scope.data[field]);    
      });
    }
  };

  $scope.submit = function(){
    if (networkService.isOffline() === true) {
      networkService.showMessage();

    } else {
      $ionicLoading.show( { template: '<loading message="sending_report"></loading>' } );

      tripService.reportText($scope.data, $scope.trip.id, 
        function(succ){
          $ionicLoading.hide();
          $ionicHistory.goBack(-1);
          
          tripService.localTripUpdate($scope.trip.id, succ.data);
          
          fields.forEach(function(field) {
            tripService.deleteDraft($stateParams.tripId, field);    
          });

          $ionicPopup.alert({
              title: $translate.instant('controller.report.text.submitted.title'),
              template: $translate.instant('controller.report.text.submitted.template')
          });
        }, function(err){
          errorHandler.popError(err);
        }
      );
    }
  };
})

.controller('NotesCtrl', function($scope, $stateParams, tripService, $ionicLoading, $ionicHistory, $state, $ionicPopup, errorHandler, $translate, $ionicPlatform){
  $scope.trip = tripService.getTrip($stateParams.tripId);
  $scope.notes = tripService.getDraft($stateParams.tripId, 'notes');

  $ionicPlatform.ready(function() {    
    reset_data();
  });
  
  function reset_data(){
    $scope.data = {
        text : ($scope.notes.text) ? $scope.notes.text : "",
    };
  }
  
  $scope.saveNotes = function(){
    tripService.setDraft($stateParams.tripId, 'notes', $scope.data);
    $ionicPopup.alert({
                title: $translate.instant('controller.notes.save.title'),
                template: $translate.instant('controller.notes.save.template')
            });
  };
  $scope.discardNotes = function(){
    tripService.setDraft($stateParams.tripId, 'notes', {});
    $scope.notes = tripService.getDraft($stateParams.tripId, 'notes');
    reset_data();
    $ionicPopup.alert({
                title: $translate.instant('controller.notes.discard.title'),
                template: $translate.instant('controller.notes.discard.template')
            });
  };
})

.controller('ReportingActionPoint',function($stateParams, tripService){
    var vm = this;
    vm.trips = tripService.getTrip($stateParams.tripId);
    vm.trip_id = $stateParams.tripId;
})

.controller('ReportingActionPointEdit',
    function($scope, $stateParams, tripService, localStorageService, $ionicLoading, $ionicHistory, $ionicPopup, $state, dataService, errorHandler, $locale, networkService, $translate) {        
        var vm = this;
        vm.title = 'template.trip.report.action_point.edit.title';
        vm.isActionPointNew = false;

        if ($state.current.name.indexOf('new') > 0) {
            vm.title = 'template.trip.report.action_point.new';
            vm.isActionPointNew = true;
        }

        $scope.today = new Date();

        $scope.padded_num = function(limit){
            var result = [];
            for (var i=1; i<limit+1; i++){
                result.push(i>9 ? i+'' : "0"+i);
            }
            return result;
        };
        var currentTrip = tripService.getTrip($stateParams.tripId);

        $scope.allMonths = $locale.DATETIME_FORMATS.SHORTMONTH;
        $scope.yearOptions = [$scope.today.getFullYear()+"",
                              $scope.today.getFullYear()+1+""];

        dataService.get_user_base(
            function(successData){
                $scope.users = successData;
            },
            function(err){
                errorHandler.popError(err);
            }
        );

        if (vm.isActionPointNew === true) {
            var tomorrow = new Date($scope.today.getTime() + 24 * 60 * 60 * 1000);

            $scope.ap = {'status':'open',
                         'due_year': tomorrow.getFullYear()+"",
                         'due_month': ("0" + (tomorrow.getMonth()+1)).slice(-2),
                         'due_day': ("0" + tomorrow.getDate()).slice(-2)
                        };
        } else {
            $scope.ap = tripService.getAP(currentTrip, $stateParams.actionPointId);            
        }

        $scope.submit = function (){            
            $scope.errors = {};
            $scope.error = false;

            if (!$scope.ap.person_responsible){
                $scope.errors.person_responsible = true;
            }

            if (!$scope.ap.description){
                $scope.errors.description = true;
            }

            if (Object.keys($scope.errors).length){
                $scope.error = true;
                return;
            } else {
                if (networkService.isOffline() === true) {
                    networkService.showMessage();
                } else {
                    var loadingMessage = 'updating_action_point';
                    var alertTitle = 'controller.trip.action_point.edit.title';
                    var alertTemplate = 'controller.trip.action_point.edit.template';

                    if (vm.isActionPointNew === true) {
                        loadingMessage = 'updating_action_point';
                        alertTitle = 'controller.trip.action_point.new.title';
                        alertTemplate = 'controller.trip.action_point.new.template';
                    }

                    $ionicLoading.show({
                        template: '<loading message="' + loadingMessage + '"></loading>'
                    });

                    tripService.sendAP(currentTrip.id, $scope.ap,
                        function (success) {
                            $ionicLoading.hide();                            
                            tripService.localTripUpdate(currentTrip.id, success.data);
                            
                            $ionicPopup.alert({
                                title: $translate.instant(alertTitle),
                                template: $translate.instant(alertTemplate)
                            }).then(function(res){                                
                                $state.go('app.dash.reporting_action_point', { 'tripId' :  currentTrip.id });
                            });

                        }, function (err) {
                            errorHandler.popError(err);
                    });
                }
            }
        };
    }
)

.controller('ReportingPicture',function($scope,$ionicPopup, localStorageService, $stateParams, tripService, $http, apiUrlService, errorHandler, networkService, $translate){

        $scope.trip = tripService.getTrip($stateParams.tripId);
        $scope.data = {};

        var mobileUploadPhoto = function(fileURI){

            var options = new FileUploadOptions();
            options.fileKey = "file";
            options.fileName = "picture";
            options.mimeType = "image/jpeg";
            options.params = {caption:($scope.data.caption)? $scope.data.caption : ""};
            options.chunkedMode = false;
            options.headers = {
                Authorization: 'JWT  ' + localStorageService.get('jwtoken'),
                Connection: "close"
            };

            var ft = new FileTransfer();
            ft.upload(fileURI,
                      encodeURI(apiUrlService.BASE() +"/trips/api/"+$stateParams.tripId+"/upload/"),
                      function(mdata){
                        var alertPopup = $ionicPopup.alert({
                          title: $translate.instant('controller.report.picture.upload.success.title'),
                          template: $translate.instant('controller.report.picture.upload.success.template')
                        });
                      },
                      function(err){
                        if (networkService.isOffline() === true) {
                          networkService.showMessage(
                            $translate.instant('controller.report.picture.upload.fail.title'),
                            $translate.instant('controller.report.picture.upload.fail.template')
                          );
                        }
                      },
                      options, true);
        };

        // TODO: check getPicture / takePicture for alert function parameter
        $scope.uploadExisting = function(){
            navigator.camera.getPicture(mobileUploadPhoto,
                function(message) { alert('Failed to access your library'); },
                {quality: 50,
                    destinationType: navigator.camera.DestinationType.FILE_URI,
                    sourceType: navigator.camera.PictureSourceType.PHOTOLIBRARY }
            );
        };
        $scope.takePicture = function(){
            navigator.camera.getPicture(mobileUploadPhoto,
                function(message) { alert('Failed to access camera'); },
                {quality: 50,
                    destinationType: navigator.camera.DestinationType.FILE_URI,
                    sourceType: navigator.camera.PictureSourceType.CAMERA,
                    saveToPhotoAlbum: true}
            );
        };
        //this is for local testing only
        $scope.uploadFile = function(files) {
            var fd = new FormData();
            //Take the first selected file
            fd.append("file", files[0]);
            fd.append('trip', $stateParams.tripId);

            $http.post(apiUrlService.BASE() +"/trips/api/"+$stateParams.tripId+"/upload/", fd,
                {
                    headers: {'Content-Type': undefined },
                    transformRequest: angular.identity
                }).then(
                    function(data){
                        console.log(data);
                    },
                    function(err){
                        console.log(err);
                    }
                );

};

})
;