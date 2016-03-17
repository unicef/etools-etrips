(function() {
    'use strict';

    angular
        .module('app.widgets')
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
            controllerAs: 'vm' 
        };
    }

    function loadingController($scope, $translate) {
        /*jshint validthis: true */
        var vm = this;
        
        if (!angular.isDefined($scope.message)) {
            vm.text = $translate.instant('directive.loading.title_default');
        } else {
            vm.text = $translate.instant('directive.loading.' + $scope.message);
        }
    }
    
})();