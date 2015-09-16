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
.controller('ReportingTextCtrl',function($scope, $stateParams, TripsFactory){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);

})
.controller('ReportingAPSCtrl',function($scope, $stateParams, TripsFactory){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);

})
.controller('ReportingPictureCtrl',function($scope, $stateParams, TripsFactory){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);

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
            $state.go('app.trip.reporting.text', {"tripId":tripId})
        };


})
.controller('MyTripsCtrl', function($scope, $localStorage, Data, $state, TripsFactory,
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
            $state.go('app.trip.reporting.text', {"tripId":tripId})
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
        Data.get_trips(data_success,data_failed)

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

});