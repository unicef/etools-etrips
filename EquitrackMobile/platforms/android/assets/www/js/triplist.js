var trips;
var filteredTrips;

//get all trips from api on first load
$('#tripListPage').on('pagecreate', function(event) {
	//$.mobile.loadingMessage = false;
	getTripList("tripList");
	localStorage.logout = 0;
	localStorage.tab = "#currentTrips";
	localStorage.pagecreate = 1;	
});


//on logout call the trips api after login again
$('#tripListPage').on('pageshow',function(event,ui){    
    //show loader widget on ajax call only
    if(localStorage.pagecreate == 1){
	    $.mobile.loading( "show", {
	  		text: "Getting Trips...",
	  		textVisible: true
		});
	} 
    if(localStorage.logout == 1){
    	$.mobile.loading( "show", {
	  		text: "Getting Trips...",
	  		textVisible: true
		});
    	getTripList("tripList"); 
    	localStorage.logout = 0;   	
    }
    $(localStorage.tab).addClass("ui-btn-active"); //highlights the last clicked tab
    //setTimeout(function(){ $.mobile.loading('hide');	},300);

    // $("a[id*='tripDetail']").click(function(){
    // 	alert("tripclick");
    // 	$(this).children().first().removeClass("blueFont");    	
    // });
});


//tabs click
$('#prevTrips').click( function(){
	$('#currentTripsList').hide();
	$('#superTripsList').hide();	
	$('#prevTripsList').show("fast");
	formatTrips(trips, "prevList");
	localStorage.tab = "#prevTrips";
});

$('#currentTrips').click( function(){
	$('#prevTripsList').hide();
	$('#superTripsList').hide();	
	formatTrips(trips, "tripList");
	localStorage.tab = "#currentTrips";	
	$('#currentTripsList').show("fast");
});

$('#superTrips').click( function(){
	$('#currentTripsList').hide();
	$('#prevTripsList').hide();
	formatTrips(trips, "superList");
	localStorage.tab = "#superTrips";
	$('#superTripsList').show("fast");
});

$('.ui-li-has-thumb').click(function(){
	$(this).css('background','#ffffff');
});

 
//getting trips from Equitrack server
function getTripList(ulId) {
	var query = "https://equitrack.uniceflebanon.org/trips/api/?status=planned,submitted,approved,completed,cancelled"
	var myTrips;

	$.ajax({
	    type: "GET",	   
	    dataType: "json",	   
	    url: query,
	    beforeSend : function(xhr) {  
	   		var bytes = Crypto.charenc.Binary.stringToBytes(localStorage.username + ":" + localStorage.password);	   		
			var base64 = Crypto.util.bytesToBase64(bytes);
			xhr.setRequestHeader("Authorization", "Basic " + base64);  
		},
	    error: function (xhr) {
            alert(xhr.status + ": " + xhr.statusText);
        },
	    success: function (data) {
		   	trips = data;
	   		formatTrips(trips, ulId);	
	   		$.mobile.loading( "hide");		
		}
	});
}


//formatting trips into a list
function formatTrips(data, ulId){
	var myTrips;

	if(ulId == "tripList")
	{
		var tripList = getObjects(data, "status", "planned").concat(getObjects(data, "status", "submitted").concat(getObjects(data, "status", "approved")));
		myTrips = getObjects(tripList, "traveller_id", localStorage.userid );	
	}
	else if(ulId == "prevList"){
		var tripList = getObjects(data, "status", "completed").concat(getObjects(data, "status", "cancelled"));
		myTrips = getObjects(tripList, "traveller_id", localStorage.userid );
	}
	else if(ulId == "superList"){
		var tripList = getObjects(data, "status", "submitted").concat(getObjects(data, "status", "approved"));
		myTrips = getObjects(data, "supervisor", localStorage.userid );	
	}

	filteredTrips = myTrips;

	$('#' + ulId + ' li').remove();
	var swipeBtn = "Submit";
	if(ulId == "superList") swipeBtn = "Approve";

	var m_names = new Array("Jan", "Feb", "Mar", 
	"Apr", "May", "Jun", "Jul", "Aug", "Sep", 
	"Oct", "Nov", "Dec");

	$.each(myTrips, function(index, trip) {
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
		 		imgRight = '<img class="icon-right" src="pics/Paper-done.png"/>';
		 		break;
		 	}
	 	var tripJson = getObjects(data, "id", trip.id)	

		$('#' + ulId).append('<li data-icon="false">' + 
                        '<div class="behind">' +
                        	'<a href="#" class="ui-btn swipe-btn">' + swipeBtn + '</a>' +
                        '</div>' +
						'<a id="tripDetail' + trip.id + '" href="javascript:tripDetail(' + trip.id + ');" >' +
						'<h6 class="blueFont wrap">' + trip.purpose_of_travel + '</h6>' +
						'<p>' + trip.traveller + '</p>' +
						'<p>' + tripFromDay + '-' + tripFromMonth + '-' + tripFromYear + ' to ' + trip.to_date.substring(8) + '-' + m_names[parseInt(trip.to_date.substring(5,7))-1] + '-' + trip.to_date.substring(2,4) + '</p>' +
						imgRight +
						'</a></li>');
	});
	$('#' + ulId).listview('refresh');
	swipeLeft(ulId);
	//newSwipeLeft();
}

