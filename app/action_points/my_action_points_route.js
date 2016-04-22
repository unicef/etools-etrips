(function() {
    'use strict';

    angular
        .module('app.action_points')
        .config(config);

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('app.dash.my_action_points', {
                url: '/my_action_points',
                cache: false,
                views: {
                    'tab-action-points': {
                        templateUrl: 'app/action_points/my_action_points.html',
                        controller: 'MyActionPoints',
                        controllerAs: 'vm'
                    }
                }
            });
    }
})();