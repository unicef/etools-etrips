(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('AddTrip', AddTrip);

    function AddTrip() {
        var vm = this;
        vm.title = '';
    }
})();