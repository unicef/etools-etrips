angular.module('equitrack.services', [])

.service('API_urls', function($localStorage) {
        var defaultConn = 2;
        var options = { //0 : 'https://etoolslocal.localtunnel.me', //dev
                        0 : 'https://etoolsdev.localtunnel.me', //dev
                        1 : 'https://etools-dev.unicef.org', //stg
                        2 : 'https://etools-staging.unicef.org'}; //prod

        function get_base(){
            console.log('getting base_url')
            var base_url = $localStorage.get('base_url')
            if (base_url){
                return options[base_url]
            }
            return options[defaultConn]

        }
        function get_option_name(){
            var base_url = $localStorage.get('base_url');
            if (base_url){
                return base_url
            }
            return defaultConn
        }
        function set_base(base){
            console.log(base)
            $localStorage.set('base_url', base)
        }
        return {
            BASE: get_base,
            ADFS: true, //(get_option_name() == '0') ? false: true,
            get_option_name: get_option_name,
            set_base: set_base
        }
})
.service('TokenService', function($localStorage){
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
        };

        function getClaimsFromToken() {
            var token = $localStorage.get('jwtoken');
            //console.log("getclaims", token);
            var user = {"no":"no"};
            if (typeof token !== 'undefined') {
                var encoded = token.split('.')[1];
                user = JSON.parse(urlBase64Decode(encoded));
            }
            return user;
        };
        function isTokenExpired(){
            var token = $localStorage.getObject('tokenClaims');
            var now = new Date();
            if ((!Object.keys(token).length) ||
                ((token.exp*1000) < now.getTime())){
                return true
            } else {
                return false
            }
        }
        return{
            getClaimsFromToken: getClaimsFromToken,
            isTokenExpired:isTokenExpired
        }
})
.service('myHttp', function($q, $http, $localStorage, $ionicPopup, LoginService, $ionicLoading, TokenService){
        var showConfirm = function(template, succ, fail) {
            var confirmPopup = $ionicPopup.prompt({
               title: 'Session Expired',
               template: template,
               inputType: 'password',
               inputPlaceholder: 'Your password'
             });
            confirmPopup.then(function (res) {
                if (res) {
                    succ(res)
                } else {
                    fail(res)
                }
            });
        };
        var httpWrapp = function(method, path, data, ignore_expiration){
            var def = $q.defer()
            var req = {
                  method: method,
                  url: path
                }
            if (method != 'GET'){
                req.data = data
            }
            function confirmed_reLogin(res){
                $ionicLoading.show({template: "Loading..."});
                console.log(res, 'we are logging in again')
                var relogin_cred = $localStorage.getObject('relogin_cred');
                relogin_cred.password = res;
                LoginService.refreshLogin(
                    function(succ){
                        // continue with the action
                        console.log('managed to relogin', succ)
                        $http(req).then(
                            function(res){$ionicLoading.hide(); def.resolve(res)},
                            function(rej){$ionicLoading.hide(); def.reject(rej)}
                        );
                    },
                    function(fail){
                        console.log("failed to relogin", fail)
                        def.reject(fail)
                    },
                    relogin_cred
                )
            };
            function failed_reLogin(){
                console.log('user chose not to continue with re-logging in')
                def.reject('Cancelled by user')
            }
            if ((!ignore_expiration) && (TokenService.isTokenExpired())){
                $ionicLoading.hide();
                showConfirm('Your session has ended, please enter your password to proceed:', confirmed_reLogin, failed_reLogin)
            } else {
                $http(req).then(
                    function(res){def.resolve(res)},
                    function(rej){def.reject(rej)}
                );
            }
            return def.promise;
        };

        return {
            get: function(path, ignore_expiration){
                return httpWrapp('GET', path, false, ignore_expiration)
            },
            post:function(path, data, ignore_expiration){
                return httpWrapp('POST', path, data, ignore_expiration)
            },
            patch:function(path, data, ignore_expiration){
                return httpWrapp('PATCH', path, data, ignore_expiration)
            },
        }
})
.service('LoginService',['$q', '$rootScope', '$localStorage', 'Auth', 'API_urls',
    function($q, $rootScope, $localStorage, Auth, API_urls) {
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
            $localStorage.delete('tokenClaims');
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
            refreshLogin: function(retSuccess, retFail, data){
                if (!data){
                    data = $localStorage.getObject('relogin_cred');
                }
                if (!data){
                    console.log('No credentials were provided for relogin')
                    retFail();
                    return
                }
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
               $http.post(API_urls.BASE() + '/signup', data).success(success).error(error)
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
                   return $http.post(API_urls.BASE() + '/api-token-auth/', data)
               }



           },
           logout: function (success) {
               $localStorage.delete('currentUser');
               $localStorage.delete('jwttoken');
               $localStorage.delete('trips');
               $localStorage.delete('users');
               $localStorage.delete('tokenClaims');
               success();
           },
           getTokenClaims: getClaimsFromToken,
           urlBase64Decode : urlBase64Decode
       };
}])
.factory('Data', ['$timeout', 'API_urls', '$localStorage', 'myHttp',
        function ($timeout, API_urls, $localStorage, myHttp) {

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
                   return myHttp.get(API_urls.BASE() + '/trips/api/list/').then(
                       function(succ){
                           $localStorage.setObject('trips',succ.data);
                           success(succ.data)
                       },
                       function(err){
                           error(err)
                       })
        }
        var get_users_remote = function get_from_server(success, error){
                   return myHttp.get(API_urls.BASE() + '/users/api/').then(
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
            return myHttp.patch(API_urls.BASE() + '/trips/api/' + tripId +"/", data).then(
                function(succ){
                    success(succ)
                },
                function(err){
                    fail(err)
                });
        }

       return {
           get_profile: function (success, error) {
               myHttp.get(API_urls.BASE() + '/users/api/profile/').then(
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


.factory('TripsFactory', ['Data', '$localStorage', 'myHttp', 'API_urls', function(Data, $localStorage, myHttp, API_urls) {

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
        var url = API_urls.BASE() + '/trips/api/' + id + '/';
        var result = myHttp.post(url + action + '/', data);
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

    }
    function getDraft(tripId, dtype){
        // if there isn't a currentUser in here we're in big trouble anyway
        var country = $localStorage.getObject('currentUser').profile.country
        var my_obj = $localStorage.getObject('draft-' + country);


        if (Object.keys(my_obj).length) {
            // check for trip
            if (my_obj[tripId]) {
                if (( dtype == 'text') && (my_obj[tripId][dtype])) {
                    return my_obj[tripId][dtype]
                }
                if (( dtype == 'notes') && (my_obj[tripId][dtype])) {
                    return my_obj[tripId][dtype]
                }
            }
        }
        return {}

    }
    function setDraft(tripId, dtype, draft){
        console.log("tripid, type, draft", tripId, dtype, draft)
        // if there isn't a currentUser in here we're in big trouble anyway
        var country = $localStorage.getObject('currentUser').profile.country
        var my_obj = $localStorage.getObject('draft-' + country);

        // if there is an object stored
        if (Object.keys(my_obj).length){
            // if this object has the tripId
            if (my_obj[tripId]){
                my_obj[tripId][dtype] = draft
            } else {
                my_obj[tripId]={}
                my_obj[tripId][dtype] = draft
            }
        } else {
            my_obj = {}
            my_obj[tripId]={}
            my_obj[tripId][dtype] = draft
        }
        $localStorage.setObject('draft-'+country, my_obj)
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
        getDraft:getDraft,
        setDraft:setDraft
	}
}]);