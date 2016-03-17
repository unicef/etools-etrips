angular.module('equitrack.controllers', [])

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