(function() {
    'use strict';

    angular
        .module('app.components')
        .directive('ngTranslateLanguageSelect', ngTranslateLanguageSelect);

    function ngTranslateLanguageSelect() {
        return {
            restrict: 'EA',
            replace: true,
            templateUrl: 'app/components/language_selector.directive.html',
            controller: languageSelector,
            controllerAs: 'lang_selector'
        };
    }

    function languageSelector(localeService) {
        /*jshint validthis: true */
        var langSelector = this;

        langSelector.changeLanguage = changeLanguage;
        langSelector.currentLocaleDisplayName = localeService.getLocaleDisplayName();
        langSelector.localesDisplayNames = localeService.getLocalesDisplayNames();
        langSelector.visible = langSelector.localesDisplayNames && langSelector.localesDisplayNames.length > 1;

        function changeLanguage(locale) {
            localeService.setLocaleByDisplayName(locale);
        }
    }

})();
