/**
 * @fileoverview This file contains the JavaScript objects related to field format mask.
 * @requires ap_javascript_base.js Contains functions used by the objects specified within this script
 * @author Doss Anthonimuthu adoss@agencyport.com
 * Reference http://digitalbush.com/projects/masked-input-plugin/
 * @version 0.1
 */

/**
 * Declare namespace if there is none.
 */
if (typeof (ap) === 'undefined') {
	ap = {};
}

/**
 * Define '#' as the format mask for numerics.
 * Also 'a' is defined as all alphabets
 *      '*' is defined as alphanumeric.
 */
$.mask.definitions['#'] = "[0-9]";

/**
 * We turn off autoclear for partial data entry. Showing the user a framework validation 
 * is a little cleaner 
 */
$.mask.autoclear = false;

/**
 * A mask that enforces character entries and a certain pattern. The formatted value is 
 * usually committed to do datastore on the server side
 */
ap.FieldMask = function () {

	/**
	 * Options coming in from the constructor
	 */
	this.options = [];
	
	/**
	 * Initializes the fieldmask on the desired input
	 */
	this.initialize = function(options) {
		$.extend(this.options, options);
		this.$element = $('#'+options.elementId);
		this.enable();
		
		var mask = this.options.mask;
		this.len = mask.length;
		this.placeHolderPattern = new RegExp($.mask.placeholder,'g');
	};
	
	/**
	 * Disables the masking functionality on this field
	 */
	this.unmask = function(){
		var val = this.getValue();
		this.$element.unmask();
		this.$element.val(val);
	};

	/**
	 * Gets the real value from the input element, given the fact that a mask is in place.
	 * This accommodates removing placeholder characters and trailing formatting characters
	 * for partially complete values. The getValue function is part of an API that both 
	 * ap.FieldMask and ap.NumericFieldFormat conform to. 
	 */
	this.getValue = function(value){
		
		value = value ? value : this.$element.val(); 
		value = value.replace(this.placeHolderPattern,'').trim(); //22323-
		
		//we should trim any trailing format characters so we return '02210' for a value like '02210-'
		while(true){
			if(value.length === 0){
				return value;
			}
			var lastChar = value.slice(-1);
			//if the last char is a formatting character (like a '.' or a '-' or a ':') then we remove it from the string
			if(this.isFormatCharacter(lastChar)){
				value = value.slice(0, - 1);
			}
			else {
				return value;
			}
		}
		return "";
	};
	
	/**
	 * Gets the unmasked value - the value with all format characters stripped out.
	 * If a value is passed in, we remove the format characters from that value.
	 * Otherwise, the format mask's own value is used.
	 */
	this.getUnmaskedValue = function(value){
		
		value = value ? value : this.$element.val(); 
		value = value.replace(this.placeHolderPattern,'').trim();
		
		//Removes non-word chars, and underscores
		value = value.replace(/[\W_]/g, '') ;
		

		
		return value;
	};
	
	/**
	 * Determines if a character was something that the user entered or whether it is part of
	 * the format. e.g. the '-' characters in an SSN string would be considered format characters. 
	 */
	this.isFormatCharacter = function (char) {
		//try to figure out if the character is normal or a special formatting char
		//normal char pattern = [A-Za-z0-9]
		var normalCharExp = new RegExp($.mask.definitions['*']);
		
		return !normalCharExp.test(char);
	};
	
	/**
	 * This is a null-op for Fieldmasks but the method exists because it is part of an API that both
	 * ap.FieldMask and ap.NumericFieldFormat conform to.
	 */
	this.decorate = function(value){
		return value;
	};
	
	/**
	 * Disables the masking functionality on this field. Similar to this.unmask except this method
	 * is part of an API that both ap.FieldMask and ap.NumericFieldFormat conform to.  
	 */
	this.disable = function(){
		this.unmask();
	};
	
	/**
	 * Enables the masking functionality on this field. This method is part of an API that both 
	 * ap.FieldMask and ap.NumericFieldFormat conform to.  
	 */
	this.enable = function(){
		this.unmask();
		this.$element.mask(this.options.mask);
	};
	
	//End of constructor - time to initialize
	this.initialize(arguments[0]);
	
};


