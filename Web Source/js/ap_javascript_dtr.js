/**
 * @fileoverview This file contains the JavaScript class for the
 *  AgencyPortal IntraPage DTR support.
 * @requires ap_javascript_base.js Contains functions used by the objects specified within this script
 * @requires ap_javascript_objects.js Contains functions used by the objects specified within this script
 * @author Norm Baker nbaker@agencyport.com
 * @version 0.2
 */
// servlet end point name of intrapage dtr servlet
ap.intraPageDtrURL = "IntrapageDTRServlet";
/**
*	Array to remember fields which have triggered an intra page DTR request whilst
*	an IPDTR call was currently in flight. We can only process one IPDTR request
*	at a single time so this is used to hold on to the Field instances that triggered
*	an IPDTR call while one was already in progress.
*/
ap.pendingIntraPageDTRRequests = new Array();

/** A (field, value) pair used in the pendingIntraPageDTRRequests queue.
 *  Saving the field value at this point keeps IPDTR processing in sync
 *  even if the user is toggling field values.
 * @param origin is the field whose IPDTR call is queued
 */
ap.QueuedIntraPageDTRRequest = function(origin) {
	origin.setAnalyticsFieldData('isPendingIPDTR', true);
	this.origin = origin;
	var analyticsFieldValue = origin.getValue();
	if(origin.isFilterListType()){
		analyticsFieldValue = ap.htmlDecode(analyticsFieldValue);
	}

	this.dequeue = function() {
		if (!pendingIntraPageDTRRequestExists(this.origin)) {
			this.origin.setAnalyticsFieldData('isPendingIPDTR', false);
		}
		this.origin.setAnalyticsFieldData('analyticsFieldValue', analyticsFieldValue);
	};
	
	function pendingIntraPageDTRRequestExists(field) {
		for (var ix = 0; ix < ap.pendingIntraPageDTRRequests.length; ix++ ) {
			var pendingField = ap.pendingIntraPageDTRRequests[ix].origin;
			if (field.uniqueId == pendingField.uniqueId) {
				return true;
			}
		}
		
		return false;
	}
};

/**
 * Factory method for creating an IntraPageDTRRequest. This will only
 * dispense one instance out at a time and will not dispense out another
 * one until the previous one has finished regardless of how it finished.
 * @param transaction is a reference to the Transaction object
 * @param page is a reference to the Page object
 * @param origin is a reference to the Field object which triggered the event
 * @return a new IntrapageDTRRequest or null if a request is still in flight.
 * @type IntrapageDTRRequest
*/
ap.createDTRRequest = function (transaction, page, origin){
	if (!window.IPDTRBlockDataEntry) {
		if(origin.blockDataEntry) {
			ap.page.pleaseWait(false);
			ap.pleaseWaitLB(true);
			window.IPDTRBlockDataEntry = true;
		}
		else {
			ap.page.pleaseWait(true);
			$.each($(page.form.id).find('.buttons'),function(index,button) {
				  button.addClass('ipdtr_inprogress');
			});
		}
	}

	if ( ap.intrapageDTRRequestInProgress ) {
		// Take note of this field. It will be processed as soon as the current in flight
		// IPDTR call has finished (meaning when the ap.intrapageDTRRequestInProgress flag is turned
		// off).
		//prevent the same field from entering the queue right away.
		if(ap.intrapageDTRRequestOrigin == null || (ap.intrapageDTRRequestOrigin.uniqueId != origin.uniqueId)){
			ap.pendingIntraPageDTRRequests.push(new ap.QueuedIntraPageDTRRequest(origin));
		}else if (ap.intrapageDTRRequestOrigin.uniqueId == origin.uniqueId){
			ap.consoleInfo("*Field " + origin.uniqueId + " is waiting to be placed in the tdr queue.");
			setTimeout(function() {
				ap.pendingIntraPageDTRRequests.push(new ap.QueuedIntraPageDTRRequest(origin));
			}, 2000); 
		}
		return null;
	}
	var value = origin.getValue();
	if(origin.isFilterListType()){
		value = ap.htmlDecode(value);
	}
	origin.setAnalyticsFieldData('analyticsFieldValue', value);
	return new ap.IntrapageDTRRequest(transaction, page, origin);
};

