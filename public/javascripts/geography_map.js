var map;

Volunteer.load_map = function(){
	map = new GMap2(document.getElementById("map"));
    map.setCenter(new GLatLng(38.6,-98), 4);
    map.setUIToDefault();
	
	Volunteer.load_points();
};

Volunteer.load_points = function(){
	jQuery.ajax({
		url: "/organizations",
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
		Volunteer.load_map();
	}
	
});
