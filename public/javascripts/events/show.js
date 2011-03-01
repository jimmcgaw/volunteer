var map;

Volunteer.load_map = function(){
	var map_div = document.getElementById("map");
	map = new GMap2(map_div);
	var geocode = jQuery("div#geocode");
	var latitude = geocode.find("span.latitude").html();
	var longitude = geocode.find("span.longitude").html();
	map.setCenter(new GLatLng(latitude, longitude), 10);
    map.setUIToDefault();
	
	var location = new GLatLng(latitude, longitude);
	var marker = new GMarker(location);
	map.addOverlay(marker);
};

jQuery(document).ready(function(){
	if (GBrowserIsCompatible()) {
		Volunteer.load_map();
	}
});
