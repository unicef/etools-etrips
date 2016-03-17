(function() {
    'use strict';

    angular
        .module('app.core')
        .service('httpInterceptorService', httpInterceptorService);

    function httpInterceptorService($q, $location, localStorageService) {
        var service = {
            request: request,
            responseError: responseError
        };
        
        return service;

        function request(config) {
            config.headers = config.headers || {};
            
            if (localStorageService.get('jwtoken')) {
                config.headers.Authorization = 'JWT  ' + localStorageService.get('jwtoken');
            }

            return config;
        }

        function responseError(response) {
            if (response.status === 401 || response.status === 403) {
                $location.path('/login');
            }

            return $q.reject(response);
        }
    }
    
})();