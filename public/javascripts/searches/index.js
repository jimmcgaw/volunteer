Volunteer.load_results = function(){
	var loc = jQuery(location)[0];
	jQuery.ajax({
		url: loc.pathname + ".json" + loc.search,
		type: "GET",
		dataType: "json",
		success: function(json){
			jQuery("img#loading").addClass("hidden");
			if (json){
				$("#result_template").tmpl(json).appendTo("#event_results");
				/*
				var result_template = jQuery("#result_template").template();
				jQuery.each(json, function(index){
					var item = json[index];
					jQuery.tmpl(result_template, item).appendTo("#event_results");
				});
				*/
			}
		},
		error: function(){
			jQuery("img#loading").addClass("hidden");
		}
	});
};

jQuery(document).ready(function(){
	Volunteer.load_results();
});
