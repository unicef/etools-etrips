(function() {
    'use strict';

    angular
        .module('app.layout')
        .controller('Application', Application);

    Application.$inject = ['loginService', 'localStorageService', '$state'];

    function Application(loginService, localStorageService, $state) {        
        var vm = this;
        vm.currentUser = localStorageService.getObject('currentUser');
        vm.logout = logout;

        function logout() {
            $state.go('login');
            loginService.logout();
        }
    }

})();