/*jshint multistr: true */
angular.module('equitrack.directives')
  .directive('loading', function ($translate) { 
    'use strict';

    return {
      restrict: 'E',
      replace: true,
      scope: {
        message: '@',
        text: '='
      },
      template: '\
                  <div class="row"> \
                    <div class="col"> \
                      <ion-spinner></ion-spinner> \
                    </div> \
                    <div class="col" style="white-space: nowrap;"> \
                      {{ text }}\
                    </div> \
                    \
                  </div>',
      controller: function ($scope, $translate) {
        if (!angular.isDefined($scope.message)) {
          $scope.text = $translate.instant('directive.loading.title_default');
        } else {          
          $scope.text = $translate.instant('directive.loading.' + $scope.message);
        }
      }
    };
  });