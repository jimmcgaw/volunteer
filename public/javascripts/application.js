var Volunteer = {};  //set up namespace for this module

Volunteer.attachPlaceholder = function(input, default_text, class_name){
	
	if (!class_name){
		class_name = "placeholder";
	}
	
	input.addClass(class_name);
	input.val(default_text);
		
	input.focus(function(){
		input.removeClass(class_name);
		if (input.val() == default_text){
			input.val("");
		}
	});
	
	input.blur(function(){
		if (input.val() == ""){
			input.addClass(class_name);
			input.val(default_text);
		}
	});
};

// get all input elements with a placeholder attribute and make them JavaScript-based
// for browsers that don't support HTML5
Volunteer.attachPlaceholders = function(){
	if (!Modernizr.input.placeholder) {
		var placeholder_inputs = jQuery(document).find('input[placeholder]').each(function(index){
			var input = jQuery(this);
			Volunteer.attachPlaceholder(input, input.attr("placeholder"));
		});
	}
};

Volunteer.expandFlash = function(){
	jQuery("div.flash").slideToggle();
	jQuery("div.flash input.close").click(function(){
		jQuery(this).parent("div").slideToggle();
	});
};

Volunteer.prepareDocument = function(){
	Volunteer.attachPlaceholders();
	Volunteer.expandFlash();
};

jQuery(document).ready(Volunteer.prepareDocument);
