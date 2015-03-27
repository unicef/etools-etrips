//var serviceURL = "http://localhost/dirApp/EmployeeDirectoryJQM/www/data/";

var trips;

$(document).ready(function(){

});

$('#prevTrips').click( function(){
	$('#currentTripsList').hide();
	$('#superTripsList').hide();
	getTripList("prevList");
	$('#prevTripsList').show();

	//$.mobile.changePage( "previousTrips.html", { transition: "slide", changeHash: false });
});


$('#currentTrips').click( function(){
	$('#prevTripsList').hide();
	$('#superTripsList').hide();
	getTripList("tripList");
	$('#currentTripsList').show();
	//$.mobile.changePage( "index.html", { transition: "slide", changeHash: false });
});

$('#superTrips').click( function(){
	$('#currentTripsList').hide();
	$('#prevTripsList').hide();
	getTripList("superList");
	$('#superTripsList').show();

	//$.mobile.changePage( "previousTrips.html", { transition: "slide", changeHash: false });
});

$(document).on("swiperight", "#tripListPage", function( e ) {
	// We check if there is no open panel on the page because otherwise
	// a swipe to close the left panel would also open the right panel (and v.v.).
	// We do this by checking the data that the framework stores on the page element (panel: open).

    $("#myPanel").panel("open");
});


$('#tripListPage').bind('pageinit', function(event) {
	$.mobile.loadingMessage = false;

	getTripList("tripList");
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
	   		
	   		formatTrips(myTrips, ulId)			
		}
	});
}

function formatTrips(data, ulId){
	$('#' + ulId + ' li').remove();

	//localStorage.setItem("obj", JSON.stringify(data));

	var m_names = new Array("Jan", "Feb", "Mar", 
	"Apr", "May", "Jun", "Jul", "Aug", "Sep", 
	"Oct", "Nov", "Dec");

	//document.write(curr_date + "-" + m_names[curr_month] 
	//+ "-" + curr_year);


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

		$('#' + ulId).append('<li data-icon="false"><a href="/tripdetails.html?id=' + trip.id + '">' +
		'<h6 class="blueFont wrap">' + trip.purpose_of_travel + '</h6>' +
			'<p>' + trip.traveller + '</p>' +
			'<p>' + tripFromDay + '-' + tripFromMonth + '-' + tripFromYear + ' to ' + trip.to_date.substring(8) + '-' + m_names[parseInt(trip.to_date.substring(5,7))-1] + '-' + trip.to_date.substring(2,4) + '</p>' +
			imgRight +
			'</a></li>');
	});
	$('#' + ulId).listview('refresh');

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
