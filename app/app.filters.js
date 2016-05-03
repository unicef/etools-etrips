(function() {
    'use strict';

    angular
        .module('app.core')
        .filter('underscoreless', underscoreLess)
        .filter('TitleCase', titleCase)
        .filter('bytes', bytes);

    function underscoreLess() {
        return function(input) {
            var val = '';

            if (input !== undefined) {
                val = input.replace(/_/g, ' ');
            }

            return val;
        };
    }

    function titleCase() {
        return function(input) {
            var val = '';

            if (input !== undefined) {
                val = input.replace(/\w\S*/g, function(txt) {
                    return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
                });
            }

            return val;
        };
    }

    function bytes() {
        return function(bytes, precision) {
            if (bytes === 0) {
                return '0 bytes';
            }

            if (isNaN(parseFloat(bytes)) || !isFinite(bytes)) {
                return '-';
            }

            if (typeof precision === 'undefined') {
                precision = 1;
            }

            var units = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB'];
            var number = Math.floor(Math.log(bytes) / Math.log(1024));
            var val = (bytes / Math.pow(1024, Math.floor(number))).toFixed(precision);

            return (val.match(/\.0*$/) ? val.substr(0, val.indexOf('.')) : val) + ' ' + units[number];
        };
    }

})();
