(function() {
    'use strict';

    angular
        .module('app.core')
        .filter('underscoreless', underscoreLess)
        .filter('TitleCase', titleCase);
  
    function underscoreLess() {
        return function (input) {
            return input.replace(/_/g, ' ');
        };
    }

    function titleCase() {
        return function(input){
            return input.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
        };
    }

})();