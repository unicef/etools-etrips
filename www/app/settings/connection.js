(function() {
    'use strict';

    angular
        .module('app.settings')
        .controller('Connection', Connection);

    function Connection(apiUrlService, loginService, $state, $ionicHistory) {
        var vm = this;
        vm.data = {};
        vm.data.connection_string = apiUrlService.get_option_name();
        vm.changeConnection = changeConnection;

        function changeConnection(connection_string){
            apiUrlService.set_base(connection_string);            
            loginService.logout();
            $ionicHistory.clearCache().then(function(){ 
                $state.go('login');
            });
        }
    }

})();