// maxSimultaneousRequests sets the threshold after which IPDTR will automatically block data entry
ap.maximumSimultaneousIPDTRRequests = 5;

//the current hot field
ap.intrapageDTRRequestOrigin = null;

/**
 * Construct a new IntrapageDTRRequest object.
 * @constructor
 * @class The IntrapageDTRRequest class builds an intrapage dtr request to be sent to the server via AJAX.
 * @param transaction is a reference to the Transaction object
 * @param page is a reference to the Page object
 * @param origin is a reference to the Field object which triggered the event
 */
ap.IntrapageDTRRequest = function (transaction, page, origin){

	// declared in ap_javascript_objects.js
	ap.intrapageDTRRequestInProgress = true;
	ap.intrapageDTRRequestOrigin = origin;
	ap.perfCollector.clear();
	var xmlAssemblyTime = new ap.PerfObject("IntraPage DTR XML assembly");
	ap.perfCollector.add(xmlAssemblyTime);
	var xmlWriter = new ap.XMLWriter();
	xmlWriter.startElement('intraPageDTRRequest');
	xmlWriter.addElement('workItemId', transaction.workItemId);
	var fields = page.getFieldsForSendToIntrapageDTR();
	for (var ix = 0; ix < fields.length; ix++ ) {
		var field = fields[ix];
		var attributes = {  };
		var value = field.getValue();
		if(field.isFilterListType()){
			value = ap.htmlDecode(value);
		}

		attributes['uniqueId'] = field.getTdfId();
		var interestLevelValue = field.getNormalizedInterestLevelValue();
		
		//These fields are excluded in previous request, their InterestLevel should be set to Included so that
		//IntraPageDTRBehaviorManager can take these fields into account as preconditions.
		if(field.getIsHot() && page.form.getFieldByUniqueId(field.getUniqueId()) == null){
			interestLevelValue = ap.constants.InterestLevel.INTEREST_LEVEL_INCLUDE;
		}
		
		attributes['interestLevel'] = new String(interestLevelValue);
		var relativePosition = field.getRelativePosition();
		attributes['pos'] = new String(relativePosition);
		if ( field == origin )
			attributes['isOrigin'] = new String('true');
		if ( field.getIsHot() )
			attributes['isHot'] = new String('true');
		xmlWriter.addElement('fieldElement', value, attributes);
	}
	for (var ix = 0; ix < fields.length; ix++ ) {
		var field = fields[ix];
		if (field.isPendingIPDTR()) { 
			var analytics_attr = {};
			analytics_attr['uniqueId'] = field.getUniqueId();
			xmlWriter.startElement('analyticsFieldData', analytics_attr);
	
			for (var dataName in field.analyticsFieldData) {
		    	var dataValue = field.analyticsFieldData[dataName];
		    	analytics_attr = {};
		    	analytics_attr['name'] = dataName;
		    	xmlWriter.addElement('attribute', dataValue, analytics_attr);
		    }
	
			xmlWriter.endElement();
		}
	}
	if ( page.getSupportsIPDTRDynamicContent()){
		var fieldSets = page.getFieldSetsForSendToIntrapageDTR();
		for (var ix = 0; ix < fieldSets.length; ix++ ) {
			var fieldSet = fieldSets[ix];
			var attributes = {  };
			attributes['uniqueId'] = fieldSet.getId();
			var interestLevelValue = fieldSet.getInterestLevel().getInterestLevelValue();
			attributes['interestLevel'] = new String(interestLevelValue);
			xmlWriter.addElement('pageElement', '', attributes);
		}
	}
	var compoundKey = page.getCompoundKey();
	var attributes = { };
	attributes['compoundKey'] = compoundKey;
	if (page.type.search('roster') > -1 )
		attributes['isRoster'] = "true";
	else
		attributes['isRoster'] = "false";
	if ( page.type == 'rosterEdit' )
		attributes['inRosterEditMode'] = "true";

	xmlWriter.addElement('page', null, attributes);
	var index = page.getIndex();
	if ( index != null ){
		xmlWriter.addElement('index', index);
	}
	xmlWriter.addElement('target', transaction.target);
	xmlWriter.endElement();

 	/**
	*	The <code>xmlRequest</code> contains the XML request body which will be delivered
	*	to the server when the send() method is invoked.
	*	@type String
	*/
	this.xmlRequest = xmlWriter.getXML();
	fields = null;
	xmlWriter = null;
	xmlAssemblyTime.stop();
	xmlAssemblyTime = null;
	//ap.consoleInfo(this.xmlRequest);
	/**
	*	Delivers the current request instance to the server's <code>IntrapageDTRServlet</code> servlet entry point.
	*/
	this.send = function(){
   		var requestTransportTime = new ap.PerfObject("Connection and HTTP Post Time");
		ap.perfCollector.add(requestTransportTime);
		if(ap.intrapageDTRRequestOrigin){
			ap.consoleInfo("sending iptdr for " + ap.intrapageDTRRequestOrigin.uniqueId);
		}
		$.ajax({
			type: 'POST',
			url: ap.intraPageDtrURL,
			contentType: 'text/xml',
			data: this.xmlRequest
		})
		.done(processResults)
		.fail(processErrors);
		requestTransportTime.stop();
	};


	/**
	*	The IPDTRJanitor performs cleanup work after ALL pending IPDTR requests have been completed.
	*	This work includes removing UI associated with waiting users, and reestablishment of tab focus
	*/

	function IPDTRJanitor() {
		ap.consoleInfo("IPDTR Janitor reporting for duty. Cleaning up now.");
		if (window.IPDTRBlockDataEntry)
			ap.pleaseWaitLB(false);
		else
			ap.page.pleaseWait(false);

		$.each($(page.form.id).find('.buttons'),function(index,button) {
			  $(button).removeClass('ipdtr_inprogress');
		});

		window.IPDTRBlockDataEntry = null;
		window.setTimeout('page.setIPDTRFieldFocus()', 0);
	}

	/**
	*	Check to see if any pending requests were built up during the
	*	processing of this IPDTR call. If so we will take the next one.
	*/
	function handlePendingRequest(){
		ap.consoleInfo(ap.pendingIntraPageDTRRequests.length + " pending IPDTR requests remain");
		if ( ap.pendingIntraPageDTRRequests.length == 0 )
			IPDTRJanitor();
		else {
			if (ap.pendingIntraPageDTRRequests.length > ap.maximumSimultaneousIPDTRRequests && !window.IPDTRBlockDataEntry) {
				ap.page.pleaseWait(false);
				ap.pleaseWaitLB(true);
				window.IPDTRBlockDataEntry = true;
			}
			var nextQueuedIntraPageDTRRequest = ap.pendingIntraPageDTRRequests[0];
			var nextIntraPageDTRField = nextQueuedIntraPageDTRRequest.origin;
			ap.pendingIntraPageDTRRequests.splice(0, 1);
			nextQueuedIntraPageDTRRequest.dequeue();
			var ret = nextIntraPageDTRField.makeIntraPageDTRRequest();
			if (!ret){
				IPDTRJanitor();
			}
		}
	}


	function processResults(data, textStatus, jqXHR ){
		try {
			var responsePerfObject = new ap.PerfObject("IntraPage DTR response eval");
			ap.perfCollector.add(responsePerfObject);
    		eval(data);
			responsePerfObject.stop();
			ap.consoleInfo(ap.perfCollector.print());
 		}catch (error){
 			ap.consoleError(error);
 			alert(error.message);
		}
		ap.intrapageDTRRequestInProgress = false; // declared in ap_javascript_objects.js
		ap.intrapageDTRRequestOrigin = null;
		handlePendingRequest();
	}
	
	function processErrors(jqXHR, textStatus, errorThrown){
		var errMsg = "Connection to server failed. Status Code: " +
			jqXHR.status + ", Status Text: '" +  textStatus
				+ "'";
			ap.consoleError(errMsg + " Error: " + errorThrown);
			alert(errMsg);
		ap.intrapageDTRRequestInProgress = false; // declared in ap_javascript_objects.js
		ap.intrapageDTRRequestOrigin = null;
		handlePendingRequest();
	}
};
