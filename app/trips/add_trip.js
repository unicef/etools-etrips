(function() {
    'use strict';

    angular
        .module('app.trips')
        .controller('AddTrip', AddTrip);

    AddTrip.$inject = ['$ionicHistory', '$ionicLoading', '$ionicPopup', '$state', '$translate', 'dataService', 'errorHandler', 'tripService', 'localStorageService', 'lodash'];

    function AddTrip($ionicHistory, $ionicLoading, $ionicPopup, $state, $translate, dataService, errorHandler, tripService, localStorageService, _) {
        var vm = this;
        vm.data = {};
        vm.save = save;
        vm.title = '';

        // check if data type exists in local storage
        _.each(tripService.getAddTripDataTypes(), function(dataType) {
            var data = _.compact(localStorageService.getObject(dataType));

            if (data.length === 0) {
                dataService.getRemoteData(dataType, function() {}, function () {});
            }
        });

        function save() {
            $ionicLoading.show({
                template: '<loading message="saving_trip"></loading>'
            });

            tripService.saveTrip(vm.data).then(
                function() {
                    $ionicLoading.hide();

                    $ionicPopup.alert({
                        title: $translate.instant('controller.trip.add_trip.save.title'),
                        template: $translate.instant('controller.trip.add_trip.save.template')
                    }).then(function() {
                        $ionicHistory.backView().stateParams = {refreshed:true};
                        $ionicHistory.goBack();
                    });
                },
                function(err) {
                    errorHandler.popError(err);
                }
            );
        }
    }
})();

/***

{
  "id": 0,
  "url": "",
  "owner": "",
  "traveller": "",
  "traveller_id": 0,
  "supervisor": "",
  "supervisor_name": "",
  "travel_assistant": "",
  "travel_assistant_name": "",
  "section": "",
  "section_name": "",
  "purpose_of_travel": "",
  "office": "",
  "office_name": "",
  "main_observations": "",
  "constraints": "",
  "lessons_learned": "",
  "opportunities": "",
  "travel_type": "",
  "from_date": "",
  "to_date": "",
  "status": "choice",
  "security_clearance_required": false,
  "ta_required": false,
  "budget_owner": "",
  "budget_owner_name": "",
  "staff_responsible_ta": "",
  "international_travel": false,
  "representative": "",
  "representative_name": "",
  "human_resources": "",
  "human_resources_name": "",
  "approved_by_supervisor": false,
  "date_supervisor_approved": "",
  "approved_by_budget_owner": false,
  "date_budget_owner_approved": "",
  "approved_by_human_resources": "choice",
  "date_human_resources_approved": "",
  "representative_approval": "choice",
  "date_representative_approved": "",
  "approved_date": "",
  "transport_booked": false,
  "security_granted": false,
  "ta_drafted": false,
  "ta_drafted_date": "",
  "ta_reference": "",
  "vision_approver": "",
  "vision_approver_name": "",
  "partners": "",
  "partnerships": "",
  "travelroutes_set": [
    {
      "origin": "",
      "destination": "",
      "depart": "",
      "arrive": "",
      "remarks": ""
    }
  ],
  "actionpoint_set": [
    {
      "id": "",
      "person_responsible": "",
      "person_responsible_name": "",
      "status": "choice",
      "description": "",
      "due_date": "",
      "created_date": "",
      "actions_taken": "",
      "completed_date": "",
      "trip": "",
      "comments": ""
    }
  ],
  "tripfunds_set": [
    {
      "wbs": "",
      "wbs_name": "",
      "grant": "",
      "grant_name": "",
      "amount": 0
    }
  ],
  "triplocation_set": [
    {
      "governorate": "",
      "region": "",
      "locality": "",
      "location": ""
    }
  ],
  "programme_assistant": "",
  "created_date": "",
  "cancelled_reason": "",
  "driver": "",
  "driver_supervisor": "",
  "approved_email_sent": false,
  "submitted_email_sent": false,
  "ta_trip_took_place_as_planned": false,
  "ta_trip_repay_travel_allowance": false,
  "ta_trip_final_claim": false,
  "pending_ta_amendment": false,
  "files": [
    {
      "id": "",
      "file": "",
      "type": "",
      "type_name": "",
      "caption": "",
      "trip": ""
    }
  ]
}




















***/