(function() {
    'use strict';

    angular
        .module('app.core')
        .service('apiUrlService', apiUrlService);

    function apiUrlService(localStorageService, apiHostDevelopment, defaultConnection) {
        var defaultConn = defaultConnection;
        var options = {
            0: apiHostDevelopment,                 //  development
            1: 'https://etools-dev.unicef.org',    //  staging
            2: 'https://etools-staging.unicef.org' //  production
        };

        var service = {
            BASE: getBase,
            ADFS: (getOptionName() === 0) ? false : true,
            getOptionName: getOptionName,
            setBase: setBase
        };

        return service;

        function getBase() {
            var baseUrl = localStorageService.get('base_url');

            if (baseUrl) {
                return options[baseUrl];
            }

            return options[defaultConn];
        }

        function setBase(base) {
            localStorageService.set('base_url', base);
        }

        function getOptionName() {
            var baseUrl = localStorageService.get('base_url');

            if (baseUrl) {
                return baseUrl;
            }

            return defaultConn;
        }
    }

})();
