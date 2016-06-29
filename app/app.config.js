(function() {
    'use strict';

    angular
        .module('app.core')
        .config(config);

    function config($compileProvider, $httpProvider, $translateProvider, DEBUG_INFO_ENABLED, LOCALES, tmhDynamicLocaleProvider) {
        debugInfoEnabled(DEBUG_INFO_ENABLED);
        httpProviderPush();
        translation();

        function debugInfoEnabled(DEBUG_INFO_ENABLED) {
            $compileProvider.debugInfoEnabled(DEBUG_INFO_ENABLED);
        }

        function httpProviderPush() {
            $httpProvider.interceptors.push('httpInterceptorService');
        }

        function translation() {
            $translateProvider.useMissingTranslationHandlerLog();
            $translateProvider.useSanitizeValueStrategy('sanitizeParameters');
            $translateProvider.useStaticFilesLoader({
                prefix: 'i18n/',
                suffix: '.json'
            });
            $translateProvider.preferredLanguage(LOCALES.preferredLocale);
            $translateProvider.forceAsyncReload(true);
            $translateProvider.useLocalStorage();
            tmhDynamicLocaleProvider.localeLocationPattern('locales/angular-locale_{{locale}}.js');
        }
    }
})();
