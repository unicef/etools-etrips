var trips;
var filteredTrips;
var nikuser = 'ntrncic';
var nikpswd = '12345';

$('#tripListPage').on('pagecreate', function(event) {
	$.mobile.loadingMessage = false;
	getTripList("tripList");
		// your login page code here
});

$('#prevTrips').click( function(){
	$('#currentTripsList').hide();
	$('#superTripsList').hide();
	getTripList("prevList");
	$('#prevTripsList').show();
});

$('#currentTrips').click( function(){
	$('#prevTripsList').hide();
	$('#superTripsList').hide();
	getTripList("tripList");
	$('#currentTripsList').show();
});

$('#superTrips').click( function(){
	$('#currentTripsList').hide();
	$('#prevTripsList').hide();
	getTripList("superList");
	$('#superTripsList').show();
});

$(document).on("swiperight", "#tripListPage", function( e ) {
	// We check if there is no open panel on the page because otherwise
	// a swipe to close the left panel would also open the right panel (and v.v.).
	// We do this by checking the data that the framework stores on the page element (panel: open).
    $("#myPanel").panel("open");
});


$('#tripListPage').bind('pageinit', function(event) {
	//$.mobile.loadingMessage = false;

	//getTripList("tripList");
});

$('.ui-li-has-thumb').click(function(){
	$(this).css('background','#ffffff');
});

function getTripList(ulId) {
	var query = "http://192.168.88.34:8000/trips/approved/";
	if(ulId == "tripList")
	{
		query = "http://192.168.88.34:8000/trips/approved/?status=planned,submitted,approved";
	}
	else if(ulId == "prevList"){
		query = "http://192.168.88.34:8000/trips/approved/?status=completed,cancelled";
	}
	else if(ulId == "superList"){
		query = "http://192.168.88.34:8000/trips/approved/?status=submitted,approved";
	}
	var userId = 62

	$.ajax({
	   type: "GET",	   
	   dataType: "jsonp",	   
	   url: query,
	   error: function (xhr) {
            alert(xhr.status + ": " + xhr.statusText);
        },
	   success: function (data) {
   			//filter for traveller or supervisor
   			var myTrips = getObjects(data, "traveller_id", userId )	
	   		if(ulId == "superList")
   		   		myTrips = getObjects(data, "supervisor", userId )	
	   		filteredTrips = myTrips;
	   		formatTrips(myTrips, ulId);			
		}
	});
}

function formatTrips(data, ulId){
	$('#' + ulId + ' li').remove();

	var m_names = new Array("Jan", "Feb", "Mar", 
	"Apr", "May", "Jun", "Jul", "Aug", "Sep", 
	"Oct", "Nov", "Dec");

	$.each(data, function(index, trip) {
		var tripFromMonth = m_names[parseInt(trip.from_date.substring(5,7))-1];
		var tripFromYear = trip.from_date.substring(2,4);
		var tripFromDay = trip.from_date.substring(8);
		var imgRight = '<img class="icon-right" src="pics/Paper.png"/>';
		
		switch(trip.status){
		 	case "submitted":
		 		imgRight = '<img class="icon-right" src="pics/paper-tick.png"/>';
		 		break;
		 	case "approved":
		 		imgRight = '<img class="icon-right" src="pics/Paper-ticktick.png"/>';
		 		break;
		 	case "cancelled":
		 		imgRight = '<img class="icon-right" src="pics/Paper-X.png"/>';
		 		break;
		 	case "completed":
		 		imgRight = '<img class="icon-right" src="pics/Paper.png"/>';
		 		break;
		 	}
	 	var tripJson = getObjects(data, "id", trip.id)	

		$('#' + ulId).append('<li data-icon="false">' + 
                        '<div class="behind">' +
                        	'<a href="#" class="ui-btn delete-btn">Delete</a>' +
                        	'<a href="#" class="ui-btn edit-btn pull-left">Edit</a>' +
                        '</div>' +

						'<a id="tripDetail' + trip.id + '" href="javascript:tripDetail(' + trip.id + ');" >' +
						'<h6 class="blueFont wrap">' + trip.purpose_of_travel + '</h6>' +
						'<p>' + trip.traveller + '</p>' +
						'<p>' + tripFromDay + '-' + tripFromMonth + '-' + tripFromYear + ' to ' + trip.to_date.substring(8) + '-' + m_names[parseInt(trip.to_date.substring(5,7))-1] + '-' + trip.to_date.substring(2,4) + '</p>' +
						imgRight +
						'</a></li>');
	});
	$('#' + ulId).listview('refresh');
}

function tripDetail(tripId){
	var tripDetails = getObjects(filteredTrips, "id", tripId)
	localStorage.tripDetail=JSON.stringify(tripDetails);
	$.mobile.changePage("#tripDetailsPage", { transition: "slideup"});
}