/**
* Format the data as user inputs them, and data field is right aligned.
*/
ap.NumericFieldFormat = function () {
		
	this.initialize = function(options) {
		this.$element = $('#' + options.elementId); 	
		this.options = options;		
		this.init(this.options.mask,this.options.settings);		
		this.$element.val(this.decorate(this.$element.val(), this));
		this.cleanMantissa(this);
		this.bind();
	};
	
	this.init = function(formatMask, settings) {		
		this.requiresMantissa = true;
		this.MaximumFractionDigits = settings.MaximumFractionDigits;
		this.PositivePrefix = settings.PositivePrefix;
		this.GroupingSize = settings.GroupingSize;
		this.DecimalSeparator = settings.DecimalSeparator;
		this.GroupingSeparator = settings.GroupingSeparator;

		if(settings.MaximumFractionDigits == 0){
			this.requiresMantissa = false;
		}
	};
	
	this.bind = function() {

		this.$element.addClass('formatNumeric');		
		this.$element.bind('keyup', {self:this}, this.keyup); 
		this.$element.bind('blur', {self:this}, this.blur);
		this.$element.bind('focus', {self:this}, this.focus);
		this.$element.on("paste", function() {
			setTimeout(function() {
				this.caret(this.focus());
			});
		});
	};
	
	this.fireEvent= function(element,event){
		if (document.createEvent){
			var evt = document.createEvent("HTMLEvents");
			evt.initEvent(event, true, true ); 
			return element.dispatchEvent(evt);
		}else{
			var evt = document.createEventObject();
			return element.fireEvent('on'+event,evt);
		}
	};
	
	this.unbind= function() {
		this.$element.removeClass('formatNumeric');
		this.$element.off("keyup");
		this.$element.off("blur");
		this.$element.off("focus");
		this.$element.off("paste");
	};
	
	this.keyup = function (event){
	
		var self = event.data.self;
		if(!self || self ===undefined){
			self = this;
		}
		var elementVal = self.$element.val();
		var str = self.decorate(elementVal, self);
		
		if (self.$element.attr('maxLength') !== undefined && str.length >=  self.$element.attr('maxLength')) {
			var offset = (str.length - 1) - self.$element.attr('maxLength');

			if (offset === 0) {
				offset = 1;
			}

			var myregexp = new RegExp("[^" + this.DecimalSeparator + "\\d]", "g");
			self.$element.val(self.$element.val().replace(myregexp, ''));
			self.$element.val(self.wholeNumberMask(self.$element.val().substr(0, self.$element.val().length - offset)));
			str = self.$element.val();
		}

		if(str !== elementVal){
			var c = self.caret();
			self.$element.val(str);
			if(str.length < elementVal.length){
				self.caret(c.begin - 1, c.end - 1);
			 }else if(str.length > elementVal.length) {
				 self.caret(c.begin + 1, c.end + 1);
			 }else {
				 self.caret(c.begin, c.end);
			 }
		 }
		ap.consoleInfo('numeric field masking for fieldId "' + self.$element.attr('id') + '":   decorated ' + elementVal + ' to ' + str);
	};
	
	this.decorate = function (str, self) {
		if(!self){
			self = this;
		}
		if(str.indexOf(self.DecimalSeparator) === -1){
			return self.wholeNumberMask(str) ;
		}else if(str.indexOf(self.DecimalSeparator) > -1 ){
			
			var str1 = str.substring(0, str.indexOf(self.DecimalSeparator));
			
			if(!self.requiresMantissa) {
				return self.wholeNumberMask(str1);
			}
			
			var str2 =  str.substring(str.indexOf(self.DecimalSeparator));
			str2 = str2.replace(/[^\d]+/g,'');
			str2 = str2.substring(0, self.MaximumFractionDigits);
			
			var period = self.DecimalSeparator;
			str1 = self.wholeNumberMask(str1);
			
			if(str1 === '' && str2 === ''){
				return '';
			}
			
			return str1 + period + str2;
		}else {
			return str.replace(/[^\d]+/g,'');
		}
	};
	this.cleanMantissa = function(self) {
		var str = self.$element.val();
		if(str.indexOf(self.DecimalSeparator)>-1 ){
			var str1 = str.substring(0,str.indexOf('.'));
			var str2 =  str.substring(str.indexOf('.'));
			str2 = str2.replace(/[^\d]+/g,'');
			if(str2 ==''){
				self.$element.val(str1);
			}
		}
	};
	
	this.blur = function (event) {
		var self = event.data.self;
		if(!self || self ===undefined){
			self = this;
		}
		self.cleanMantissa(self);
		if (self.$element.val() != self.focusText){
			self.fireEvent(self.$element[0], 'change');
		}
	};
	
	this.wholeNumberMask = function(str){
		str=str.replace(/[^\d]+/g,'');
		
		str= this.reverse(str);
		
		var str3="";
		var i=0;
		for (var k = 0; k < str.length; k++){
			str3=str3 + str.charAt(k);
			if(i==this.GroupingSize -1){
				i=0;
				if(k!=(str.length-1)){
					str3=str3  + this.GroupingSeparator;
				}
			}else{
				i++;
			}
		}
		if(str3.length>0){
			str=this.reverse(str3);
		}else{
			str = "";
		}

		str = str == '' ? '' : this.PositivePrefix + str;
		
		return str;
	};
	
	this.reverse = function(theString){
		var newString = "";
		var counter = theString.length;
		for (counter;  counter > 0 ; counter -- ) {
			newString += theString.substring(counter-1, counter);
		}

		return newString;
	};
	
	this.unmask = function () {
		var myregexp = new RegExp("[^"+this.DecimalSeparator+"\\d]","g");
		this.$element.val(this.$element.val().replace(myregexp ,''));
	};
	
	this.getValue = function (value) {
		value = value ? value : this.$element.val(); 
		var myregexp = new RegExp("[^"+this.DecimalSeparator+"\\d]","g");
		return value.replace(myregexp ,'');
	};
	
	/**
	 * Null op, as the getValue for Numeric field is already unmasked.
	 */
	this.getUnmaskedValue = this.getValue;
	
	/**
	 * Determines if a character was something that the user entered or whether it is part of
	 * the format. e.g. the '$' characters in a USD string would be considered format characters. 
	 */
	this.isFormatCharacter = function (char) {
		var normalCharExp = new RegExp("[^"+this.DecimalSeparator+"\\d]");
		
		return !normalCharExp.test(char);
	};
	
	this.focus = function(event) {
		var self = event.data.self;
		if(!self || self ===undefined){
			self = this;
		}
		self.focusText = self.$element.val();
		self.keyup(event);
		self.blur(event);
	};
	
	this.caret = function(begin, end) {
		if (typeof begin == 'number') {
			end = (typeof end == 'number') ? end : begin;
			if (this.$element[0].setSelectionRange) {
				this.$element[0].focus();
				this.$element[0].setSelectionRange(begin, end);
			} else if (this.$element[0].createTextRange) {
				var range = this.$element[0].createTextRange();
				range.collapse(true);
				range.moveEnd('character', end);
				range.moveStart('character', begin);
				range.select();
			}

		} else {
			if (this.$element[0].setSelectionRange) {
				begin = this.$element[0].selectionStart;
				end = this.$element[0].selectionEnd;
			} else if (document.selection && document.selection.createRange) {
				var range = document.selection.createRange();
				begin = 0 - range.duplicate().moveStart('character', -100000);
				end = begin + range.text.length;
			}
			return { begin: begin, end: end };
		}
	};
	
	this.disable = function() {
		this.unbind();
	};
	
	this.enable = function() {
		this.bind();
	};
	
	this.initialize(arguments[0]);
};
