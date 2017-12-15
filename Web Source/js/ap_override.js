/*
 * This class implements field override functionality.  The key to this implementation
 * is having a shadow field with a unique id where the first part is the same as the real
 * field with '_Service' appended.
 */	
ap.override = function() {
	
 	/*
	* This methods clears the override indicator for a field.
	* @param fieldId The HTML id of the overridden field.
	*/		
	this.clearOverride = function(fieldId) {
		$('#' + fieldId + '_ovr').remove();
	};
	
 	/*
	* This methods adds an override indicator icon, sets the title information and
	* calls any function defined for callback for the field.
	* @param fieldId The HTML id of the overridden field.
	*/		
	this.showHideOverrideMessage = function(fieldId) {
		var field = ap.page.form.getFieldByUniqueId(fieldId);
        var val = field.getValue();
        var sysVal = $('#' + fieldId + '_Service').val();  
        
		if (sysVal === undefined || sysVal.length == 0) {
			return;
		}
		
		this.clearOverride(fieldId);
		
		if (val != sysVal) {

			fieldLabel = $('#' + fieldId + '_labelText').text().toLowerCase();
			span = $('<span/>').attr('id', fieldId + '_ovr').addClass('fa fa-exclamation-triangle override-icon');
			span.attr('data-content', this.getOverrideMessageContent(fieldId, fieldLabel, sysVal));
			span.attr('data-placement','right');
			span.attr('data-container','body');
			span.attr('data-toggle','popover');
			span.attr('data-html','true');
			
			span.insertAfter('#' + fieldId + '_fieldHelpers');
			span.popover('hide');
			
		}
	};	
	
 	/*
	* Creates the message you see when you click on the override icon.
	* @param fieldId The HTML id of the overridden field link.
	* @param fieldLabel The page field label.
	* @param sysVal The value returned by the service call 
	*/		
	this.getOverrideMessageContent = function(fieldId, fieldLabel, sysVal) {
		
		var fieldSelector = '#' + fieldId;
		
		// If select list get text value for display
		if ($(fieldSelector).is( "select" ) && sysVal.length != 0) {
			sysVal = $(fieldSelector + " option[value='" + sysVal + "']").text();
		}			
				
		var message = ap.applyPositionalVariableSubstitutions(ap.core_prompts["message.Override.System.Value"],	 fieldLabel, (sysVal.length == 0 ? 'blank' : sysVal));
		message = '<div>' + message + '</div>';
		return message;
	};	
			
};
var override = new ap.override();