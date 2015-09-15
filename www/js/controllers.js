angular.module('equitrack.controllers', [])

.controller('AppCtrl', function($scope, $ionicModal, $timeout) {

  // With the new view caching in Ionic, Controllers are only called
  // when they are recreated or on app start, instead of every page change.
  // To listen for when this page is active (for example, to refresh data),
  // listen for the $ionicView.enter event:
  //$scope.$on('$ionicView.enter', function(e) {
  //});

  // Form data for the login modal
  $scope.data = {};

})

.controller('PlaylistsCtrl', function($scope) {
  $scope.playlists = [
    { title: 'Reggae', id: 1 },
    { title: 'Chill', id: 2 },
    { title: 'Dubstep', id: 3 },
    { title: 'Indie', id: 4 },
    { title: 'Rap', id: 5 },
    { title: 'Cowbell', id: 6 }
  ];
})

.controller('PlaylistCtrl', ['$scope','$stateParams', function($scope, $stateParams) {

}])
.controller('TripsCtrl', ['$scope', '$localStorage', 'Data', '$ionicPopup', function($scope, $localStorage, Data, $ionicPopup){
        $scope.data = {"user": $localStorage.currentUser}
        $scope.profile = {}

        $scope.get_profile = function(){
            Data.get_profile(function(res){
                    console.log("success", res)
                    $scope.data.profile = res
                },
                function(res){
                    console.log("fail", res)
            })
        }
        $scope.get_trips = function(){
            Data.get_trips(
                function(res){
                    $scope.data.trips = res
                },
                function(res){
                    $ionicPopup.alert({
                        title: 'Something went wrong',
                        template: 'Please try again later!'
                    })
                }
            )
        }
}])
.controller('DashCtrl', function($scope) {

    })
.controller('TripDetailCtrl', function($scope, $stateParams, TripsFactory){

        $scope.trip = TripsFactory.getTrip($stateParams.tripId)
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
.controller('MyTripsCtrl', function($scope, $localStorage, Data) {

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
.controller('SupervisedCtrl', function($scope, $localStorage, Data, TripsFactory, $ionicLoading, $state, $ionicListDelegate) {


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

        console.log("in supervised")
        console.log($localStorage.trips)
        $scope.onlySupervised = function(trip) {
            return trip.supervisor == $localStorage.currentUser.user_id;
        };
        Data.get_trips(
            function(res){
                $scope.trips = res
                console.log("got trips", res)
            },
            function(res){
                $ionicPopup.alert({
                    title: 'Something went wrong',
                    template: 'Please try again later!'
                })
            }
        )
        $scope.approve = function (tripId){
            $ionicListDelegate.closeOptionButtons()
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

})

.controller('LoginCtrl', ['$scope', '$ionicLoading', '$localStorage',
            'Data', 'LoginService', 'Auth', '$ionicPopup', '$state', 'API_urls',
             function($scope, $ionicLoading, $localStorage, Data, LoginService,
                      Auth, $ionicPopup, $state, API_urls) {

    $scope.data = {};
    function login_success(token){
        console.log("LoginCtrl: login_success");
        Data.get_trips(
            function(res){
                $ionicLoading.hide();
                console.log("got trips", res)
                $state.go('app.dash.my_trips');
            },
            function(res){
                $ionicLoading.hide();
                console.log("failed to get trips")
            }, true
        )

    };

    function login_fail(data){
        console.log("LoginCtrl: login_fail", data.data)
        var alertPopup = $ionicPopup.alert({
            title: 'Login failed!',
            template: 'Please check your credentials!'
        });
    };

    $scope.login = function(){
        $ionicLoading.show({
                      template: 'Loading...'
        });
        LoginService.loginUser($scope.data, login_success, login_fail)
    };

}]);
