angular.module('equitrack.controllers', [])

.controller('AppCtrl', function($scope, $state, LoginService, $localStorage) {

  // With the new view caching in Ionic, Controllers are only called
  // when they are recreated or on app start, instead of every page change.
  // To listen for when this page is active (for example, to refresh data),
  // listen for the $ionicView.enter event:
  //$scope.$on('$ionicView.enter', function(e) {
  //});
  $scope.logout = function(){
      console.log('logout goes here')
      $state.go("login")
      LoginService.logout()

  };
  $scope.currentUser = $localStorage.getObject('currentUser');

  // Form data for the login modal


})

.controller('DashCtrl', function($scope) {

})


.controller('LoginCtrl', ['$scope', '$ionicLoading','$ionicHistory',  '$localStorage',
            'Data', 'LoginService', 'Auth', '$ionicPopup', '$state', 'API_urls',
             function($scope, $ionicLoading, $ionicHistory, $localStorage, Data, LoginService,
                      Auth, $ionicPopup, $state, API_urls) {

    $scope.data = {};
    function login_success(token){
        console.log("LoginCtrl: login_success");
        Data.get_profile(function(success){
            Data.get_trips(
                function(res){
                    $ionicLoading.hide();
                    $ionicHistory.nextViewOptions({
                        disableBack: true
                    });
                    console.log("got trips", res);
                    $state.go('app.dash.my_trips');
                },
                function(res){
                    $ionicLoading.hide();
                    console.log("failed to get trips")
                    var alertPopup = $ionicPopup.alert({
                        title: 'Login failed!',
                        template: 'Failed to get trips, please try logging in again.'
                    });
                }, true
            )
        },
            function(profile_fail){
                //this means that our user does not have a country yet or something went wrong on
                // THE DJANGO side.
                $ionicLoading.hide();
                console.log(profile_fail)
                if (profile_fail.data.detail == 'No country found for user'){
                    var alertPopup = $ionicPopup.alert({
                        title: 'Login failed!',
                        template: 'Please setup your profile on eTools <br> Please set your Country'
                    });
                } else {
                    var alertPopup = $ionicPopup.alert({
                        title: 'Login failed!',
                        template: 'Something went wrong retrieving your user, please try again later'
                    });
                }
                return

        })


    };

    function login_fail(data){
        console.log("LoginCtrl: login_fail")
        console.log(JSON.stringify(data))
        console.log(data.data)
        console.log(data.error)
        console.log(data.body)

        $ionicLoading.hide();
        var alertPopup = $ionicPopup.alert({
            title: 'Login failed!',
            template: 'Please check your credentials!'
        });
    };

    $scope.login = function(){
        var loginData = $scope.data
        $ionicLoading.show({
                      template: 'Loading...'
        });
        LoginService.loginUser(loginData, login_success, login_fail)
        $scope.data = {}
    };

}]);
