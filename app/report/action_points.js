(function() {
    'use strict';

    angular
        .module('app.report')
        .controller('ActionPoints', ActionPoints);

    ActionPoints.$inject = ['$stateParams', 'tripService'];

    function ActionPoints($stateParams, tripService) { 
        var vm = this;
        vm.trips = tripService.getTrip($stateParams.tripId);
        vm.trip_id = $stateParams.tripId;
    }

})();