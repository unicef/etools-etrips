(function() {
    'use strict';

    angular
        .module('app.core')
        .service('errorHandler', errorHandler);

    function errorHandler($ionicLoading, $ionicHistory, $ionicPopup, $state, $translate){
        var default_message = $translate.instant('factory.error_handler.default_message');
        var service = {
            parse: parse,
            popError: popError
        };

        return service;

        function parse(error){
            console.log('error response:', error);
            if (!error){
                return default_message;
            }
            if (typeof(error)=="string"){
                return error;
            } else if ((typeof(error)=="object") && (error.data)){
                if (error.data.detail){
                    return error.data.detail;
                } else if (error.data.non_field_errors){
                    return error.data.non_field_errors.join('<br>');
                } else if (typeof (error.data == "string") && (error.data.indexOf('security token could not be') != -1)){
                    // this means ADFS returned an XML saying invalid credentials
                    return $translate.instant('factory.error_handler.password');
                }
            }
            return default_message;
        }

        function popError(err, path, stay_on_page){
            console.log("got an error");
            $ionicLoading.hide();
            if (path){
                $state.go(path);
            } else if (!stay_on_page) {
                $ionicHistory.goBack();
            }

            $ionicPopup.alert({
                title: $translate.instant('factory.error_handler.unknow'),
                template: parse(err)
            });
        }
    }

})();