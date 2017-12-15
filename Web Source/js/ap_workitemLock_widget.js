/**
 * @fileoverview This file contains the AgencyPort WorkItem Record Lock manager widget
 * 
 */

/**
 * Declare namespace if there is none.
 */
var ap = ap || {};


/**
 * Agencyport Workitem Lock widget manager.  
 */
ap.WorkItemLockWidget = function (workItemId, transactionName, pageName, updateInterval, csrfToken, page) {
	
	this.updateInterval = updateInterval * 1000; // converting to seconds. 
	this.workItemId = workItemId;
	this.transactionName = transactionName;
	this.pageName = pageName; 
	this.csrfToken = csrfToken;
	this.page = page;
	
	this.acquireLock = function ( ) {

		var page = this.page;
		if(!page){
			page = ap.page;
		}
		if(page && page.shouldSendUpdate() == false){
			ap.consoleInfo('Idle too long. Work item locking stops.');
			return;
		}
		
		var params = {};
		params.WORKITEMID = this.workItemId;
		params.TRANSACTION_NAME = this.transactionName;
		params.PAGE_NAME = this.pageName;
		params.NEXT = 'WorkItemLock';
		params.METHOD = 'Process';
		params.CSRF_TOKEN = this.csrfToken;
		
		var $self = this;
		
   		var requestTransportTime = new ap.PerfObject("WorkItem Lock HTTP Post Time");
		ap.perfCollector.add(requestTransportTime);
		$.ajax({
			type: 'POST',
			url: 'FrontServlet',
			data: params
		})
		.done( function(response) {
			ap.consoleInfo('WorkItem locking success.');
		})
		.fail(function(response) {
			ap.consoleInfo('WorkItem locking error.');
		})
		.always(function(response) {
			ap.consoleInfo('WorkItem locking completed.');
			//Schedule the next class to update workitem lock
			setTimeout(function(){$self.acquireLock();}, $self.updateInterval);
		});
		requestTransportTime.stop();	
	};

};