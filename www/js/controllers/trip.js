/**
 * Created by Robi on 9/15/15.
 */


angular.module('equitrack.tripControllers', [])

.controller('TripCtrl', function($scope, $ionicModal, $timeout) {
    $scope.data = {};
})

.controller('ReportingCtrl',function($scope, $stateParams, TripsFactory){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);
        $scope.submit = function (){
            TripsFactory.tripAction($stateParams.tripId, 'report', {}).then(
                function(actionSuccess){
                    console.log("Action succeded")
                },
                function(actionFailed){
                    console.error("Action failed")
                }
            )
        }
})
.controller('ReportingTextCtrl',function($scope, $stateParams, TripsFactory,$ionicLoading, $ionicHistory, $ionicPopup){

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
                },
                function (err){
                    console.log("got an error")
                    $ionicLoading.hide();
                    $ionicHistory.goBack();
                    $ionicPopup.alert({
                        title: 'Something went wrong',
                        template: 'Please try again later'
                    })
                    console.log(err)
            })
        }

})
.controller('ReportingAPSCtrl',function($scope, $stateParams, TripsFactory){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);
        $scope.newAP = function(){
            $state.go('')
        }

})
.controller('ReportingPictureCtrl',function($scope,$ionicPopup, $localStorage, $stateParams, TripsFactory, $http, API_urls){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);


        var mobileUploadPhoto = function(fileURI){

            var options = new FileUploadOptions();
            options.fileKey = "file";
            options.fileName = fileURI.substr(fileURI.lastIndexOf('/') + 1);
            options.mimeType = "image/jpeg";

            if (ionic.Platform.isAndroid()){
                var params = new Object();
                params.headers = {Authorization: 'JWT  ' + $localStorage.jwtoken};
                options.params = params;
            } else {
                options.params = {};
                options.headers = {Authorization: 'JWT  ' + $localStorage.jwtoken};
            }

            var ft = new FileTransfer();
            ft.upload(fileURI,
                      encodeURI(API_urls.BASE +"/trips/api/"+$stateParams.tripId+"/upload/"),
                      function(mdata){
                          var alertPopup = $ionicPopup.alert({
                            title: 'Photo Submission Succeeded',
                            template: 'Thank you'
                        });
                      },
                      function(err){
                          var alertPopup = $ionicPopup.alert({
                            title: 'Photo Submission Failed',
                            template: 'Please try again later. ' + err.detail
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
                    sourceType: navigator.camera.PictureSourceType.CAMERA }
            );
        }
        //this is for local testing only
        $scope.uploadFile = function(files) {
            var fd = new FormData();
            //Take the first selected file
            fd.append("file", files[0]);
            fd.append('trip', $stateParams.tripId);

            $http.post(API_urls.BASE +"/trips/api/"+$stateParams.tripId+"/upload/", fd,
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
    function($scope, $stateParams, TripsFactory, $localStorage, $ionicLoading, $ionicHistory, $ionicPopup, $state){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);
        uid = $localStorage.currentUser.user_id;
        $scope.checks = {
            supervisor : $scope.trip.supervisor == uid,
            owner: $scope.trip.traveller_id == uid,
            is_approved: $scope.trip.status == "approved",
            is_planned: $scope.trip.status == "planned",
            is_canceled: $scope.trip.status == "cancelled",
            is_submitted: $scope.trip.status == "submitted",
        }
        $scope.approve = function (tripId){
            $ionicLoading.show({
                                  template: 'Loading... <br> Approving Trip'
                                });
            TripsFactory.tripAction(tripId, 'approved', {}).then(
                function(actionSuccess){
                    $ionicLoading.hide();
                    TripsFactory.localApprove(tripId);
                    var alertPopup = $ionicPopup.alert({
                        title: 'Trip Approval',
                        template: 'You succesfully approved the trip'
                    });
                    $ionicHistory.goBack()//('app.dash.my_trips');
                    console.log("Action succeded")
                },
                function(actionFailed){
                    $ionicLoading.hide();
                    console.error("Action failed")
                }
            )
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
                function(actionFailed){
                    $ionicLoading.hide();
                    console.error("Action failed")
                }
            )
        };
        $scope.go_report = function(tripId){
            $state.go('app.reporting.text', {"tripId":tripId})
        };


})
.controller('MyTripsCtrl', function($scope, $localStorage, Data, $state, TripsFactory, $stateParams,
                                    $ionicLoading, $ionicPopup, $ionicListDelegate, $filter) {

        $scope.doRefresh = function() {
            Data.get_trips(function(res){
                $scope.filteredTrips = $filter('filter')(res,$scope.onlyMe)
                $scope.$broadcast('scroll.refreshComplete');
                console.log("got trips", res)
            }, function(res){
                $scope.$broadcast('scroll.refreshComplete');
                $ionicPopup.alert({
                    title: 'Something went wrong',
                    template: 'Please try again later!'
                })
            }, true)

        };
        console.log("in mytrips")
        console.log($localStorage.trips)

        $scope.onlyMe = function(trip) {
            return trip.traveller_id == $localStorage.currentUser.user_id;
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
                function(actionFailed){
                    $ionicLoading.hide();
                    console.error("Action failed")
                }
            )
        };

        var data_success = function(res){
                $scope.filteredTrips = $filter('filter')(res,$scope.onlyMe)
                console.log("got trips", res)
        }
        var data_failed = function(res){
                $ionicPopup.alert({
                    title: 'Something went wrong',
                    template: 'Please try again later!'
                })
        }
        Data.get_trips(data_success,data_failed, $stateParams.refreshed)

})
.controller('SupervisedCtrl', function($scope, $localStorage,
                                       Data, TripsFactory, $ionicLoading,
                                       $state, $ionicListDelegate, $filter) {


        $scope.doRefresh = function() {
            Data.get_trips(function(res){
                $scope.filteredTrips = $filter('filter')(res,$scope.onlySupervised)
                $scope.$broadcast('scroll.refreshComplete');
                console.log("got trips", res)
            }, function(res){
                $scope.$broadcast('scroll.refreshComplete');
                $ionicPopup.alert({
                    title: 'Something went wrong',
                    template: 'Please try again later!'
                })
            }, true)

        };

        console.log("in supervised");
        console.log($localStorage.trips);
        $scope.onlySupervised = function(trip) {
            return trip.supervisor == $localStorage.currentUser.user_id;
        };
        Data.get_trips(
            function(res){
                $scope.filteredTrips = $filter('filter')(res,$scope.onlySupervised)

                console.log("got trips", res)
            },
            function(res){
                $ionicPopup.alert({
                    title: 'Something went wrong',
                    template: 'Please try again later!'
                })
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
                    TripsFactory.localApprove(tripId);
                    $state.go('app.dash.my_trips');
                    console.log("Action succeded")
                },
                function(actionFailed){
                    $ionicLoading.hide();
                    console.error("Action failed")
                }
            )
        }

})
.controller('TripApsEditCtrl',
    function($scope, $stateParams, TripsFactory, $localStorage, $ionicLoading, $ionicHistory, $ionicPopup, $state, Data) {
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

        Data.get_user_base(function(successData){
                $scope.users = successData
            }, function(error){console.log(error)})

        console.log("id = "+$stateParams.apId)
        if ($stateParams.apId == 'new') {
            $scope.new_ap = true;
            var tomorrow = new Date(Date.now() + 24 * 60 * 60 * 1000);
            $scope.ap = {'status':'open',
                         'due_year': tomorrow.getFullYear()+"",
                         'due_month': ("0" + tomorrow.getMonth()).slice(-2),
                         'due_day': ("0" + tomorrow.getDay()).slice(-2)
                        }
        } else {

            $scope.new_ap = false;
            $scope.ap = TripsFactory.getAP(currentTrip, $stateParams.apId)
        }

        $scope.submit = function (){
            // do some validation here.
            if (typeof ($scope.ap.person_responsible) == "undefined"){
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
                    $ionicLoading.hide();
                    $ionicHistory.goBack()
                    $ionicPopup.alert({
                        title: 'Something Went Wrong',
                        template: err.data
                    })
                    console.log(err)
                })
                console.log("submitting")
            }
        }


});