//querying JSON
function getObjects(obj, key, val) {
    var objects = [];
    for (var i in obj) {
        if (!obj.hasOwnProperty(i)) continue;
        if (typeof obj[i] == 'object') {
            objects = objects.concat(getObjects(obj[i], key, val));
        } else if (i == key && obj[key] == val) {
            objects.push(obj);
        }
    }
    return objects;
}


var x;
$('#tripList li > a')
    .on('touchstart', function(e) {
        console.log(e.originalEvent.pageX)
        $('#tripList li > a.open').css('left', '0px').removeClass('open') // close em all
        $(e.currentTarget).addClass('open')
        x = e.originalEvent.targetTouches[0].pageX // anchor point
    })
    .on('touchmove', function(e) {
        var change = e.originalEvent.targetTouches[0].pageX - x
        change = Math.min(Math.max(-100, change), 100) // restrict to -100px left, 0px right
        e.currentTarget.style.left = change + 'px'
        if (change < -10) disable_scroll() // disable scroll once we hit 10px horizontal slide
    })
    .on('touchend', function(e) {
        var left = parseInt(e.currentTarget.style.left)
        var new_left;
        if (left < -35) {
            new_left = '-100px'
        } else if (left > 35) {
            new_left = '100px'
        } else {
            new_left = '0px'
        }
        // e.currentTarget.style.left = new_left
        $(e.currentTarget).animate({left: new_left}, 200)
        enable_scroll()
    });


/*
//swipe function
$( document ).on( "swipeleft swiperight", "#tripList li.ui-li-has-thumb", function( event ) {
	var listitem = $( this ),
	// These are the classnames used for the CSS transition
	dir = event.type === "swipeleft" ? "left" : "right",
	// Check if the browser supports the transform (3D) CSS transition
	transition = $.support.cssTransform3d ? dir : false;
	
	confirmAndDelete( listitem, transition );
});

function confirmAndDelete( listitem, transition ) {
	// Highlight the list item that will be removed
	listitem.addClass( "ui-btn-down-d" );
	// Inject topic in confirmation popup after removing any previous injected topics
	//$( "#confirm .topic" ).remove();
	//listitem.find( ".topic" ).clone().insertAfter( "#question" );
	// Show the confirmation popup
	$( "#confirm" ).popup( "open" );
	// Proceed when the user confirms
	$( "#confirm #yes" ).on( "click", function() {
		// Remove with a transition
		if ( transition ) {
			
			listitem
				// Remove the highlight
				.removeClass( "ui-btn-down-d" )
				// Add the class for the transition direction
				.addClass( transition )
				// When the transition is done...
				.on( "webkitTransitionEnd transitionend otransitionend", function() {
					// ...the list item will be removed
					listitem.remove();
					// ...the list will be refreshed and the temporary class for border styling removed
					$( "#list" ).listview( "refresh" ).find( ".ui-li.border" ).removeClass( "border" );
				})
				// During the transition the previous list item should get bottom border
				.prev( "li.ui-li" ).addClass( "border" );
		}
		// If it's not a touch device or the CSS transition isn't supported just remove the list item and refresh the list
		else {
			listitem.remove();
			$( "#list" ).listview( "refresh" );
		}
	});
	// Remove active state and unbind when the cancel button is clicked
	$( "#confirm #cancel" ).on( "click", function() {
		listitem.removeClass( "ui-btn-down-d" );
		$( "#confirm #yes" ).off();	
	});
}
*/

// *************************************** trip detail page ****************************************

$(document).on('pagebeforeshow', '#tripDetailsPage', function(){       
	//alert('My name is ' + localStorage.tripDetail);
	var data = JSON.parse(localStorage.tripDetail);
	$("#Status").val(data[0].status);
	$("#traveller").val(data[0].traveller);
	$("#supervisor").val(data[0].supervisor_name);
	$("#Section").val(data[0].section);    	
	$("#travelP").val(data[0].purpose_of_travel);
	var fromDate = new Date(data[0].from_date);
	$("#from").val((fromDate.getMonth() + 1) + '/' + fromDate.getDate() + '/' +  fromDate.getFullYear());
	var toDate = new Date(data[0].to_date);
	$("#to").val((toDate.getMonth() + 1) + '/' + toDate.getDate() + '/' +  toDate.getFullYear());
	$("#type").val(data[0].travel_type);
	$("#focal").val(data[0].travel_assistant);	
	$("#secClearReq").val(data[0].security_clearance_required);
	$("#taReq").val(data[0].ta_required);
	$("#budgetOwner").val(data[0].budget_owner);
	$("#resp").val(data[0].staff_responsible_ta);
	$("#intTravel").val(data[0].international_travel);
	$("#selRep").val(data[0].representative);
	$("#certHr").val(data[0].approved_by_human_resources);		
});

// *************************************** sign in page ****************************************

$('#signin').on('pagecreate', function(event) {
	$.mobile.loadingMessage = false;
	getTripList("tripList");
		// your login page code here
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
			$.mobile.changePage("#tripListPage", { transition: "slideup"});
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


