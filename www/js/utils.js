angular.module('equitrack.utils', [])


.factory('$localStorage', ['$window', function($window) {
  return {
    set: function(key, value) {
      $window.localStorage[key] = value;
    },
    get: function(key, defaultValue) {
      return $window.localStorage[key] || defaultValue;
    },
    delete: function(key){
        delete $window.localStorage[key]
    },
    setObject: function(key, value) {
      $window.localStorage[key] = JSON.stringify(value);
    },
    getObject: function(key) {
      return JSON.parse($window.localStorage[key] || '{}');
    }
  }
}])
.factory('SoapEnv', ['$window', function($window) {
      var adfsEndpoint = "https://sts.unicef.org/adfs/services/trust/13/UsernameMixed";
      var resourceEndpoint = "https://etools-staging.unicef.org/API";
      var headers = {
        "Content-Type": "application/soap+xml; charset=utf-8"
      };

      function soap_body(username, password) {
        return '<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope" xmlns:a="http://www.w3.org/2005/08/addressing" xmlns:u="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">' +
            '<s:Header>' +
            '<a:Action s:mustUnderstand="1">http://docs.oasis-open.org/ws-sx/ws-trust/200512/RST/Issue</a:Action>' +
            '<a:To s:mustUnderstand="1">' +
            adfsEndpoint +
            '</a:To>' +
            '<o:Security s:mustUnderstand="1" xmlns:o="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">' +
            '<o:UsernameToken u:Id="uuid-6a13a244-dac6-42c1-84c5-cbb345b0c4c4-1">' +
            '<o:Username>'+
             username+
            '</o:Username>' +
            '<o:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">' +
            password+
            '</o:Password>' +
            '</o:UsernameToken>' +
            '</o:Security>' +
            '</s:Header>' +
            '<s:Body>' +
            '<trust:RequestSecurityToken xmlns:trust="http://docs.oasis-open.org/ws-sx/ws-trust/200512">' +
            '<wsp:AppliesTo xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy">' +
            '<a:EndpointReference>' +
            '<a:Address>' +
            resourceEndpoint +
            '</a:Address>' +
            '</a:EndpointReference>' +
            '</wsp:AppliesTo>' +
            '<trust:KeyType>http://docs.oasis-open.org/ws-sx/ws-trust/200512/Bearer</trust:KeyType>' +
            '<trust:RequestType>http://docs.oasis-open.org/ws-sx/ws-trust/200512/Issue</trust:RequestType>' +
            '</trust:RequestSecurityToken>' +
            '</s:Body>' +
            '</s:Envelope>'
      }




  return {
    body: soap_body,
    adfsEndpoint: adfsEndpoint,
    headers: headers,
  }
}]);