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
});