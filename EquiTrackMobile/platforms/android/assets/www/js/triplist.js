//var serviceURL = "http://localhost/dirApp/EmployeeDirectoryJQM/www/data/";

var trips;

 $( document ).on( "swiperight", "#tripListPage", function( e ) {
        // We check if there is no open panel on the page because otherwise
        // a swipe to close the left panel would also open the right panel (and v.v.).
        // We do this by checking the data that the framework stores on the page element (panel: open).
       
            $( "#myPanel" ).panel( "open" );
    });


$('#tripListPage').bind('pageinit', function(event) {
	getTripList();
});

function getTripList() {
	$.ajax({
	   type: "GET",	   
	   dataType: "jsonp",	   
	   url: 'http://127.0.0.1:8000/trips/approved/',
	   error: function (xhr) {
            alert(xhr.status + ": " + xhr.statusText);
        },
	   success: function (data) {	
			$('#tripList li').remove();

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

				//alert(tripFromDate);

				$('#tripList').append('<li data-icon="false"><a href="/tripdetails.html?id=' + trip.id + '">' +
				'<h6 class="blueFont wrap">' + trip.purpose_of_travel + '</h6>' +
					'<p>' + trip.traveller + '</p>' +
					'<p>' + tripFromDay + '-' + tripFromMonth + '-' + tripFromYear + ' to ' + trip.to_date.substring(8) + '-' + m_names[parseInt(trip.to_date.substring(5,7))-1] + '-' + trip.to_date.substring(2,4) + '</p>' +
					'<img class="icon-right" src="pics/paper-tick.png"/>' +
					/*'<span class="ui-li-count">' + employee.reportCount + '</span>*/
					'</a></li>');
			});
			$('#tripList').listview('refresh');
		}
	});




/*

		//alert($.get( serviceURL + 'getemployees.php'));
	$.getJSON('data/' + 'mytrips.json', function(data) {

		$('#tripList li').remove();
		trips = data.items;
		$.each(trips, function(index, trip) {
			$('#tripList').append('<li data-icon="false"><a href="tripdetails.html?id=' + trip.id + '">' +

					'<h6 class="blueFont">' + trip.tripdetails + '</h6>' +
					'<p>' + trip.username + '</p>' +
					'<p>' + trip.tripdate + '</p>' +

					'<img class="icon-right" src="pics/paper-tick.png"/>' +

					/*'<span class="ui-li-count">' + employee.reportCount + '</span>*/
	/*				'</a></li>');


		});

		$('#tripList').listview('refresh');
	}).fail( function(data, textStatus, error) {
        console.error("getJSON failed, status: " + textStatus + ", error: "+error);
        alert("getJSON failed, status: " + textStatus + ", error: "+error);
    });
*/

}
