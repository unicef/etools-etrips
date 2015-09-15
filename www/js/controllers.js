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
//.controller('TripsCtrl', ['$scope', '$localStorage', 'Data', '$ionicPopup',
//        function($scope, $localStorage, Data, $ionicPopup){
//        $scope.data = {"user": $localStorage.currentUser}
//        $scope.profile = {}
//
//        $scope.get_profile = function(){
//            Data.get_profile(function(res){
//                    console.log("success", res)
//                    $scope.data.profile = res
//                },
//                function(res){
//                    console.log("fail", res)
//            })
//        }
//        $scope.get_trips = function(){
//            Data.get_trips(
//                function(res){
//                    $scope.data.trips = res
//                },
//                function(res){
//                    $ionicPopup.alert({
//                        title: 'Something went wrong',
//                        template: 'Please try again later!'
//                    })
//                }
//            )
//        }
//}])
.controller('DashCtrl', function($scope) {

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
