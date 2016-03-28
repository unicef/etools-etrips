(function() {
    'use strict';

    angular
        .module('app.settings')
        .controller('Connection', Connection);

    function Connection(apiUrlService, loginService, $state, $ionicHistory) {
        var vm = this;
        vm.data = {};
        vm.data.connection_string = apiUrlService.getOptionName();
        vm.changeConnection = changeConnection;

        function changeConnection(connectionString){
            apiUrlService.setBase(connectionString);            
            loginService.logout();
            $ionicHistory.clearCache().then(function(){ 
                $state.go('login');
            });
        }
    }

})();