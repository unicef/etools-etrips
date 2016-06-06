(function (){
    'use strict';

    angular
        .module('app.components')
        .directive('requiredLabel', requiredLabel);

    requiredLabel.$inject = ['$translate'];

    function requiredLabel($translate) {
        return {
            restrict: 'E',

            template: function() {
                return '{{ legend }} <span class="{{ class }}">{{ character }}</span>';
            },

            link: function(scope, element, attrs) {
                var displayClass = 'assertive';
                var character = '*';
                var showLegend = attrs.showLegend === 'true' ? true : false;

                scope.class = attrs.class ? attrs.class : displayClass;
                scope.character = attrs.character ? attrs.character : character;
                scope.legend = '';

                if (showLegend === true) {
                    scope.legend = $translate.instant('template.required.legend');
                }
            }
        };
    }
}());

