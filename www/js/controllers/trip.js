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
.controller('ReportingPictureCtrl',function($scope, $stateParams, TripsFactory){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);

})
.controller('TripDetailCtrl', function($scope, $stateParams, TripsFactory){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId);
        $scope.approve = function (){
            TripsFactory.tripAction($stateParams.tripId, 'approved', {}).then(
                function(actionSuccess){
                    console.log("Action succeded")
                },
                function(actionFailed){
                    console.error("Action failed")
                }
            )
        }

})
.controller('MyTripsCtrl', function($scope, $localStorage, Data, $state) {

        $scope.doRefresh = function() {
            Data.get_trips(function(res){
                $scope.trips = res
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
        }

        var data_success = function(res){
                $scope.trips = res
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
                                       $state, $ionicListDelegate) {


        $scope.doRefresh = function() {
            Data.get_trips(function(res){
                $scope.trips = res
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
                $scope.trips = res;
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