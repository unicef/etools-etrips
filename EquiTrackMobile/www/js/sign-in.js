var trips;
var filteredTrips;
var nikuser = 'ntrncic';
var nikpswd = '12345';

$(document).ready(function(){
	checkPreAuth();

});

$('#btn-submit').click( function(){	
	if($('#txt-email').val() != '' && $('#txt-password').val() != ''){		
		if ($('#chck-rememberme').is(':checked')){
			localStorage.username = $('#txt-email').val();
			localStorage.password = $('#txt-password').val();
		}

		//check login
		if(nikuser == $('#txt-email').val() && $('#txt-password').val())
		{
			$.mobile.changePage("index.html", { transition: "slideup"});
		}
		else{
			//$('#dlg-invalid-credentials').show();
			$('#dlg-invalid-credentials').popup('open', {positionTo: 'window'});
		}
	}
});

function checkPreAuth() {  
		if((typeof localStorage.username === 'undefined' || localStorage.username === null) && (typeof localStorage.password === 'undefined' || localStorage.password === null)) {
		var u = localStorage.username;
		var p = localStorage.password;

		if(u == nikuser && p == nikpswd)
		{	
			//document.location.href = "index.html";
			$.mobile.changePage("index.html", { transition: "slideup", reloadPage: true });
			//return false;
			//$.mobile.pageContainer.pagecontainer("change", "index.html", { ransition: "slideup", reloadPage: true} });
		}
	}
}

$('#signin').live('pagehide', function(event, ui) { 
    setTimeout(function() { window.scrollTo(0, 1) }, 100);
    $.getScript("js/tripList.js", function(){
	   	alert("Script loaded and executed.");
	   // Use anything defined in the loaded script...
	});
});
