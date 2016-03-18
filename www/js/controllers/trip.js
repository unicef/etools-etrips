angular.module('equitrack.tripControllers', [])

.controller('NotesCtrl', function($scope, $stateParams, tripService, $ionicLoading, $ionicHistory, $state, $ionicPopup, errorHandler, $translate, $ionicPlatform){
  $scope.trip = tripService.getTrip($stateParams.tripId);
  $scope.notes = tripService.getDraft($stateParams.tripId, 'notes');

  $ionicPlatform.ready(function() {    
    reset_data();
  });
  
  function reset_data(){
    $scope.data = {
        text : ($scope.notes.text) ? $scope.notes.text : "",
    };
  }
  
  $scope.saveNotes = function(){
    tripService.setDraft($stateParams.tripId, 'notes', $scope.data);
    $ionicPopup.alert({
                title: $translate.instant('controller.notes.save.title'),
                template: $translate.instant('controller.notes.save.template')
            });
  };
  $scope.discardNotes = function(){
    tripService.setDraft($stateParams.tripId, 'notes', {});
    $scope.notes = tripService.getDraft($stateParams.tripId, 'notes');
    reset_data();
    $ionicPopup.alert({
                title: $translate.instant('controller.notes.discard.title'),
                template: $translate.instant('controller.notes.discard.template')
            });
  };
})
;