(function() {
    'use strict';

    angular
        .module('app.notes')
        .config(config);

    function config($stateProvider) {
        $stateProvider
            .state('app.dash.notes', {
                url: '/my_trips/:tripId/notes',
                cache: false,
                views: {
                    'tab-trips': {
                        templateUrl: 'app/notes/notes.html',
                        controller: 'Notes',
                        controllerAs: 'vm'
                    }
                }
            }
        );
    }

})();
