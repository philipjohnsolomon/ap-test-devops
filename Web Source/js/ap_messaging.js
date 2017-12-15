/**
 * @fileoverview This file contains the JavaScript class for the
 *  AgencyPortal messaging support.
 * @author Norm Baker nbaker@sword-agencyport.com
 */

/**
 * Construct a new Message object.
 * @constructor
 * @class The Message class builds a message instance..
 * @param type is the type of message as in error, warning, informational
 * @param message is the message text.
 * @param cssStyleClass is the CSS style class.
 * @param heading is the heading text.
 */
function Message(type, message, cssStyleClass, heading) {
	/**
	 * The <code>type</code> is the message type as in error, warning, or informational.
	 */
	this.type = type;
	/**
	 * The <code>message</code> is the message text of the message.
	 */
	this.message = message;
	/**
	 * The <code>cssStyleClass</code> is the CSS style class of this message.
	 */
	this.cssStyleClass = cssStyleClass;
	/**
	 * The <code>heading</code> is the heading text.
	 */
	this.heading = heading;
	/** 
	 * The <code>timeout</code> represents the time when this message can be cleared from the map.
	 */
	this.timeout = (new Date()).valueOf() + 10000; // minimum 10 seconds on screen
	/**
	 *	Returns the type of this message.
	 *	@return the type of this message.
	 *	@type String
	 */
	this.getType = function () {
		return this.type;
	};
	/**
	 *	Returns the message text for this message.
	 *	@return the message text for this message.
	 *	@type String
	 */
	this.getMessageText = function () {
		return this.message;
	};
	/**
	 *	Returns the CSS style class for this message.
	 *	@return the CSS style class for this message.
	 *	@type String
	 */
	this.getCSSStyleClass = function () {
		return this.cssStyleClass;
	};
	/**
	 *	Returns the heading for this message.
	 *	@return the heading for this message.
	 *	@type String
	 */
	this.getHeadingText = function () {
		return this.heading;
	};
	/**
	 *  Resets the message timeout
	 */
	this.resetTimeout = function (duration) {
		this.timeout = (new Date()).valueOf() + duration.valueOf();
	};
}
ap.Message = Message;

/**
 * Construct a new MessageMap object.
 * @constructor
 * @class The MessageMap class serves as the container for messages and handles the HTML updates.
 * @param parentDivId is the id of the parent HTML div.
 * @param msgIdBase is the beginning character sequence common to all of the alert messages on this
 * instance. Each message map instance needs a unique id base.
 */
