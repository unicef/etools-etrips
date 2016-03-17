angular.module('equitrack.controllers', [])

.controller('AppCtrl', function($scope, $state, loginService, localStorageService) {

  // With the new view caching in Ionic, Controllers are only called
  // when they are recreated or on app start, instead of every page change.
  // To listen for when this page is active (for example, to refresh data),
  // listen for the $ionicView.enter event:
  //$scope.$on('$ionicView.enter', function(e) {
  //});
  $scope.logout = function(){
      console.log('logout goes here');
      $state.go("login");
      loginService.logout();

  };
  $scope.currentUser = localStorageService.getObject('currentUser');

  // Form data for the login modal


})

.controller('DashCtrl', function($scope) {

})
.controller('SettingsCtrl', function($scope) {

})
.controller('SettingsConnectionCtrl', function($scope, apiUrlService, loginService, $state, $ionicHistory) {
    $scope.dt = {};
    $scope.dt.conn_str = apiUrlService.get_option_name();

    $scope.changeConnection = function(conn_str){

        apiUrlService.set_base(conn_str);
        console.log('logging out now');
        loginService.logout();
        $ionicHistory.clearCache().then(function(){ $state.go('login');});

    };
})

.controller('LoginCtrl', ['$scope', '$ionicLoading','$ionicHistory',  'localStorageService',
            'dataService', 'loginService', 'authentication', '$ionicPopup', '$state', 'apiUrlService', 'networkService', '$translate',
             function($scope, $ionicLoading, $ionicHistory, localStorageService, dataService, loginService,
                      authentication, $ionicPopup, $state, apiUrlService, networkService, $translate) {

    $scope.data = localStorageService.getObject('user_cred');
    $scope.other = {};
    function login_success(token){
        console.log("LoginCtrl: login_success");
        dataService.get_profile(function(success){
            dataService.get_trips(
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
                    console.log("failed to get trips");
                    var alertPopup = $ionicPopup.alert({
                      title: $translate.instant('controller.login.success.title'),
                      template: $translate.instant('controller.login.success.template')
                    });
                }, true
            );
        },
            function(profile_fail){
                //this means that our user does not have a country yet or something went wrong on
                // THE DJANGO side.
                $ionicLoading.hide();
                console.log(profile_fail);
                var alertPopup = '';
                if (profile_fail.data.detail == 'No country found for user'){
                    alertPopup = $ionicPopup.alert({
                      title: $translate.instant('controller.login.no_country.title'),
                      template: $translate.instant('controller.login.no_country.template')
                    });
                } else {
                    alertPopup = $ionicPopup.alert({
                      title: $translate.instant('controller.login.country.title'),
                      template: $translate.instant('controller.login.country.template')
                    });
                }
                return;

        });


    }

    function login_fail(data){
      console.log("LoginCtrl: login_fail");
      console.log(JSON.stringify(data));
      console.log(data.data);
      console.log(data.error);
      console.log(data.body);

      $ionicLoading.hide();
      var alertPopup = $ionicPopup.alert({
        title: $translate.instant('controller.login.fail.title'),
        template: $translate.instant('controller.login.fail.template')
      });
    }

    $scope.login = function(){
        var loginData = $scope.data;

        if ($scope.other.rememberMe){
          // won't save the password
          localStorageService.setObject("user_cred",{username:loginData.username, password:""});
        } else {
          localStorageService.delete("user_cred");
        }

        if (networkService.isOffline()) {
          networkService.showMessage(
            $translate.instant('controller.login.network_offline.title'),
            $translate.instant('controller.login.network_offline.template')
          );
          $scope.data = {};

        } else {
          $ionicLoading.show( { template: '<loading></loading>' } );
          localStorageService.setObject("relogin_cred", { username:loginData.username, password:""} ); //store the username in the background for re-login
          loginService.loginUser(loginData, login_success, login_fail);
          $scope.data = {};
        }
    };

}]);
