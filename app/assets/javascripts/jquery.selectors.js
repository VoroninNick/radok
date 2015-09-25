function present(val){

    //console.log("val", val)
    var numeric_val = parseInt(val)
    if(!Number.isNaN(numeric_val)){
        if(numeric_val == 0){
            return false
        }
        else{
            return true
        }
    }
    return !!val
}

function blank(val){
    return !present(val)
}

$.extend( $.expr[ ":" ], {
    // http://jqueryvalidation.org/blank-selector/
    blank: function( a ) {
        //return !$.trim( "" + $( a ).val() );
        var val = $(a).val()
        return blank(val)
    },
    // http://jqueryvalidation.org/filled-selector/
    filled: function( a ) {
        return !!$.trim( "" + $( a ).val() );
    },
    present: function(a){
        var val = $.trim( "" + $( a ).val() )
        return present(val)
    },
    // http://jqueryvalidation.org/unchecked-selector/
    unchecked: function( a ) {
        return !$( a ).prop( "checked" );
    }
});