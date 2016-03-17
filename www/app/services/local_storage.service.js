(function() {
    'use strict';

    angular
        .module('app.core')
        .service('localStorageService', localStorageService);

    function localStorageService($window) {
        var service = {
            get: get,
            set: set,
            getObject: getObject,
            setObject: setObject,
            delete: deleteObject
        };

        return service;

        function get(key, defaultValue) {
            return $window.localStorage[key] || defaultValue;
        }

        function set(key, value) {
            $window.localStorage[key] = value;
        }

        function getObject(key) {
            return JSON.parse($window.localStorage[key] || '{}');
        }

        function setObject(key, value) {
            $window.localStorage[key] = JSON.stringify(value);
        }

        function deleteObject(key){
            delete $window.localStorage[key];
        }
    }

})();