(function() {
    'use strict';

    angular
        .module('app.core')
        .service('errorHandler', errorHandler);

    function errorHandler($ionicLoading, $ionicHistory, $ionicPopup, $state, $translate) {
        var defaultMessage = $translate.instant('factory.error_handler.default_message');
        var service = {
            parse: parse,
            popError: popError
        };

        return service;

        function parse(error) {
            defaultMessage = $translate.instant('factory.error_handler.default_message');

            if (!error) {
                return defaultMessage;
            }
            if (typeof(error) === 'string') {
                return error;
            } else if ((typeof(error) === 'object') && (error.data)) {
                // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
                if (error.data.detail) {
                    return error.data.detail;
                } else if (error.data.non_field_errors) {
                    return error.data.non_field_errors.join('<br>');
                } else if (typeof(error.data === 'string') && (error.data.indexOf('security token could not be') !== -1)) {
                    // this means ADFS returned an XML saying invalid credentials
                    return $translate.instant('factory.error_handler.password');
                }
            }
            return defaultMessage;
        }

        function popError(err, path, stay_on_page) {
            $ionicLoading.hide();

            if (path) {
                $state.go(path);
            } else if (!stay_on_page) {
                $ionicHistory.goBack();
            }

            $ionicPopup.alert({
                title: $translate.instant('factory.error_handler.unknown'),
                template: parse(err)
            });
        }
    }

})();
