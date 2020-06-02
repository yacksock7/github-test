var ajaxPostSend =  function(url, type , dataType, callback, formId) {
		var s_callback = eval(callback);
	    $.ajax({                          
	        type: type,
	        url: url,
	        data : $("#"+formId).serialize(),
	        dataTYpe : dataType,
	        success: function(rslt) {s_callback(rslt);}
	    });
}; 

var ajaxPostSend_sync =  function(url, type , dataType, callback, formId) {
	var s_callback = eval(callback);
    $.ajax({                          
        type: type,
        url: url,
        data : $("#"+formId).serialize(),
        dataTYpe : dataType,
        async: false,
        success: function(rslt) {s_callback(rslt);}
    });
}; 