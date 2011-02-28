Volunteer.load_location = function(){
	jQuery.ajax({
		url: "http://iplocationtools.com/ip_query.php?output=json",
		type: "GET",
		dataType: "json",
		success: function(json){
			alert(json);
		}
	});
};

jQuery(document).ready(function(){
	//Volunteer.load_location();
});
