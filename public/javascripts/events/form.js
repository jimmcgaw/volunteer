Volunteer.activate_location_select = function(){
	var location_select = jQuery("select#event_location_id");
	location_select.change(function(){
		var location_id = jQuery(this).val();
		Volunteer.load_location_form(location_id);
	});
};

Volunteer.load_location_form = function(location_id){
	var location_form = jQuery("div#new_location_form");
	jQuery.ajax({
		url: "/locations/" + location_id,
		dataType: "json",
		type: "GET",
		success: function(json){
			var location = json['location'];
			for (prop in location){
				var name = "location_" + prop;
				var input = jQuery("#" + name);
				if (input){
					input.val(location[prop]);
				}
			}
		}
	});
};

jQuery(document).ready(function(){
	Volunteer.activate_location_select();
});
