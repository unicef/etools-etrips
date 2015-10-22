/**
 * Created by Robi on 9/15/15.
 */


angular.module('equitrack.tripControllers', [])

.controller('TripCtrl', function($scope, $ionicModal, $timeout) {
    $scope.data = {};
})

.controller('ReportingCtrl',function($scope, $stateParams, TripsFactory){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);

        // deprecated:
        //$scope.submit = function (){
        //    TripsFactory.tripAction($stateParams.tripId, 'report', {}).then(
        //        function(actionSuccess){
        //            console.log("Action succeded")
        //        },
        //        function(actionFailed){
        //            console.error("Action failed")
        //        }
        //    )
        //}
})
.controller('ReportingTextCtrl', function($scope, $stateParams, TripsFactory,$ionicLoading, $ionicHistory, $ionicPopup, ErrorHandler){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);
        var main_obs_template = 'Access to inputs/services:  \n \n \n \n' +
            'Quality of inputs/services: \n \n \n \n' +
            'Utilisation of inputs/services: \n \n \n \n' +
            'Enabling Environment: \n \n \n \n'

        $scope.data = {
            main_observations : ($scope.trip.main_observations) ? $scope.trip.main_observations : main_obs_template,
            constraints : ($scope.trip.constraints) ? $scope.trip.constraints : "",
            lessons_learned : ($scope.trip.lessons_learned) ? $scope.trip.lessons_learned : "",
            opportunities: ($scope.trip.opportunities) ? $scope.trip.opportunities : "",
        }
        $scope.textReport = function(){
            $ionicLoading.show({
                    template: 'Loading... <br> Sending Report...'
                });
            TripsFactory.reportText($scope.data, $scope.trip.id,
                function(succ){
                    $ionicLoading.hide();
                    $ionicHistory.goBack(-1);
                    TripsFactory.localTripUpdate($scope.trip.id, succ.data)
                    $ionicPopup.alert({
                        title: 'Report Submitted',
                        template: 'Text has been succcessfully submitted'
                    })
                    console.log(succ)
                }, function(err){ErrorHandler.popError(err)}
            )
        }

}).controller('ReportingDraftsCtrl', function($scope, $stateParams, TripsFactory, $ionicLoading, $ionicHistory, $state, $ionicPopup, ErrorHandler){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);
        $scope.draft = TripsFactory.getDraft($stateParams.tripId, 'text');
        $scope.dangeZone = false;
        console.log('here are the drafts')
        console.log($scope.draft)

        var main_obs_template = 'Access to inputs/services:  \n \n \n \n' +
            'Quality of inputs/services: \n \n \n \n' +
            'Utilisation of inputs/services: \n \n \n \n' +
            'Enabling Environment: \n \n \n \n'

        function reset_data(){
            $scope.data = {
                main_observations : ($scope.draft.main_observations) ? $scope.draft.main_observations : main_obs_template,
                constraints : ($scope.draft.constraints) ? $scope.draft.constraints : "",
                lessons_learned : ($scope.draft.lessons_learned) ? $scope.draft.lessons_learned : "",
                opportunities: ($scope.draft.opportunities) ? $scope.draft.opportunities : "",
            }
        }
        reset_data()

        $scope.saveDrafts = function(){
            TripsFactory.setDraft($stateParams.tripId, 'text', $scope.data)
            $ionicPopup.alert({
                        title: 'Draft Saved',
                        template: 'Text has been successfully saved'
                    })
        };
        $scope.discardDrafts = function(){
            TripsFactory.setDraft($stateParams.tripId, 'text', {})
            $scope.draft = TripsFactory.getDraft($stateParams.tripId, 'text')
            reset_data()
            $ionicPopup.alert({
                        title: 'Draft Discarded',
                        template: 'Text has been successfully discarded'
                    })
        };
        $scope.discardCurrentChanges = function(){
            $scope.draft = TripsFactory.getDraft($stateParams.tripId, 'text')
            reset_data();
            $ionicPopup.alert({
                        title: 'Current Changes Discarded',
                        template: 'Text restored to previous state'
                    })
        };
        $scope.replaceWithCurrentReport = function(){
            $scope.draft = {
                main_observations : ($scope.trip.main_observations) ? $scope.trip.main_observations : main_obs_template,
                constraints : ($scope.trip.constraints) ? $scope.trip.constraints : "",
                lessons_learned : ($scope.trip.lessons_learned) ? $scope.trip.lessons_learned : "",
                opportunities: ($scope.trip.opportunities) ? $scope.trip.opportunities : "",
            };
            reset_data();
            $ionicPopup.alert({
                        title: 'Drafts updated',
                        template: "Current Drafts are reflecting current report, changes aren't saved until your action"
                    })
        };
        $scope.textReport = function(){
            $ionicLoading.show({
                    template: 'Loading... <br> Sending Report...'
                });
            TripsFactory.setDraft($stateParams.tripId, 'text', $scope.data)
            TripsFactory.reportText($scope.data, $scope.trip.id,
                function(succ){
                    $ionicLoading.hide();
                    $ionicHistory.nextViewOptions({
                        disableBack: true
                    });
                    $state.go('app.dash.my_trips');
                    TripsFactory.localTripUpdate($scope.trip.id, succ.data)
                    $ionicPopup.alert({
                        title: 'Report Submitted',
                        template: 'Text has been successfully submitted'
                    })
                    console.log(succ)
                }, function (err){ErrorHandler.popError(err)})
        }

})
.controller('ReportingAPSCtrl',function($scope, $stateParams, TripsFactory){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);
        $scope.newAP = function(){
            $state.go('')
        }

})
.controller('ReportingPictureCtrl',function($scope,$ionicPopup, $localStorage, $stateParams, TripsFactory, $http, API_urls, ErrorHandler){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);
        $scope.data = {}

        var mobileUploadPhoto = function(fileURI){

            var options = new FileUploadOptions();
            options.fileKey = "file";
            options.fileName = "picture";
            options.mimeType = "image/jpeg";
            options.params = {caption:($scope.data.caption)? $scope.data.caption : ""};
            options.chunkedMode = false;
            options.headers = {
                Authorization: 'JWT  ' + $localStorage.get('jwtoken'),
                Connection: "close"
            };

            var ft = new FileTransfer();
            ft.upload(fileURI,
                      encodeURI(API_urls.BASE() +"/trips/api/"+$stateParams.tripId+"/upload/"),
                      function(mdata){
                          var alertPopup = $ionicPopup.alert({
                            title: 'Photo Submission Succeeded',
                            template: 'Thank you'
                        });
                      },
                      function(err){
                          var alertPopup = $ionicPopup.alert({
                            title: 'Photo Submission Failed',
                            template: '' + JSON.stringify(err)
                        });
                      },
                      options, true);


        };
        $scope.uploadExisting = function(){
            navigator.camera.getPicture(mobileUploadPhoto,
                function(message) { alert('Failed to access your library'); },
                {quality: 50,
                    destinationType: navigator.camera.DestinationType.FILE_URI,
                    sourceType: navigator.camera.PictureSourceType.PHOTOLIBRARY }
            );
        }
        $scope.takePicture = function(){
            navigator.camera.getPicture(mobileUploadPhoto,
                function(message) { alert('Failed to access camera'); },
                {quality: 50,
                    destinationType: navigator.camera.DestinationType.FILE_URI,
                    sourceType: navigator.camera.PictureSourceType.CAMERA,
                    saveToPhotoAlbum: true}
            );
        }
        //this is for local testing only
        $scope.uploadFile = function(files) {
            var fd = new FormData();
            //Take the first selected file
            fd.append("file", files[0]);
            fd.append('trip', $stateParams.tripId);

            $http.post(API_urls.BASE() +"/trips/api/"+$stateParams.tripId+"/upload/", fd,
                {
                    headers: {'Content-Type': undefined },
                    transformRequest: angular.identity
                }).then(
                    function(data){
                        console.log(data)
                    },
                    function(err){
                        console.log(err)
                    }
                )

};


})
.controller('TripDetailCtrl',
    function($scope, $stateParams, TripsFactory, $localStorage, $ionicLoading, $ionicHistory, $state, $ionicPopup, ErrorHandler){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);
        uid = $localStorage.getObject('currentUser').user_id;

        $scope.checks = {
            supervisor : $scope.trip.supervisor == uid,
            owner: $scope.trip.traveller_id == uid,
            is_approved: $scope.trip.status == "approved",
            not_supervisor_approved: (!$scope.trip.approved_by_supervisor),
            is_planned: $scope.trip.status == "planned",
            is_canceled: $scope.trip.status == "cancelled",
            is_submitted: $scope.trip.status == "submitted",
            report_filled: Boolean($scope.trip.main_observations)
        }
        $scope.approve = function (tripId){
            $ionicLoading.show({
                                  template: 'Loading... <br> Approving Trip'
                                });
            TripsFactory.tripAction(tripId, 'approved', {}).then(
                function(actionSuccess){
                    $ionicLoading.hide();
                    TripsFactory.localTripUpdate(tripId, actionSuccess.data);
                    var alertPopup = $ionicPopup.alert({
                        title: 'Trip Approval',
                        template: 'You succesfully approved the trip'
                    });
                    $ionicHistory.goBack()//('app.dash.my_trips');
                    console.log("Action succeded")
                },
                function(err){
                    ErrorHandler.popError(err)
                }
            )
        };
        $scope.showConfirm = function(template, succ, fail) {
           var confirmPopup = $ionicPopup.confirm({
             title: 'Are you sure?',
             okText: "Yes",
             cancelText: "Not yet",
             template: template
           });
           confirmPopup.then(function(res) {
             if(res) {
               console.log(succ)
               succ()
               console.log('You are sure');
             } else {
               console.log(fail)
               console.log('You are not sure');
             }
           });
         };
        $scope.submit = function (tripId){
            $ionicLoading.show({
                      template: 'Loading... <br> Submitting Trip'
            });
            TripsFactory.tripAction(tripId, 'submitted', {}).then(
                function(actionSuccess){
                    $ionicLoading.hide();
                    TripsFactory.localSubmit(tripId);
                    var alertPopup = $ionicPopup.alert({
                        title: 'Trip Submission',
                        template: 'You succesfully submitted the trip'
                    });
                    $ionicHistory.goBack()//('app.dash.my_trips');
                    console.log("Action succeded")
                },
                function(err){
                    ErrorHandler.popError(err)
                }
            )
        };
        $scope.complete_trip = function(tripId){
            var execute_req = function() {
                $ionicLoading.show({
                    template: 'Loading... <br> Submitting Trip'
                });
                TripsFactory.tripAction(tripId, 'completed', {}).then(
                    function (actionSuccess) {
                        $ionicLoading.hide();
                        TripsFactory.localTripUpdate(tripId, actionSuccess.data);
                        var alertPopup = $ionicPopup.alert({
                            title: 'Trip Submission',
                            template: 'You completed the trip'
                        });
                        $state.go('app.dash.my_trips');
                        console.log("Action succeeded")
                    },
                    function (err) {
                        ErrorHandler.popError(err)
                    })
            };
            var now = new Date();
            var trip_end = new Date($scope.trip.to_date);
            now.setHours(0,0,0,0);
            if (now < trip_end){
                $scope.showConfirm("The trip has not ended yet!",execute_req);
                return
            }
            execute_req();
        };
        $scope.go_report = function(tripId){
            $state.go('app.reporting.text', {"tripId":tripId})
        };


})
.controller('MyTripsCtrl', function($scope, $localStorage, Data, $state, TripsFactory, $stateParams,
                                    $ionicLoading, $ionicPopup, $ionicListDelegate, $filter, ErrorHandler) {

        $scope.doRefresh = function() {
            Data.get_trips(function(res){
                $scope.filteredTrips = $filter('filter')(res,$scope.onlyMe)
                $scope.$broadcast('scroll.refreshComplete');
                console.log("got trips", res)
            }, function(err){
                $scope.$broadcast('scroll.refreshComplete');
                ErrorHandler.popError(err, false, true)
            }, true)

        };
        console.log("in mytrips")
        console.log($localStorage.getObject('trips'))

        $scope.onlyMe = function(trip) {
            return trip.traveller_id == $localStorage.getObject('currentUser').user_id;
        };
        $scope.go_report = function(tripId){
            $state.go('app.reporting.text', {"tripId":tripId})
        };
        $scope.submit = function (tripId){
            $ionicListDelegate.closeOptionButtons();
            $ionicLoading.show({
                                  template: 'Loading... <br> Submitting Trip'
                                });
            TripsFactory.tripAction(tripId, 'submitted', {}).then(
                function(actionSuccess){
                    $ionicLoading.hide();
                    TripsFactory.localSubmit(tripId);
                    var alertPopup = $ionicPopup.alert({
                        title: 'Trip Submission',
                        template: 'You succesfully submitted the trip'
                    });
                    console.log("Action succeded")
                },
                function(err){
                    ErrorHandler.popError(err)
                }
            )
        };

        var data_success = function(res){
                $scope.filteredTrips = $filter('filter')(res,$scope.onlyMe)
                console.log("got trips", res)
        };
        var data_failed = function(err){
                ErrorHandler.popError(err)
        };
        Data.get_trips(data_success,data_failed, $stateParams.refreshed)

})
.controller('SupervisedCtrl', function($scope, $localStorage,
                                       Data, TripsFactory, $ionicLoading,
                                       $state, $ionicListDelegate, $filter, ErrorHandler) {


        $scope.doRefresh = function() {
            Data.get_trips(function(res){
                $scope.filteredTrips = $filter('filter')(res,$scope.onlySupervised)
                $scope.$broadcast('scroll.refreshComplete');
                console.log("got trips", res)
            }, function(err){
                $scope.$broadcast('scroll.refreshComplete');
                ErrorHandler.popError(err)
            }, true)

        };

        console.log("in supervised");
        console.log($localStorage.getObject('trips'));
        $scope.onlySupervised = function(trip) {
            return trip.supervisor == $localStorage.getObject('currentUser').user_id;
        };
        Data.get_trips(
            function(res){
                $scope.filteredTrips = $filter('filter')(res,$scope.onlySupervised)

                console.log("got trips", res)
            },
            function(err){
                ErrorHandler.popError(err)
            }
        );
        $scope.approve = function (tripId){
            $ionicListDelegate.closeOptionButtons();
            $ionicLoading.show({
                                  template: 'Loading... <br> Approving Trip'
                                });
            TripsFactory.tripAction(tripId, 'approved', {}).then(
                function(actionSuccess){
                    $ionicLoading.hide();
                    TripsFactory.localTripUpdate(tripId, actionSuccess.data);
                    $state.go('app.dash.my_trips');
                    console.log("Action succeded")
                },
                function(err){
                    ErrorHandler.popError(err)
                }
            )
        }

})
.controller('TripApsEditCtrl',
    function($scope, $stateParams, TripsFactory, $localStorage, $ionicLoading, $ionicHistory, $ionicPopup, $state, Data, ErrorHandler) {
        $scope.today = new Date();
        $scope.padded_num = function(limit){
            var result = []
            for (var i=1; i<limit+1; i++){
                result.push(i>9 ? i+'' : "0"+i)
            }
            return result
        }
        var currentTrip = TripsFactory.getTrip($stateParams.tripId)

        $scope.allMonths = ["Jan","Feb","Mar","Apr",
                            "May","Jun","Jul","Aug",
                            "Sept","Oct","Nov","Dec"]
        $scope.yearOptions = [$scope.today.getFullYear()+"",
                              $scope.today.getFullYear()+1+""]

        Data.get_user_base(
            function(successData){
                $scope.users = successData
            },
            function(err){
                ErrorHandler.popError(err)
            }
        );

        console.log("id = "+$stateParams.apId)
        if ($stateParams.apId == 'new') {
            $scope.new_ap = true;
            console.log('yeah');

            var tomorrow = new Date($scope.today.getTime() + 24 * 60 * 60 * 1000);

            $scope.ap = {'status':'open',
                         'due_year': tomorrow.getFullYear()+"",
                         'due_month': ("0" + (tomorrow.getMonth()+1)).slice(-2),
                         'due_day': ("0" + tomorrow.getDate()).slice(-2)
                        }
            console.log("scope ap", $scope.ap);
        } else {

            $scope.new_ap = false;
            $scope.ap = TripsFactory.getAP(currentTrip, $stateParams.apId)
        }

        $scope.submit = function (){
            // do some validation here.

            if (typeof ($scope.ap.person_responsible) == "undefined"){
                // TODO: make sure you can't submit an action point due in the past
                // TODO: make sure you can't submit an action point without a description
                $scope.error = true;
                return;
            } else {
                $ionicLoading.show({
                    template: 'Loading... <br> Creating Action Point...'
                });
                TripsFactory.sendAP(currentTrip.id, $scope.ap,
                 function (success) {
                    $ionicLoading.hide();
                    $ionicHistory.goBack();
                    TripsFactory.localTripUpdate(currentTrip.id, success.data)
                    $ionicPopup.alert({
                        title: 'Action Point Updated',
                        template: 'Edited action point has been saved!'
                    })
                    console.log(success)
                }, function (err) {
                    ErrorHandler.popError(err)
                })
                console.log("submitting")
            }
        }


});