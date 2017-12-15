/** 
 * @fileoverview This file contains the static functions for use in the
 *  AgencyPortal framework. Authors of custom javascript are encouraged
 *  to take advantage of the functions specified here within their own code.
 * @author Michael Albert malbert@agencyport.com Norm Baker nbaker@agencyport.com Jayaram Sreevalsan jsreevalsan@agencyport.com  
 * @version 5.0
 */


/**
 *	ap is a singleton object instance used as a means of namespacing javascript variables defined in AgencyPort code.
 */
var ap = {};
if(ap.constants === undefined){
	ap.constants = {};
}
/**
 *  Add slashes is a function that has been created to add escape characters to an AgencyPort XPath
 *  like expression which may contain single quote characters. If left unescaped, these characters can
 *  cause unexpected behavior within JavaScript code.
 *
 *  Add slashes can be used anytime that a developer is writing JavaScript which creates additional
 *  lines of JavaScript for later execution and wishes to ensure that the JavaScript is sanitized for apostrophes.
 *
 * @param {string} A string whose apostrophes should be escaped.
 * @returns the escaped version of the input string
 * @author Michael Albert malbert@agencyport.com
 */

ap.addSlashes = function (string) {
	return string.replace(/\'/g, "\\'");
};

/**
*  addLoadEvent can be used to  associate the execution of a function with the 
*  window.onLoad intrinsic event
*  
 * @param {func} The function that should be attached to window.onLoad
 * @author Pradeep Namepally pnamepally@agencyport.com
 */

ap.addLoadEvent = function (func) {
	
	$( func );
};



/**
 * createRandomString is a function that can be used to create a string of a requested link made up of a series of alphanumeric characters.
 *
 * @param {length} The length of the sought after string
 * @returns a string made up of random alpha-numeric characters
 * @author Michael Albert malbert@agencyport.com
 */
ap.createRandomString = function (length) {
	var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";

	if (!length || typeof (length) != 'number') {
		length = 8;
	}
	var string = "";

	for (var i = 0; i < length; i++) {
		var rnum = Math.floor(Math.random() * chars.length);
		string += chars.substring(rnum, rnum + 1);
	}

	return string;
};

/**
 *  getUniqueId can be used to get a unique ID for programmatically generated DOM nodes.
 *  getUniqueId will make up random numbers, see if they are in use, and return the first one that is not.
 *
 *  getUniqueId can be used to generate a unique id attrbiute for a programatically added dom node. Note
 *  that this unique id is different than the TDF unique id added as part of DTR.
 * @returns a numeric id string unique to the DOM
 * @type Number
 * @author Michael Albert malbert@agencyport.com
 */
ap.getUniqueId = function () {
	var id = ap.createRandomString(7);
	while (document.getElementById(id)) {
		id = ap.createRandomString(7);
	}
	return id;
};

/**
 * Constructs a new StringBuffer object.
 * @constructor
 * @class The StringBuffer class provides general string concatenation support
 * for large string buffers needing to be managed.
 * @link http://www.comet.co.il/en/articles/performance/article.html
 * @return A new StringBuffer instance
 */
ap.StringBuffer = function () {
	/**
	 *	The <code>buffer</code> field contains current contents for this instance.. It is of type Array.
	 *	@type Array
	 */
	this.buffer = [];
	/**
	 *	Appends a string to the current buffer.
	 *	@param string is the string to append.
	 */
	this.append = function (string) {
		this.buffer.push(string);
	};
	/**
	 *	Returns the current buffer as a string.
	 *	@return a string value reflecting the current contents of this instance.
	 *	@type String
	 */
	this.toString = function () {
		return this.buffer.join("");
	};
};

/** 
 * TODO: Candidate for convertion to JSON object model.
 * We need to revist this when the REST layer in implemented.
 */
/**
 * Constructs a new XMLWriter object.
 * @constructor
 * @class The XMLWriter class provides support for XML document creation without
 * the need for the overhead of a DOM document.
 * @return A new XMLWriter instance
 */
ap.XMLWriter = function () {
	/**
	 *	The <code>xml</code> field contains the existing XML data buffer.
	 *	@type StringBuffer
	 */
	this.xml = new ap.StringBuffer();
	/**
	 *	The <code>stack</code> contains an entry for every element sequence begun which has not yet been ended.
	 *	@type Array
	 */
	this.stack = [];

	/**
	 *	Appends XML content to the current XML buffer being managed.
	 *	@param content is the XML string to append.
	 */
	this.appendContent = function (content) {
		this.xml.append(content);
	};

	/**
	 *	Returns the current XML buffer as a string.
	 *	@return a string value reflecting the current XML contents of this instance.
	 *	@type String
	 */
	this.getXML = function () {
		return this.xml.toString();
	};

	/**
	 *	Starts an XML element sequence. For every <b>startElement</b> called there needs to be an
	 *	<b>endElement</b>.
	 *	@param name is the name of the XML element.
	 *	@param attributes is a map of attributes where the key for a given map entry is the attribute
	 *	name and the value for the same map entry is the attribute value.
	 *	@see #endElement
	 */
	this.startElement = function (name, attributes) {
		this.stack.push(name);
		var att_str = '';
		if (attributes) { // tests false if this arg is missing!
			att_str = formatAttributes(attributes);
		}
		var xml = '<' + name + att_str + '>';
		this.appendContent(xml);
	};

	/**
	 *	Adds an element with content and attributes applied.
	 *	@param name is the name of the XML element.
	 *	@param content is the element value for this XML element.
	 *	@param attributes is a map of attributes where the key for a given map entry is the attribute
	 *	name and the value for the same map entry is the attribute value.
	 *	@see #endElement
	 */
	this.addElement = function (name, content, attributes) {
		var att_str = '';
		if (attributes) { // tests false if this arg is missing!
			att_str = formatAttributes(attributes);
		}
		var xml = '';
		if (!content || content === null) {
			xml = '<' + name + att_str + '/>';
		} else {
			xml = '<' + name + att_str + '>' + escapeXMLValue(content, false) + '</' + name + '>';
		}
		this.appendContent(xml);
	};

	/**
	 *	Ends an element sequence. Uses the most recent element sequence started.
	 *	@see #startElement
	 */
	this.endElement = function () {
		var name = this.stack.pop();
		var xml = '</' + name + '>';
		this.appendContent(xml);
	};

	var APOS = "'";
	var QUOTE = '"';
	var AMP = '&';
	var LESS_THAN = '<';
	var GREATER_THAN = '>';
	var ESCAPED_CHAR = {};
	ESCAPED_CHAR[QUOTE] = '&quot;';
	ESCAPED_CHAR[APOS] = '&apos;';
	ESCAPED_CHAR[AMP] = '&amp;';
	ESCAPED_CHAR[LESS_THAN] = '&lt;';
	ESCAPED_CHAR[GREATER_THAN] = '&gt;';
	var escapeAPOS = new RegExp(APOS, 'g');
	var escapeQUOTE = new RegExp(QUOTE, 'g');
	var escapeAMP = new RegExp(AMP, 'g');
	var escapeLESS_THAN = new RegExp(LESS_THAN, 'g');
	var escapeGREATER_THAN = new RegExp(GREATER_THAN, 'g');
	/*
		Format a dictionary of attributes into a string suitable
		for inserting into the start tag of an element.  Be smart
		about escaping embedded quotes in the attribute values.
	*/
	function formatAttributes(attributes) {
		var att_value;
		var apos_pos, quot_pos;
		var use_quote, escape, quote_to_escape;
		var att_str;
		var re;
		var result = '';

		for (var att in attributes) {
			att_value = attributes[att];

			// Find first quote marks if any
			apos_pos = att_value.indexOf(APOS);
			quot_pos = att_value.indexOf(QUOTE);

			// Determine which quote type to use around 
			// the attribute value
			if (apos_pos == -1 && quot_pos == -1) {
				att_str = ' ' + att + '="' + att_value + '"';
				result += att_str;
				continue;
			}

			// Prefer the single quote unless forced to use double
			if (quot_pos != -1 && quot_pos < apos_pos) {
				use_quote = APOS;
			} else {
				use_quote = QUOTE;
			}

			// Figure out which kind of quote to escape
			// Use nice dictionary instead of yucky if-else nests
			escape = ESCAPED_CHAR[use_quote];

			// Escape only the right kind of quote
			re = new RegExp(use_quote, 'g');
			att_value = att_value.replace(re, escape);
			att_str = ' ' + att + '=' + use_quote +
				escapeXMLValue(att_value, true) + use_quote;
			result += att_str;
		}
		return result;
	}
	/**
		Escapes XML special characters per dictionary.
	*/
	function escapeXMLValue(xmlValue, isAttribute) {
		if (typeof xmlValue != "string")
			return xmlValue;
		// This needs to be first otherwise we will replace escape sequences.
		xmlValue = searchAndEscape(xmlValue, escapeAMP, AMP);
		if (!isAttribute) {
			xmlValue = searchAndEscape(xmlValue, escapeAPOS, APOS);
			xmlValue = searchAndEscape(xmlValue, escapeQUOTE, QUOTE);
		}
		xmlValue = searchAndEscape(xmlValue, escapeLESS_THAN, LESS_THAN);
		xmlValue = searchAndEscape(xmlValue, escapeGREATER_THAN, GREATER_THAN);
		return xmlValue;
	}

	function searchAndEscape(xmlValue, regEx, search) {
		return xmlValue.replace(regEx, ESCAPED_CHAR[search]);
	}
};

/**
 * Constructs a new PerfObject object.
 * @constructor
 * @param unitOfWork is a unit of work label to associate with the elapse time
 * @class The PerfObject class provides support for measuring the elapse time
 * for a given unit of work.
 * @return A new PerfObject instance
 */
ap.PerfObject = function (unitOfWork) {
	/**
	 *	The <code>unitOfWork</code> field contains the unit of work label relating to this instance.
	 *	@type String
	 */
	this.unitOfWork = unitOfWork;
	/**
	 *	The <code>startTime</code> field contains the start time reading at the point this instance
	 *	was started (or constructed).
	 *	@type Date
	 */
	this.startTime = null;
	/**
	 *	The <code>stopTime</code> field contains the stop time taken at the point this instance
	 *	was stopped.
	 *	@type Date
	 */
	this.stopTime = null;
	/**
	 *	Reads the clock and stores it as the start time.
	 */
	this.start = function () {
		this.startTime = new Date();
		this.stopTime = null;
	};
	this.start();
	/**
	 *	Computes and returns the elapse time in milliseconds.
	 *	@return the elapse time.
	 *	@type Number
	 */
	this.getElapseTime = function () {
		var stopMillis = this.stopTime.getTime();
		var startMillis = this.startTime.getTime();
		return stopMillis - startMillis;
	};
	/**
	 *	Reads the clock and stores it as the stop time.
	 */
	this.stop = function () {
		this.stopTime = new Date();
	};
	/**
	 *	Creates a string representation of the unit of work and the elapse time.
	 *	@return a string representation of the unit of work and the elapse time.
	 *	@type String
	 */
	this.print = function () {
		return this.unitOfWork + " took " + this.getElapseTime() + "ms";
	};
};

/**
 * Constructs a new PerfCollector object.
 * @constructor
 * @class The PerfCollector class is a container for a bunch of PerfObject instances.
 * @return A new PerfCollector instance
 */
ap.PerfCollector = function () {
	/**
	 *	The <code>perfObjects</code> field is a collection of PerObject instances.
	 *	@type Array
	 */
	this.perfObjects = [];

	/**
	 *	Adds a performance object to this collector instance.
	 *	@param perfObject is the performance object to add
	 */
	this.add = function (perfObject) {
		this.perfObjects.push(perfObject);
	};

	/**
	 *	Empties this collector of all existing performance objects.
	 */
	this.clear = function () {
		this.perfObjects.splice(0, this.perfObjects.length);
	};

	/**
	 *	Creates a string representation of all of the performance objects currently
	 *   held by this instance.
	 *	@return a string representation of all of the performance objects currently
	 *   held by this instance.
	 *	@type String
	 */
	this.print = function () {
		var printablePerfObjects = '';
		for (var ix = 0; ix < this.perfObjects.length; ix++) {
			var perfObject = this.perfObjects[ix];
			printablePerfObjects += perfObject.print();
			printablePerfObjects += "; \n";
		}
		return printablePerfObjects;
	};
};

// Singleton instance performance object collector
ap.perfCollector = new ap.PerfCollector();

/**
 * Constructs a new APJSLogger object.
 * @constructor
 * @class The APJSLogger class provides a way to log events to the debugger's specific debug console whether
 * it be Firebug or IE's console.
 * @return A new APJSLogger instance
 */
ap.APJSLogger = function (string) {
	/**
	 *	The <code>silent</code> field is turned on if and only if the AgencyPortal debug console
	 *	is engaged.
	 *	@type Boolean
	 */
	this.silent = true;
	/**
	 *	The <code>logTo</code> field contains the destination of where this logger will log to.
	 *	@type String
	 */
	this.logTo = null;

	try {
		if (console)
			this.logTo = 'console';
	} catch (e) {}

	try {
		if (Debug)
			this.logTo = 'Debug';
	} catch (e) {}

	try {
		if (opera)
			this.logTo = 'opera';
	} catch (e) {}

	function prependTimeStamp(string) {
		var date = new Date();
		return date.toString() + ' ' + string;
	}

	function inSilentMode() {
		try {
			if (debugConsole !== undefined)
				return false;
		} catch (e) {
			return true;
		}
	}

	/**
	 *	Logs a string to the debugger console.
	 *	@param string is the information to log
	 */
	this.log = function (string) {
		string = prependTimeStamp(string);
		if (this.logTo == 'console')
			console.log(string);
		else if (this.logTo == 'Debug')
			Debug.write(string);
		else if (this.logTo == 'opera')
			opera.postError(string);
	};
	/**
	 *	Logs a string to the debugger console. The only difference between this
	 *	and the method log() is only evident under Firebug.
	 *	@param string is the information to log
	 */
	this.info = function (string) {
		if (inSilentMode())
			return;
		if (this.logTo == 'console') {
			string = prependTimeStamp(string);
			console.info(string);
		} else
			this.log(string);
	};
	/**
	 *	Logs a string to the debugger console. The only difference between this
	 *	and the method log() is only evident under Firebug.
	 *	@param string is the information to log
	 */
	this.warn = function (string) {
		if (this.logTo == 'console') {
			string = prependTimeStamp(string);
			console.warn(string);
		} else
			this.log(string);
	};
	/**
	 *	Logs a string to the debugger console. The only difference between this
	 *	and the method log() is only evident under Firebug.
	 *	@param string is the information to log
	 */
	this.error = function (string) {
		if (this.logTo == 'console') {
			string = prependTimeStamp(string);
			console.error(string);
		} else
			this.log(string);
	};
};
/**
 *	apJSLogger is the singleton logger which can be used by applications.
 */
ap.apJSLogger = new ap.APJSLogger();
/**
 *	This is a free floating function wrapper around a call to APSJLogger.info()
 *	@param line is the information to log
 */
ap.consoleInfo = function (line) {
	ap.apJSLogger.info(line + '\n');
};
/**
 *	This is a free floating function wrapper around a call to APSJLogger.warn()
 *	@param line is the information to log
 */
ap.consoleWarn = function (line) {
	ap.apJSLogger.warn(line + '\n');
};
/**
 *	This is a free floating function wrapper around a call to APSJLogger.error()
 *	@param line is the information to log
 */
ap.consoleError = function (line) {
	ap.apJSLogger.error(line + '\n');
};

/**
 * For every occurrence of ${n} in the template string passed, the value of arguments[n + 1] is substituted.
 * @param {template} is the template string containing the ${n} variables.
 * @returns the template string with all variables replaced.
 * @type String
 */
ap.applyPositionalVariableSubstitutions = function (template) {
	for (var parameter = 1; parameter < arguments.length; parameter++) {
		var index = parameter - 1;
		var substitution = "${" + index + "}";
		template = template.replace(substitution, arguments[parameter]);
	}
	return template;
};


/**
 * HTML encodes a string.
 * @param {input} is the string value to encode.
 * @returns the input string encoded
 * @type String
 */
ap.htmlEncode = function (input) {
	if (input === null || input.length === 0)
		return input;
	var t = document.createTextNode(input);
	var e = document.createElement('div');
	e.appendChild(t);
	return e.innerHTML;
};

/**
 * HTML decodes a string.
 * @param {input} is the string value to decode.
 * @returns the input string decoded
 * @type String
 */
ap.htmlDecode = function (input) {
	if (input === null || input.length === 0)
		return input;
	var e = document.createElement('div');
	e.innerHTML = input;
	return e.childNodes[0].nodeValue;
};

/**
 * AP function to support special chars in ID names. 
 * @returns the jquery object for the given elementId
 */
ap.getElementById = function (elementId){
	
	// First off - global replace of &amp; with the & as jquery selectors dont like &amp;.
	var sanitizedElementId = elementId.replace(/&amp;/gi,'&') ;
	
	return $("input[id=\""+sanitizedElementId+"\"]");
};


ap.registerEvent = function (element, eventType, event, label) {
	ap.unregisterEvent(element, eventType, event);
	return $(element).on(eventType,event);
};

ap.unregisterEvent = function (element, eventType, event) {
	$(element).off(eventType,event);
};
/**
 * Event Transfer from object to another object. 
 * This is used in cases of low level dom manipulation such as an IPDTR
 * content refresh on a select list where the old dom is 
 * destroyed and new one insterted. 
 * In such cases, we need to capure all evens on the from 
 * object and transfer over to the to object.
 */
ap.transferEvents = function(from, to){
	
	/*
	 * http://blog.jquery.com/2011/11/08/building-a-slimmer-jquery/
	 * This is an internal JQuery datastructure, if this changes 
	 * in a later version, we may have issues.
	 */ 
	var events = $._data(from,"events");
	if(events){
		for (var event in events) {
			var handlers = events[event];
			handlers.map(function(eventHandler){
				$(to).on(eventHandler.type,eventHandler.handler);
			});	
		}
	}
	$(from).off();
};


ap.pleaseWaitLB = function(show){
	if(show === undefined){
		$('#lb_please_wait').modal('toggle');
	}else{
		if(show){
			$('#lb_please_wait').modal('show');
		}else{
			$('#lb_please_wait').modal('hide');
		}
	}
};

/**
 * cancel pop over on an anchor tag. 
 */
ap.cancelPopover = function( datapath  ){
	
	$('a[data-path="'+datapath+'"]').popover('hide');
 
};

/**
 * A generic pop over close function.
 * given the id of the field, invokes the hide on the popover registered  
 */
ap.closePopover = function ( id ) {
	$('#'+id).popover('hide');
};

/*
 * Adapter for jquery effects
 */
ap.Effects = function(){	
};

ap.Effects.highlight = function(field){

	var $field = $(field);
	
	$field.addClass('animated fadeIn');		
}; 

/*
 * Utility function to get the object keys when not supported by browser 
 * <IE9 doesn't support Object.keys function 
 */
ap.ObjectKeys = function(obj){
	if (!Object.keys) {
		Object.keys = function(obj) {
			var keys = [];
			for ( var i in obj) {
				if (obj.hasOwnProperty(i)) {
					keys.push(i);
				}
			}
			return keys;
		};
	}else{
		return Object.keys(obj);
	}
};

ap.verifyTime = function(timeString){
	if(timeString != null && timeString != ''){
		var re = /^(\d{1,2}):(\d{2})([ap]m)?$/; 
		if(regs = timeString.match(re)) { 
			if(regs[3]) {  
				if(regs[1] < 1 || regs[1] > 12) { 
					return false;
				} 
			} else {
				if(regs[1] > 23) { 
					return false; 
				} 
			} 
			if(regs[2] > 59) { 
				return false; 
			} 
		}
	}
	return true;
};