function MessageMap(parentDivId, msgIdBase) {
	/**
	 * The <code>messageMap</code> is the map of messages. Each type of message is held in its own array.
	 */
	this.messageMap = {};

	/**
	 * The <code>uniqueMessageStyles</code> contains all of the unique CSS styles.
	 */
	this.uniqueMessageStyles = new Array();

	/**
	 * The <code>alertDivParentId</code> is the parent node id to which all append and remove operations
	 * are targeted.
	 */
	this.alertDivParentId = parentDivId;

	/**
	 * The <code>msgIdBase</code> is the sequence of characters making up the id base or prefix. Each instance
	 * needs a unique message id basis.
	 */
	this.msgIdBase = msgIdBase;

	/** 
	 * The <code>msgTimeout</code> is the minimum duration that a message will be left in the message map.
	 * The message will be retained until the first time clear() is executed after the timeout is reached.
	 */
	this.msgTimeout = 10000;

	/**
	 *	Adds a message.
	 *	@param message is the message to end.
	 */
	this.addMessage = function (message) {
		var msgArray = this.messageMap[message.getType()];
		if (msgArray === undefined) {
			msgArray = new Array();
			this.messageMap[message.getType()] = msgArray;
		}
		msgArray.push(message);
		message.resetTimeout(this.msgTimeout);
		var cssStyleAlreadyRegister = false;
		var searchCSSStyle = message.getCSSStyleClass();
		for (var ix = 0; ix < this.uniqueMessageStyles.length && cssStyleAlreadyRegister == false; ix++) {
			if (this.uniqueMessageStyles[ix] == searchCSSStyle)
				cssStyleAlreadyRegister = true;
		}
		if (!cssStyleAlreadyRegister)
			this.uniqueMessageStyles.push(searchCSSStyle);
	};

	/**
	 *	Determines if the incoming parameter is an Array object or not.
	 */
	function isArray(arrayCandidate) {
		return typeof arrayCandidate == 'object' && arrayCandidate.constructor == Array;

	}


	/**
	 *	Clears all messages of all types from the current message map collection.
	 */
	this.clear = function () {
		var currentTime = (new Date()).valueOf();
		for (var msgArrayKey in this.messageMap) {
			var msgArray = this.messageMap[msgArrayKey];
			if (isArray(msgArray)) {
				for (var i = 0; i < msgArray.length;) {
					var msg = msgArray[i];
					if (currentTime > msg.timeout) {
						msgArray.splice(i, 1);
					} else {
						i++;
					}
				}
			}
		}
	};

	/**
	*  Generates an alert div element based upon the type of messages contained in the msg array.
	*  @param msgArray is an array of messages assumed to contain messages each with the same type.
	*/
	this.generateAlertDiv = function(msgArray){
		if ( msgArray.length == 0 ) {
			return null;
		}
			
		var message = msgArray[0];
		var alertDiv = $("<div>", {
			id: this.msgIdBase + message.getCSSStyleClass()
		});
		alertDiv.addClass('alert');
		alertDiv.addClass(message.getCSSStyleClass());

		var headingText = message.getHeadingText();
		if ( headingText.length > 0  ) {
			$("<h4>", {
				text: headingText
			}).attr('class', message.getCSSStyleClass()).appendTo(alertDiv);
			
			$("<i class='fa' />").appendTo(alertDiv);
		}
		for (var ix = 0; ix < msgArray.length; ix++) {
			message = msgArray[ix];
			$("<p>", {
				text: message.getMessageText()
			}).appendTo(alertDiv);
		}
		return alertDiv;
	};

	/**
	 *  Removes an alert div using is style class to access the node.
	 *  @param cssStyle is the CSS style of the alert node.
	 */
	this.removeAlert = function (cssStyle) {
		$("#" + this.msgIdBase + cssStyle).remove();
	};
	/**
	 *  Removes all of the alerts currently present on the page and removes
	 *  all of the messages in the internal message map.
	 */
	this.removeAlerts = function () {
		for (var ix = 0; ix < this.uniqueMessageStyles.length; ix++) {
			this.removeAlert(this.uniqueMessageStyles[ix]);
		}
		this.clear();
	};

	/**
	 * Transfers the messaging currently held in the message map to DOM elements and
	 * inserts them into the proper parent div.
	 */
	this.render = function () {
		var alertDiv;
		for (var msgArrayKey in this.messageMap) {
			var msgArray = this.messageMap[msgArrayKey];
			if (isArray(msgArray)) {
				alertDiv = this.generateAlertDiv(msgArray);
				if (alertDiv != null) {
					$('#' + this.alertDivParentId).append(alertDiv).fadeIn();
				}
			}
		}
	};
}
ap.MessageMap = MessageMap;
/**
 * The <code>initialDisplayMessageMap</code> contains the messages from the initial display of the web page.
 */
var initialDisplayMessageMap = new ap.MessageMap('initialDisplayMessages', 'alert_');
/**
 * The <code>ajaxMessageMap</code> contains the messages from various Ajax calls.
 */
var ajaxMessageMap = new ap.MessageMap('ajaxMessages', 'alert_ajax_');
ap.initialDisplayMessageMap = initialDisplayMessageMap;
ap.ajaxMessageMap = ajaxMessageMap;