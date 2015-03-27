$(document).on('pageshow','#detailsPage' ,function(event) {

});

$(document).ready(function(){
	alert("TEST!");
	//var localObj = localStorage.getItem("obj");
	//console.log('localObj: ', JSON.parse(localObj));

	// $.each(localObj, function(index, trip) {		
	// 	$.each(trip, function(index1, trip1) {		
	// 		var obj2 = localObj[index1];
	// 	});
	// });


});



jQuery("ul#listview")
    .on('click', function(){

    })
    .on('click', 'li', function(e) {
    	alert("TEST");
    });