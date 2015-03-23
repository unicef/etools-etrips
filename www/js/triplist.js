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

					/*'<span class="ui-li-count">' + employee.reportCount + '</span>*/'</a></li>');


		});

		$('#tripList').listview('refresh');
	}).fail( function(data, textStatus, error) {
        console.error("getJSON failed, status: " + textStatus + ", error: "+error);
        alert("getJSON failed, status: " + textStatus + ", error: "+error);
    });

}
