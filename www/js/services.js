angular.module('equitrack.services', [])

.service('LoginService',['$q', '$rootScope', '$localStorage', '$state', 'Auth', 'API_urls',
    function($q, $rootScope, $localStorage, $state, Auth, API_urls) {
        function successAuth(res, retSuccess) {
               var JWToken;
               if (API_urls.ADFS){
                    console.log(res)
                    var mys;
                    var r;
                    var encoded_token;
                    mys = res.data.substr(res.data.indexOf('BinarySecurityToken'));
                    r = mys.substr(mys.indexOf('>'));
                    encoded_token = r.substr(1,r.indexOf('<')-1);

                    JWToken = Auth.urlBase64Decode(encoded_token);
               } else {
                    JWToken = res.data.token
               }

               $localStorage.set('jwtoken', JWToken);
               $localStorage.setObject('tokenClaims', Auth.getTokenClaims());

               // trigger a call to get the current User

               //console.log($localStorage.getObject('currentUser'));
               retSuccess($localStorage.get('jwtoken'));
        }
        function failAuth(res){
               //console.log("failAuth")
               $rootScope.error = 'Invalid credentials.';
        }

        function logout(){
            $localStorage.delete('jwtoken');
            $localStorage.delete('currentUser');
            $localStorage.delete('trips');
            $localStorage.delete('users');
        }

        return {
            loginUser: function(data, retSuccess, retFail){
                //console.log("loginUser called")
                //console.log(data)
                Auth.login(data).then(
                    function(res){
                        successAuth(res, retSuccess)
                    } ,
                    function(err){
                        //console.log("logingUser.err")
                        retFail(err)
                    })
            },
            logout: logout

        }

}])
.service('Auth', ['$http', '$localStorage', 'API_urls', "$window", "SoapEnv",
    function ($http, $localStorage, API_urls, $window, SoapEnv){

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
           var token = $localStorage.get('jwtoken');
           //console.log("getclaims", token);
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
               if (API_urls.ADFS){
                   console.log("in Auth.login")
                   console.log(data)
                   var req = {
                         method: 'POST',
                         //url: "https://unangtst.appspot.com/coords/",
                         url: SoapEnv.adfsEndpoint,
                         headers: SoapEnv.headers,
                         data: SoapEnv.body(data.username, data.password)
                        }
                   console.log(req)
                   return $http(req)
               } else {
                   return $http.post(API_urls.BASE + '/api-token-auth/', data)
               }



           },
           logout: function (success) {
               $localStorage.delete('currentUser');
               $localStorage.delete('jwttoken');
               $localStorage.delete('trips');
               $localStorage.delete('users');
               success();
           },
           getTokenClaims: getClaimsFromToken,
           urlBase64Decode : urlBase64Decode
       };
}])
.factory('Data', ['$timeout', '$http', 'API_urls', '$localStorage',
        function ($timeout, $http, API_urls, $localStorage) {

        var refresh_trips = function(){
            get_trips_remote(function(){}, function(){})
        }

        var check_timestamp = function(resource){
            var myt = $localStorage.get(resource);
            if (!myt) {
                return false
            }
            myt = new Date(Number(myt));
            var now = new Date();

            return (now < myt)
        }

        var get_trips_remote = function get_from_server(success, error){
                   return $http.get(API_urls.BASE + '/trips/api/list/').then(
                       function(succ){
                           $localStorage.setObject('trips',succ.data);
                           success(succ.data)
                       },
                       function(err){
                           error(err)
                       })
        }
        var get_users_remote = function get_from_server(success, error){
                   return $http.get(API_urls.BASE + '/users/api/').then(
                       function(succ){
                           $localStorage.setObject('users', succ.data);

                           var expires = new Date()
                           expires.setMinutes(expires.getMinutes()+5)
                           $localStorage.set('users_timestamp', expires.getTime()+'')
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
               $http.get(API_urls.BASE + '/users/api/profile/').then(
                   function(succ){
                       var myUser = succ.data;
                       myUser.user_id = myUser.id;
                       console.log('myUser', JSON.stringify(myUser))
                       $localStorage.setObject('currentUser', myUser);
                       success(succ)
                   },
                   error)
           },
           get_trips: function (success, error, refresh) {

               if ((refresh === true) || (!Object.keys($localStorage.getObject('trips')).length)){
                   get_trips_remote(success, error)
               } else {
                   return success($localStorage.getObject('trips'))
               }
           },
           get_user_base: function(success, error, refresh) {


               if ((refresh === true) ||
                   (!Object.keys($localStorage.getObject('users')).length) ||
                   (!check_timestamp('users_timestamp'))){

                   console.log("getting the users from outside")
                   get_users_remote(success, error)

               } else {
                   return success($localStorage.getObject('users'))
               }
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
    function localTripUpdate(id, trip){
        var currentTrips = $localStorage.getObject('trips')
        for(var i=0;i<currentTrips.length;i++){
				if(currentTrips[i].id == id){
                    currentTrips[i] = trip;
                    $localStorage.setObject("trips", currentTrips)
					return true;
				}
			}
            return false
    }
    function localAction(id, action){
        var currentTrips = $localStorage.getObject('trips')
        for(var i=0;i<currentTrips.length;i++){
				if(currentTrips[i].id == id){
                    currentTrips[i].status = action;
                    $localStorage.setObject("trips", currentTrips)
					return true;
				}
			}
            return false
    }

    function reportText(data, tripId, success, fail){
        // if we need any extra data proccessing here would be the place
        Data.patch_trip(tripId, data, success, fail)
        //for (var k in data) {
        //    if (data.hasOwnProperty(k)) {
        //        console.log(k)
        //        trip[k] = data[k]
        //    }
        //}
        //console.log(trip)
        //console.log('here is where we update the trip')
    }

	return {
        localApprove: function(id){
            return localAction(id, 'approved')
        },
        localSubmit: function(id){
            return localAction(id, 'submitted')
        },
		getTrip: function(id){
            console.log("getting trip from", $localStorage.getObject('trips'))
			for(var i=0;i<$localStorage.getObject('trips').length;i++){
				if($localStorage.getObject('trips')[i].id == id){
					return $localStorage.getObject('trips')[i];
				}
			}
			return null;
		},
        reportText: reportText,
        tripAction: tripAction,
        localTripUpdate: localTripUpdate,
        getAP:getAP,
        sendAP:sendAP,
	}
}]);