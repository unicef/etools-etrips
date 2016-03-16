(function() {
    'use strict';

    angular
        .module('app.widgets')
        .directive('ngTranslateLanguageSelect', ngTranslateLanguageSelect);

    function ngTranslateLanguageSelect() {
        return {
            restrict: 'EA',
            replace: true,
            templateUrl: 'js/components/language_selector.directive.html',
            controller: languageSelector,
            controllerAs: 'vm'
        };
    }

    function languageSelector(localeService) {
        /*jshint validthis: true */
        var vm = this;

        vm.changeLanguage = changeLanguage;
        vm.currentLocaleDisplayName = localeService.getLocaleDisplayName();
        vm.localesDisplayNames = localeService.getLocalesDisplayNames();
        vm.visible = vm.localesDisplayNames && vm.localesDisplayNames.length > 1;
        
        function changeLanguage(locale) {
            localeService.setLocaleByDisplayName(locale);
        }
    }

})();
