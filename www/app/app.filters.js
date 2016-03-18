(function() {
    'use strict';

    angular
        .module('app.core')
        .filter('underscoreless', underscoreLess)
        .filter('TitleCase', titleCase);
  
    function underscoreLess() {
        return function (input) {
            var val = '';

            if (input !== undefined) {
                val = input.replace(/_/g, ' ');
            }

            return val;
        };
    }

    function titleCase() {
        return function(input){
            var val = '';

            if (input !== undefined) {
                val = input.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
            }

            return val
        };
    }

})();