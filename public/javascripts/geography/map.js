var map;

Volunteer.get_location = function(){
	// ask the user if they'll share their current location with us
	if (geo_position_js.init()){ 
		geo_position_js.getCurrentPosition(Volunteer.load_map, Volunteer.load_map); 
	}
};

Volunteer.load_map = function(p){
	map = new GMap2(document.getElementById("map"));
	if (p && p.coords) {
		// if the user shares their location through HTML5, show local map
		map.setCenter(new GLatLng(p.coords.latitude, p.coords.longitude), 12);
	}
	else {
		// otherwise, show U.S. map
		map.setCenter(new GLatLng(38.6, -98), 4);
	}
    map.setUIToDefault();
	
	Volunteer.load_events();
};

Volunteer.load_events = function(){
	jQuery.ajax({
		url: "/geography/eventpoints",
		dataType: "json",
		type: "GET",
		success: function(json){
			if (json) {
				jQuery.each(json, function(index){
					var item = json[index];
					var location = new GLatLng(item.latitude, item.longitude);
					var marker = new GMarker(location);
					GEvent.addListener(marker, 'click', function(){
                        jQuery.ajax({
                             url: item.json_url,
                             type: 'GET',
                             dataType: 'json',
                             success: function(data){
                                 if (data){
								 	// should make 'data' render with an in-page template
									
									// for now, just build and jam a hyperlink into the bubble
								 	var link = '<a href="'+ data.url + '">' + data.name + '</a>';
                                    marker.openInfoWindowHtml(link);
                                 }
                             }
                    	});
                    });
					map.addOverlay(marker);
				});
			}
		},
		error: function(){
			alert("error!");
		}
	});
};

Volunteer.load_organizations = function(){
	jQuery.ajax({
		url: "/geography/orgpoints",
		dataType: "json",
		type: "GET",
		success: function(json){
			if (json) {
				jQuery.each(json, function(index){
					var item = json[index];
					var location = new GLatLng(item.latitude, item.longitude);
					var marker = new GMarker(location);
					GEvent.addListener(marker, 'click', function(){
                        jQuery.ajax({
                             url: item.json_url,
                             type: 'GET',
                             dataType: 'json',
                             success: function(data){
                                 if (data){
								 	// should make 'data' render with an in-page template
								 	var link = '<a href="'+ data.url + '">' + data.name + '</a>';
                                    marker.openInfoWindowHtml(link);
                                 }
                             }
                    	});
                    });
					map.addOverlay(marker);
				});
			}
		},
		error: function(){
			alert("error!");
		}
	});
};

jQuery(document).ready(function(){
	if (GBrowserIsCompatible()) {
		Volunteer.get_location();
	}
	
});
