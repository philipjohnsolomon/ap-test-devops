/**
 * @fileoverview This file contains the JavaScript objects which provide support for client-side secure field inputs
 */


/**
 * Define the global 'ap' namespace, if it has not already been defined
 */
var ap = ap || {};

/**
 * @constructor
 * @class the FieldSecurityHandler contains of the logic which supports the client side aspect of the
 * "Secured data entry" user experience. There are two major aspects to this User experience: The first
 * is that the user's characters are "secured" from shoulder snoopers on blur. The second is that we
 * now support the server having a value for the field which is concealed from the client. The client
 * provides a UI to replace the concealed value without ever showing it to the user.
 * @param modeString is the string representation of the desired ap.FieldSecurityMode
 * @param numRevealChars is the desired number of characters to reveal to the user for an
 * 	ap.FieldSecurityMode of "revealSuffix" or "revealPrefix"
 * @param initialValue is the value for this field as determined by the server - this can be the special
 * 	constant "${NOT_RENDERED}" which means that the server has decided not to tell us the true value for
 * 	this field, even though it has one. 
 * @param owningField is the ap.Field to be secured.
 * @return a new fieldSecurityHandler instance for this field.
 */
ap.FieldSecurityHandler = function(modeString, numRevealChars, initialValue, owningField){
	
	/**
	 * a locally scoped variable containing the object for use during callback events.
	 */
	var me = this;

	/*
	 * Begin member declarations...
	 */
	
	/**
	 * the ap.FieldSecurityMode for this field.
	 */
	this.mode = new ap.FieldSecurityMode(modeString);
	
	/**
	 * the desired number of characters to reveal to the user for an ap.FieldSecurityMode of "revealSuffix"
	 * or "revealPrefix"
	 */
	this.numRevealChars = numRevealChars;
	
	/**
	 * the corresponding ap.Field object for this secured field.
	 */
	this.field = owningField;
	
	/**
	 * this is the standard text input which the user interacts with.
	 */
	this.$textInput = loadTextInput();
	
	/**
	 * this is a hidden input which retains the raw the data value which the user has entered for form submission.
	 */
	this.$hiddenRawValueInput = loadRawValueInput(initialValue);
	
	/**
	 * this will be true if the server has not made the raw value for this field available to the client
	 */
	this.concealedValueExperience = initialValue === "${NOT_RENDERED}";
	
	this.oldValue = this.$hiddenRawValueInput.val() ;
	
	if(this.concealedValueExperience){
		
		/**
		 * The text input value contains the masked label that we need to show the user. This came from the server
		 * because we can't come up with this in client side logic due to the fact that we have no idea what the
		 * concealedValue persisted on the server looks like.
		 */
		this.concealedLabel = this.$textInput.val();
		
		//for the concealed UX, the user doesn't see the text input unless the click edit, and when they click edit
		//they should be working with an empty text input
		this.$textInput.val("");
		this.oldValue = "";
		
		/**
		 * This contains the concealed label and edit control shown to the user when the value is concealed. We
		 * dynamically inflate this during paint.
		 */
		this.$concealedExperienceElement = undefined;
		
	}
	
	/**
	 * isMasked is true whenever the browser is showing the $textInput to the user and its value is being
	 * masked/hidden/secured/(insert more synonyms here). During page load, we'll be in an initially masked
	 * state whenever the persisted raw value is made available to the client; later setFocus events will
	 * trigger and unmasking and this flag will be updated accordingly.
	 */
	this.isMasked = this.concealedValueExperience;
	
	/**
	 * this is true whenever the field is in focus. this flag should always return the same value as
	 * `this$textInput[0] === document.activeElement` which arguably renders this flag redundant but
	 * since we already have focus and focusout handlers, adds some readability
	 */
	this.isFocus = false;

	/*
	 * Begin public API methods...
	 */
	
	
	/**
	 * Masks the value of the field from display, if the field is valid. The value to be secured is
	 * stored, in its unmasked form within the $hiddenRawValueInput for both storage and for later
	 * form submission. If there is a format mask on the field, it is disabled. This is so that the
	 * $textInput can accommodate the masked label that we replace the value with, which contains '*'
	 * characters in-place of the actual data values.
	 */
	this.maskValue = function() {
		
		var rawValue = this.getValue();
		
		this.$hiddenRawValueInput.val(rawValue);
		
		if(this.field.isValid && rawValue !== ""){
			var maskedValue;

			var characterOperation;
			
			if(this.field.fieldFormatMask) {
				characterOperation = function(char){
					//Only replace non formatting chars with *
					if(me.field.fieldFormatMask.isFormatCharacter(char)){
						return char;
					}
					else {
						return "*";
					}
				};
			} else {
				characterOperation = function(char){
					//Replace any char with an *
					return "*";
				};
			}
			if(this.mode.isFullyMask()){
				maskedValue = this.fullyMaskText(rawValue, characterOperation);
			} else if (this.mode.isRevealSuffix()){
				maskedValue = this.maskTextRevealingSuffix(rawValue, characterOperation);
			} else {
				maskedValue = this.maskTextRevealingPrefix(rawValue, characterOperation);
			}
						
			this.$textInput.val(maskedValue);
			this.isMasked = true;
		}
	};

	/**
	 * Reveals the raw value for this secured field to the user in the $textInput, making sure that any
	 * formatmasks that were on the field are re-enabled (these would have been disabled to accommodate
	 * '*' characters during the maskValue step)
	 */
	this.revealValue = function(){
		
		this.$textInput.val(this.$hiddenRawValueInput.val());
		//we need to make sure we re-enable any format masks which may have been disabled
		if(this.field.fieldFormatMask) {
			this.field.fieldFormatMask.enable();
		}
		this.isMasked = false;
	};
	
	/**
	 * Unless true is passed for "displayValue", getValue is used to retrieve the raw,
	 * unsecured value for the field. This works regardless of whether the field is in
	 * a masked or unmasked state. If true is passed as the displayValue param then
	 * this function should return the masked label when we're in a masked state, else
	 * the raw value.
	 * @param displayValue send true if you want the value that's currently displaying
	 * 	on the UI, whether its the masked label or the raw value
	 * @returns either the raw value or the masked label
	 */
	this.getValue = function(displayValue) {
		displayValue = displayValue ? displayValue : false;
		if(this.concealedValueExperience && displayValue){
			return this.concealedLabel;
		}
		if(this.isMasked){
			if(me.field.fieldFormatMask && !displayValue) {
				return this.field.fieldFormatMask.getValue(this.$hiddenRawValueInput.val());
			}
				
			if(displayValue){
				//we're going to return the masked label in this case
				return this.$textInput.val();
			}
			if( this.$hiddenRawValueInput.val() !== "${NOT_RENDERED}"){
				return this.$hiddenRawValueInput.val();
			}
			return "";
		} else {
			return this.$textInput.val();
		}
	};
	
	/**
	 * Performs a masking operation on the entire string provided with the "rawValue" parameter. The
	 * "characterOperation" should be a function which masks any given character in the rawValue i.e.
	 * replace the character with a '*'.
	 * @param rawValue the raw string value that is to be masked
	 * @param characterOperation a function which masks any given character in the string
	 * @returns {String} the masked string
	 */
	this.fullyMaskText = function (rawValue, characterOperation){
		return replaceChars(rawValue, 0, rawValue.length, characterOperation);
	};
	
	/**
	 * Performs a masking operation on part of the string provided with the "rawValue" parameter; a
	 * suffix of the string, whose length is defined by this.numRevealChars, will be retained. The
	 * "characterOperation" should be a function which masks any given character in the rawValue i.e.
	 * replace the character with a '*'
	 * @param rawValue the raw string value that is to be masked
	 * @param characterOperation a function which masks any given character in the string
	 * @returns {String} the masked string
	 */
	this.maskTextRevealingSuffix = function (rawValue, characterOperation){
		
		return replaceChars(rawValue, 0, rawValue.length - this.numRevealChars, characterOperation);
	};
	
	/**
	 * Performs a masking operation on part of the string provided with the "rawValue" parameter; a
	 * prefix of the string, whose length is defined by this.numRevealChars, will be retained. The
	 * "characterOperation" should be a function which masks any given character in the rawValue i.e.
	 * replace the character with a '*'
	 * @param rawValue the raw string value that is to be masked
	 * @param characterOperation a function which masks any given character in the string 
	 * @returns {String} the masked string
	 */
	this.maskTextRevealingPrefix = function (rawValue, characterOperation){
		
		return replaceChars(rawValue, this.numRevealChars, rawValue.length, characterOperation);
	};
	
	/**
	 * if there is a format-mask in place on the related ap.Field object, we have to disable it so
	 * the $textInput can display our masked value (format masks usually don't allow '*')
	 */
	this.suppressFormatMask = function() {
		if(this.field.fieldFormatMask) {
			this.field.fieldFormatMask.disable();
		}
	};
	
	/**
	 * handles the operations which need to take place for the secured field during ap.Field.paint().
	 * This registers event listeners, and sets up the concealedValueExperience.
	 */
	this.paint = function(){
		
		//If the server has a value which is concealing from the client then we provide the user
		//with an altered UX
		if(this.concealedValueExperience){
			
			if(!this.$concealedExperienceElement){
				var $fieldContainer = this.$textInput.parent();
				$fieldContainer.hide();
				this.field.disableValidation();

				this.$concealedExperienceElement = $(document.createElement("span"));
				this.$concealedExperienceElement.text(this.concealedLabel);
				this.$concealedExperienceElement.addClass("secure-label");
				
				var $editControl = $(document.createElement("span"));
				$editControl.addClass("edit-secure");
				
				var $icon = $(document.createElement("i"));
				$icon.addClass("fa");
				
				$editControl.append($icon);
				this.$concealedExperienceElement.append($editControl);
				
				this.$concealedExperienceElement.insertAfter($fieldContainer);
			}
			
			this.$concealedExperienceElement.children(".edit-secure").click(this.editConcealedCallback);
			
			if(this.field.readOnly){
				this.hide();
			}
		} else {
			//on page paint scenarios we want to make sure that we re-mask if needed.
			if (this.$hiddenRawValueInput.val() !== "") {
				this.$textInput.val(this.$hiddenRawValueInput.val());
				if(!this.isFocus){
					this.suppressFormatMask();
					this.maskValue();
				}
			}
		}
		
		ap.registerEvent(this.$textInput[0], "focus", this.focusCallback);
		ap.registerEvent(this.$textInput[0], "focusout", this.focusOutCallback);
		ap.registerEvent(this.$textInput[0], "blur", this.blurCallback);
		
	};

	/**
	 * Hides any additional UI under the purview of the fieldSecuirtyHandler (typically for read-only
	 * scenarios)
	 */
	this.hide = function(){
		if(this.concealedValueExperience && this.$concealedExperienceElement){
			this.$concealedExperienceElement.hide();
		}
	};
	
	/**
	 * Shows any additional UI under the purview of the fieldSecuirtyHandler which has been previously
	 * hidden (typically for read-only scenarios)
	 */
	this.show = function(){
		if(this.concealedValueExperience && this.$concealedExperienceElement){
			this.$concealedExperienceElement.show();
		}
	};
	
	/*
	 * Begin callback event handlers...
	 */
	
	
	/**
	 * focus callback which is assigned to the $textInput
	 */
	this.focusCallback = function(){
		me.isFocus = true;
		me.revealValue();
	};
	
	/**
	 * focusout callback which is assigned to the $textInput
	 */
	this.focusOutCallback = function(){
		me.suppressFormatMask();
	};
	
	/**
	 * blur callback which is assigned to the $textInput
	 */
	this.blurCallback = function(){
		me.isFocus = false;
		me.maskValue();
		//we trigger a change event here to fire of any hotfield events which need to be fired 
		if(me.oldValue != me.$hiddenRawValueInput.val()){ 
			me.$textInput.trigger("change");
			me.oldValue = me.$hiddenRawValueInput.val();
		}
	};
	
	/**
	 * date-picker change callback which is called by the standard changeDate event which is
	 * attached to the $textInput's datepicker widget (if any)
	 */
	this.dateChangeCallback = function(){
		me.suppressFormatMask();
		me.isMasked = false;
		me.maskValue();
	};
	
	/**
	 * this is the click event that is attached to the edit-control icon used as part of the
	 * concealedValueExperience
	 */
	this.editConcealedCallback = function() {
		//once they click edit, the concealedValueExperience is turned off until the user
		//submits the form or refreshes the page
		me.concealedValueExperience = false;
		me.$concealedExperienceElement.hide();
		me.field.enableValidation();
		me.$hiddenRawValueInput.val("");
		me.$textInput.parent().show();
		me.$textInput.focus();
	};
	
	
	/*
	 * Begin private functions...
	 */
	
	/**
	 * Grabs the text input from the DOM and returns its jQuery wrapper object
	 */
	function loadTextInput() {
		//this class should only be working with text fields, and for text fields the input will
		//always be the first (and only) element in the element array
		return $(me.field.elements[0]);
	}
	

	/**
	 * If the value is populated from IPDTR, need to set the value to $textInput and $hiddenRawValueInput property
	 * If there's concealedValue for the secure field, the concealedEperienceElement will be hided and text field will show
	 * to show the updated value with masking
	 */
	this.reLoadTextInput =  function reLoadTextInput() { 
		if(this.concealedValueExperience){ 
			this.concealedValueExperience = false;
			me.$concealedExperienceElement.hide();
			me.field.enableValidation();
			me.$hiddenRawValueInput.val("");
			me.$textInput.parent().show(); 
			this.concealedLabel="";
		}
		this.$textInput = $(me.field.elements[0]); 
		this.$hiddenRawValueInput.val(this.$textInput.val());
		me.oldValue = this.$hiddenRawValueInput.val();
	} 
	 
	 
	/**
	 * Creates the hidden "raw-value" input, inserts it into the $fromRow on the DOM, and returns its jQuery wrapper object
	 * @initialValue is the initial value that is going to be contained within the hidden input
	 */
	function loadRawValueInput(initialValue) {
		var input = document.createElement("input");
		
		input.setAttribute("type", "hidden");

		input.setAttribute("name", "_CONTROL_.RV." + me.field.name);

		input.setAttribute("value", initialValue);
		var $hiddenInput = $(input);
		
		me.field.$formRow.append($hiddenInput);
		return $hiddenInput;
	}
	
	/*this.reLoadRawValue =  function reLoadRawValue() {  
		if(this.field.readOnly && !this.field.canReadSecureData){
			this.concealedValueExperience = true;
			if(this.$textInput.val() !== ""){ 
				this.concealedLabel = this.$textInput.val();
			}
			this.$hiddenRawValueInput.val("${NOT_RENDERED}"); 
		}
	}*/
	
	/**
	 * The character replacement function that is used traverse part of the given string and
	 * and apply the given "operation"
	 */
	function replaceChars(string, startIndex, endIndex, operation){
		var ret;
		if(startIndex > 0){
			ret = string.substring(0, startIndex);
		} else {
			ret = "";
		}
		
		for(var i = startIndex; i < endIndex; i++){
			ret += operation(string.charAt(i));
		}
		
		if(endIndex < (string.length -1)){
			ret += string.substring(endIndex, string.length);
		}
		
		return ret;
	}
};

/**
 * @constructor
 * @class ap.FieldSecurityMode acts like a Java enum that defines the available types of field
 * security modes.
 */
ap.FieldSecurityMode = function(modeString){
	
	this.mode = modeString;
	
	this.isFullyMask = function(){
		if(this.mode === "fullyMask"){
			return true;
		}
		return false;
	};
	
	this.isRevealSuffix = function(){
		if(this.mode === "revealSuffix"){
			return true;
		}
		return false;
	};
	
	this.isRevealPrefix = function(){
		if(this.mode === "revealPrefix"){
			return true;
		}
		return false;
	};
	
};