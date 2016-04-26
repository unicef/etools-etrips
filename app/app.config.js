(function() {
    'use strict';

    angular
        .module('app.core')
        .config(config);

    function config($translateProvider, LOCALES, tmhDynamicLocaleProvider, $httpProvider) {
        httpProviderPush();
        translation();

        function httpProviderPush() {
            $httpProvider.interceptors.push('httpInterceptorService');
        }

        function translation() {
            $translateProvider.useMissingTranslationHandlerLog();
            $translateProvider.useStaticFilesLoader({
                prefix: 'i18n/',
                suffix: '.json'
            });

            $translateProvider.preferredLanguage(LOCALES.preferredLocale);
            $translateProvider.useLocalStorage();
            tmhDynamicLocaleProvider.localeLocationPattern('locales/angular-locale_{{locale}}.js');
        }
    }
})();