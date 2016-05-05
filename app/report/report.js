(function() {
    'use strict';

    angular
        .module('app.report')
        .controller('Report', Report);

    Report.$inject = ['$stateParams'];

    function Report($stateParams) {
        var vm = this;
        vm.tripId = $stateParams.tripId;
    }

})();
