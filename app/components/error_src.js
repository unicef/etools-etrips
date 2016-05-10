(function() {
    'use strict';

    angular
        .module('app.components')
        .directive('errSrc', errorSrc);

    function errorSrc() {
        return {
            link: function(scope, element, attrs) {
                element.bind('error', function() {
                    if (attrs.src !== attrs.errSrc) {
                        attrs.$set('src', attrs.errSrc);
                    }
                });
            }
        };
    }
})();