//go to trip detail page
function tripDetail(tripId){
	if($('#tripDetail' + tripId).css("left") == "-90px") { //check if it has been swiped left
		$('#tripDetail' + tripId).animate({left: "0px"}, 200);
	}
	else{ //go to trip details page
		var tripDetails = getObjects(filteredTrips, "id", tripId)
		localStorage.tripDetail=JSON.stringify(tripDetails);
		localStorage.pagecreate = 0;
		$.mobile.changePage("#tripDetailsPage", { transition: "slide"});
	}
}

function newTrip(){
	localStorage.tripDetail = JSON.stringify("");
	$.mobile.changePage("#tripDetailsPage", { transition: "slide"});
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

//swiping function
function swipeLeft(list){
	function prevent_default(e) {
	        e.preventDefault();
	    }
	    function disable_scroll() {
	        $(document).on('touchmove', prevent_default);
	    }
	    function enable_scroll() {
	        $(document).unbind('touchmove', prevent_default)
	    }

	var x;
	
	$('#' + list + ' li > a')
    .on('touchstart', function(e) {
        //console.log(e.originalEvent.pageX);
        //$('#tripList li > a.open').css('left', '0px').removeClass('open') ;// close em all
        $(e.currentTarget).addClass('open');
        x = e.originalEvent.targetTouches[0].pageX; // anchor point
    })
    .on('touchmove', function(e) {        
        //get trip details 
        var tripId = e.currentTarget.toString().substring(e.currentTarget.toString().indexOf('(') + 1, e.currentTarget.toString().indexOf(')'));
    	var tripDetails = getObjects(filteredTrips, "id", tripId);    	

    	if(tripDetails[0].status == "planned" || (tripDetails[0].status == "submitted" && tripDetails[0].supervisor == localStorage.userid.toString())){ //if status of trip is planned allow swipe
            var change = e.originalEvent.targetTouches[0].pageX - x;
        	change = Math.min(Math.max(-90, change), 0); // restrict to -100px left, 0px right
        	e.currentTarget.style.left = change + 'px';
        	if (change < -10) disable_scroll(); // disable scroll once we hit 10px horizontal slide
    	}
    })
    .on('touchend', function(e) {
        var left = parseInt(e.currentTarget.style.left)
        var new_left;
        if (left < -35) {
            new_left = '-90px';
        } 
        else {
            new_left = '0px';
        }                
        $(e.currentTarget).animate({left: new_left}, 200);
	    enable_scroll();
    });
}

//submit or approve clicked
$(document).on('click', "a.swipe-btn", function() {
	$(this).parents("li").find("a[id*='tripDetail']").animate({left: "0px"}, 200);

	if($(this).parents("li").find('img').attr("src") == "pics/paper-tick.png"){
		$(this).parents("li").find('img').attr("src", "pics/Paper-ticktick.png");
	}
	else if($(this).parents("li").find('img').attr("src") == "pics/Paper.png"){
		$(this).parents("li").find('img').attr("src", "pics/paper-tick.png");
	}
});


// *************************************** trip detail page ****************************************
$('#btn-next').click( function(){
	$.mobile.changePage("#tripItineraryPage", { transition: "slide"});
});

$(document).on('pagebeforeshow', '#tripDetailsPage', function(){       
		//set all values to empty
		//Traveller
		$("#Status").val("").selectmenu('refresh');
		$("#traveller").val("");
		$("#supervisor").val("");
		$("#Section").val("");    	
		$("#travelP").val("");
		$("#from").val("");		
		$("#to").val("");
		$("#type").val("");
		$("#focal").val("");	
		$("#secClearReq").prop("checked", false).checkboxradio('refresh');
		$("#taReq").val("");
		$("#taReq").prop("checked", false).checkboxradio('refresh');	
		$("#budgetOwner").val("");
		$("#resp").val("");
		$("#intTravel").prop("checked", false).checkboxradio('refresh');	
		$("#selRep").val("");
		$("#certHr").val("");
		
		//PCA Details
		$('#relatedPCA').html('');
		$('#relatedPartners').html('');

		//Approval
		$("#aprrovedSuper").prop("checked", false).checkboxradio('refresh');
		$("#aprrovedSuperDate").val("");
		$("#aprrovedBudget").prop("checked", false).checkboxradio('refresh');
		$("#aprrovedBudgetDate").val("");	
		$("#hrApprvoedDate").val("");	
		$("#aprrovedHr").val("");	
		$("#repApproved").val("");	
		$("#repApprovedDate").val("");	
		$("#approvedDate").val("");

		//Travel/Admin
		$("#transBooked").prop("checked", false).checkboxradio('refresh');
		$("#secGranted").prop("checked", false).checkboxradio('refresh');
		$("#taDrafted").prop("checked", false).checkboxradio('refresh');
		$("#taRef").val("");
		$("#taDraftDate").val("");
		$("#visionApprover").val("");

	//get trip from local storage and populate page
	var data = JSON.parse(localStorage.tripDetail);
	
	//check if it's a new trip
	if(data != "")
	{
		//Traveller
		$("#Status").val(data[0].status).selectmenu('refresh');
		$("#traveller").val(data[0].traveller);
		$("#supervisor").val(data[0].supervisor_name);
		$("#Section").val(data[0].section);    
		$("#Office").val(data[0].office); 	
		$("#travelP").val(data[0].purpose_of_travel);
		var fromDate = new Date(data[0].from_date);
		$("#from").val((fromDate.getMonth() + 1) + '/' + fromDate.getDate() + '/' +  fromDate.getFullYear());
		var toDate = new Date(data[0].to_date);
		$("#to").val((toDate.getMonth() + 1) + '/' + toDate.getDate() + '/' +  toDate.getFullYear());
		$("#type").val(data[0].travel_type);
		$("#focal").val(data[0].travel_assistant);	
		if(data[0].security_clearance_required == true) $("#secClearReq").prop("checked", true).checkboxradio('refresh');
		$("#secClearReq").prop('disabled', true);
		$("#taReq").val(data[0].ta_required);
		if(data[0].ta_required == true) $("#taReq").prop("checked", true).checkboxradio('refresh');	
		$("#budgetOwner").val(data[0].budget_owner);
		$("#resp").val(data[0].staff_responsible_ta);
		if(data[0].international_travel == true) $("#intTravel").prop("checked", true).checkboxradio('refresh');	
		$("#selRep").val(data[0].representative);
		$("#certHr").val(data[0].human_resources);
		
		//PCA Details
		var pcas = data[0].pcas.split(",");
		$.each(pcas, function(index, pca) { 
		 	$('#relatedPCA').append('<div style="white-space: pre-wrap;">' + pca.trim() + '</div>');  
		});

		var partners = data[0].partners.split(",");
		$.each(partners, function(index, partner) { 
		 	$('#relatedPartners').append('<div style="white-space: pre-wrap;">' + partner.trim() + '</div>');  
		});

		//$('#relatedPCA').append('<li>' + data[0].pcas + '</li>');
		//$('#relatedPCA').append('<div style="word-wrap: break-word;">' + data[0].pcas + '</div>');
		//$('#relatedPartners').append('<li>' + data[0].partners + '</li>');
		//$('#relatedPartners').append('<div style="word-wrap: break-word;">' + data[0].partners + '</div>');

		//Approval
		if(data[0].approved_by_supervisor == true) $("#aprrovedSuper").prop("checked", true).checkboxradio('refresh');
		$("#aprrovedSuperDate").val(data[0].date_supervisor_approved);
		if(data[0].approved_by_budget_owner == true) $("#aprrovedBudget").prop("checked", true).checkboxradio('refresh');
		$("#aprrovedBudgetDate").val(data[0].date_budget_owner_approved);	
		$("#hrApprvoedDate").val(data[0].date_human_resources_approved);	
		$("#aprrovedHr").val(data[0].approved_by_human_resources);	
		$("#repApproved").val(data[0].representative_approval);	
		$("#repApprovedDate").val(data[0].date_representative_approved);	
		$("#approvedDate").val(data[0].approved_date);

		//Travel/Admin
		if(data[0].transport_booked == true) $("#transBooked").prop("checked", true).checkboxradio('refresh');
		if(data[0].security_granted == true) $("#secGranted").prop("checked", true).checkboxradio('refresh');
		if(data[0].ta_drafted == true) $("#taDrafted").prop("checked", true).checkboxradio('refresh');
		$("#taRef").val(data[0].ta_reference);
		$("#taDraftDate").val(data[0].ta_drafted_date);
		$("#visionApprover").val(data[0].vision_approver);
	}
});

// *************************************** sign in page ********************************************************************

$('#btn-submit').click( function(){	
	//$.mobile.loading( "show");

	if($('#txt-email').val() != '' && $('#txt-password').val() != ''){		
		var username = "";
		var password = "";		
		//check login
		$.ajax({
		    type: "GET",	   
		    dataType: "json",	   
		    url: "http://192.168.88.34:8000/users/profile/" + localStorage.install_id,
		    beforeSend : function(xhr) {  
		   		var bytes = Crypto.charenc.Binary.stringToBytes($('#txt-email').val() + ":" + $('#txt-password').val());	   		
				var base64 = Crypto.util.bytesToBase64(bytes);
				xhr.setRequestHeader("Authorization", "Basic " + base64);  
			},
		    error: function (xhr) {
	            $('#dlg-invalid-credentials').popup('open', {positionTo: 'window'});
	        },
		    success: function (data) {		    	
				if(data.detail != "Invalid username/password"){
					if($('#chck-rememberme').is(":checked")){
						localStorage.username = $('#txt-email').val();
						localStorage.password = $('#txt-password').val();
					}
					localStorage.userid = data.id;
					localStorage.section = data.profile.section;
					localStorage.office = data.profile.office;
					localStorage.job_title = data.profile.job_title;
				
					$.mobile.changePage("#tripListPage", { transition: "slide"});
				}
				else{
					$('#dlg-invalid-credentials').popup('open', {positionTo: 'window'});
				}		
			}
		});
	}
});

$(document).on('pagebeforeshow', '#signin', function(){
	$('#txt-email').val(localStorage.username);
	$('#txt-password').val(localStorage.password);
});

//************************************************** Logout **************************************************************
$('#logout').click( function(){
	localStorage.logout = 1;
	$('#tripList').html("")
	$.mobile.changePage("index.html", { transition: "slide" });	
});

// ***************************************  travel itinierary page ****************************************************************
$(document).on('pagebeforeshow', '#tripItineraryPage', function(){
	var data = JSON.parse(localStorage.tripDetail);	
	var tripItenList = data[0].travel_routes;
	$('#tripItinList').html("");	//remove previous itinerary details from page
	//build trip itinerary list
	$.each(tripItenList, function(index, trip) {        
		var depart = new Date(trip.depart);
		var departStr = '' + ("0" + depart.getDate()).slice(-2) + '-' + getMonthName(depart.getMonth()) + '-' + depart.getFullYear() + ' ' + ("0" + depart.getHours()).slice(-2) + ':' + ("0" + depart.getMinutes()).slice(-2);
		var arrive = new Date(trip.arrive);
		var arriveStr = '' + ("0" + arrive.getDate()).slice(-2) + '-' + getMonthName(arrive.getMonth()) + '-' + arrive.getFullYear() + ' ' + ("0" + arrive.getHours()).slice(-2) + ':' + ("0" + arrive.getMinutes()).slice(-2);

		$('#tripItinList').append(	
			'<li data-icon="false">' + 
				'<div class="ui-corner-all custom-corners">' +
					'<div class="ui-bar">' +
						'<span class="">' + trip.origin + ' </span> <span style="font-weight:bold">to</span> <span class="">' + trip.destination + '</span>' +
					'</div>' +
					'<div class="ui-body ui-body-a">' +
					'<span class="success-light font-small">' + departStr + '</span> to <span class="danger-light font-small">' + arriveStr + '</span>' +
					'</div>' +
				'</div>' +
			'</li>'
		);
	});
});

// ***************************************  funding page ****************************************************************
$(document).on('pagebeforeshow', '#tripFundingPage', function(){
	var data = JSON.parse(localStorage.tripDetail);	
	var tripFundList = data[0].trip_funds;
	$('#tripFundList').html("");	//remove previous funding details from page
	//build trip itinerary list
	$.each(tripFundList, function(index, fund) {      
		$('#tripFundList').append(	
			'<li data-icon="false">' + 
				'<div class="ui-corner-all custom-corners">' +
					'<div class="ui-bar">' +
						'<span>' + fund.wbs + ' </span>' +
					'</div>' +
					'<div class="ui-body ui-body-a">' +
						'<p>' + fund.grant + '</p>' +
						'<p>' + fund.amount + '%</p>' +
					'</div>' +
				'</div>' +
			'</li>'
		);
	});
});

// ************************************** helper functions ****************************************************************

function getMonthName(index)
{
	var month = new Array();
	month[0] = "Jan";
	month[1] = "Feb";
	month[2] = "Mar";
	month[3] = "Apr";
	month[4] = "May";
	month[5] = "Jun";
	month[6] = "Jul";
	month[7] = "Aug";
	month[8] = "Sep";
	month[9] = "Oct";
	month[10] = "Nov";
	month[11] = "Dec";	
	return month[index];
} 
