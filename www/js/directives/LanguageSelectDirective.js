/*jshint multistr: true */
angular.module('equitrack.directives', [])
  .directive('ngTranslateLanguageSelect', function (LocaleService) { 
    'use strict';

    return {
      restrict: 'A',
      replace: true,
      template: '\
                  <div class="list language-select" ng-if="visible">\
                    <label class="item item-input item-select">\
                      <div class="input-label">\
                        <li class="ion-ios-world" data-pack="ios" data-tags="globe, earth" style="display: inline-block;"></li>\
                      </div>\
                      <select ng-model="currentLocaleDisplayName" ng-options="localesDisplayName for localesDisplayName in localesDisplayNames" ng-change="changeLanguage(currentLocaleDisplayName)">\
                      </select>\
                    </label>\
                  </div>',
      controller: function ($scope) {
        $scope.currentLocaleDisplayName = LocaleService.getLocaleDisplayName();
        $scope.localesDisplayNames = LocaleService.getLocalesDisplayNames();
        $scope.visible = $scope.localesDisplayNames &&
        $scope.localesDisplayNames.length > 1;

        $scope.changeLanguage = function (locale) {
          LocaleService.setLocaleByDisplayName(locale);
        };
      }
    };
  });