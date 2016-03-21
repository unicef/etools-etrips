(function() {
    'use strict';

    angular
        .module('app.widgets')
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
        var lang_selector = this;

        lang_selector.changeLanguage = changeLanguage;
        lang_selector.currentLocaleDisplayName = localeService.getLocaleDisplayName();
        lang_selector.localesDisplayNames = localeService.getLocalesDisplayNames();
        lang_selector.visible = lang_selector.localesDisplayNames && lang_selector.localesDisplayNames.length > 1;
        
        function changeLanguage(locale) {
            localeService.setLocaleByDisplayName(locale);
        }
    }

})();
