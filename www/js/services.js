angular.module('equitrack.services', [])

.service('LoginService',['$q', '$rootScope', '$localStorage', '$state', 'Auth',
    function($q, $rootScope, $localStorage, $state, Auth) {
        function successAuth(res, retSuccess) {
               console.log("successAuth")
               $localStorage.jwtoken = res.data.token;
               $localStorage.currentUser = Auth.getTokenClaims()
               console.log($localStorage.currentUser)
               retSuccess($localStorage.jwtoken);
        }
        function failAuth(res){
               console.log("failAuth")
               $rootScope.error = 'Invalid credentials.';
        }

        function login(name, pw){
                Auth.login({"name":name, "password":password}, successAuth, failAuth)

        }
        function logout(){
            delete $localStorage.jwtoken;
            delete $localStorage.currentUser;
        }

        return {
            loginUser: function(data, retSuccess, retFail){
                console.log("loginUser called")
                Auth.login(data).then(function(res){
                        successAuth(res, retSuccess)
                    } ,function(err){retFail(err)})
            },
            logout: logout

        }

}])
.service('Auth', ['$http', '$localStorage', 'API_urls', "$window",
    function ($http, $localStorage, API_urls, $window){

        function urlBase64Decode(str) {
           var output = str.replace('-', '+').replace('_', '/');
           switch (output.length % 4) {
               case 0:
                   break;
               case 2:
                   output += '==';
                   break;
               case 3:
                   output += '=';
                   break;
               default:
                   throw 'Illegal base64url string!';
           }
           return $window.atob(output);
       }

       function getClaimsFromToken() {
           var token = $localStorage.jwtoken;
           console.log("getclaims", token);
           var user = {"no":"no"};
           if (typeof token !== 'undefined') {
               var encoded = token.split('.')[1];
               user = JSON.parse(urlBase64Decode(encoded));
           }
           return user;
       }


       return {
           signup: function (data, success, error) {
               $http.post(API_urls.BASE + '/signup', data).success(success).error(error)
           },
           login: function (data) {
               return $http.post(API_urls.BASE + '/api-token-auth/', data)
           },
           logout: function (success) {
               delete $localStorage.currentUser
               delete $localStorage.jwttoken;
               success();
           },
           getTokenClaims: getClaimsFromToken
       };
}])
.factory('Data', ['$timeout', '$http', 'API_urls', '$localStorage',
        function ($timeout, $http, API_urls, $localStorage) {

        var refresh_trips = function(){
            get_trips_remote(function(){}, function(){})
        }

        var get_trips_remote = function get_from_server(success, error){
                   return $http.get(API_urls.BASE + '/trips/api/list/').then(
                       function(succ){
                           $localStorage.trips = succ.data
                           success(succ.data)
                       },
                       function(err){
                           error(err)
                       })
       }
        var patchTrip = function patchTrip(tripId, data, success, fail){
            return $http.patch(API_urls.BASE + '/trips/api/' + tripId +"/", data).then(
                function(succ){
                    success(succ)
                },
                function(err){
                    fail(err)
                });
        }

       return {
           get_profile: function (success, error) {
               $http.get(API_urls.BASE + '/users/profile/').then(success, error)
           },
           get_trips: function (success, error, refresh) {

               $timeout(function(){

               if ((refresh === true) || (typeof ($localStorage.trips) === 'undefined')){
                   get_trips_remote(success, error)
               } else {
                   return success($localStorage.trips)
               }} , 50)
           },
           get_user_base: function(success, error) {
               $http.get(API_urls.BASE + '/users/').then(success, error)
           },
           refresh_trips: refresh_trips,
           patch_trip: patchTrip,
       };
   }
])


.factory('TripsFactory', ['Data', '$localStorage', '$http', 'API_urls', function(Data, $localStorage, $http, API_urls) {

    function formatAP(ap, for_upload){

            if (for_upload == true){
                ap.due_date = ap.due_year+"-"+
                        ap.due_month+"-"+
                        ap.due_day;
                delete ap.due_day;
                delete ap.due_year;
                delete ap.due_month;
                delete ap.person_responsible_name;
                return ap


            } else {
                ap.person_responsible += "";
                var date_array = ap.due_date.split("-")
                ap.due_year = date_array[0]
                ap.due_day = date_array[2]
                ap.due_month = date_array[1]
                return ap
            }


    }
    function getAP(trip, ap_id){
        for(var i=0;i<trip.actionpoint_set.length;i++){
            if (trip.actionpoint_set[i].id == ap_id){
                return formatAP(trip.actionpoint_set[i])
            }
        }
        return null
    }
    function sendAP(tripId, ap, success, fail){
        data = {"actionpoint_set":[formatAP(ap, true)]}
        Data.patch_trip(tripId, data, success, fail)

    }
    function tripAction(id, action, data){
        var url = API_urls.BASE + '/trips/api/' + id + '/';
        var result = $http.post(url + action + '/', data);
        return result

    }
    function localAction(id, action){
        for(var i=0;i<$localStorage.trips.length;i++){
				if($localStorage.trips[i].id == id){
                    $localStorage.trips[i].status = action;
					return true;
				}
			}
            return false
    }

	return {
        localApprove: function(id){
            return localAction(id, 'approved')
        },
        localSubmit: function(id){
            return localAction(id, 'submitted')
        },
		getTrip: function(id){
            console.log("getting trip from", $localStorage.trips)
			for(i=0;i<$localStorage.trips.length;i++){
				if($localStorage.trips[i].id == id){
					return $localStorage.trips[i];
				}
			}
			return null;
		},
        tripAction: tripAction,
        getAP:getAP,
        sendAP:sendAP,
	}
}]);