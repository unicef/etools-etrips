(function() {
    'use strict';

    angular
        .module('app.components')
        .directive('loading', loading);

    function loading() {
        return {
            restrict: 'EA',
            replace: true,
            scope: {
                message: '@',
                text: '='
            },
            templateUrl: 'app/components/loading_modal.directive.html',
            controller: loadingController,
            controllerAs: 'loading'
        };
    }

    function loadingController($scope, $translate) {
        /*jshint validthis: true */
        var loading = this;

        if (!angular.isDefined($scope.message)) {
            loading.text = $translate.instant('directive.loading.title_default');
        } else {
            loading.text = $translate.instant('directive.loading.' + $scope.message);
        }
    }
})();
