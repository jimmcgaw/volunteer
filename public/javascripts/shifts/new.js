Volunteer.activate_shift_clone = function(){
    var shift_select = jQuery("select#shifts");
    shift_select.change(function(){
        var shift_id = jQuery(this).val();
        var shift_url = "/shifts/" + shift_id;
        jQuery.ajax({
            url: shift_url,
            type: "GET",
            dataType: "json",
            success: function(json){
                var shift = json['shift'];
                for (prop in shift){
                    var name = "shift_" + prop;
                    var input = jQuery("#" + name);
                    if (input){
                        input.val(shift[prop]);
                    }
                }
            }
        });
    });

};

jQuery(document).ready(function(){
    Volunteer.activate_shift_clone();
});
