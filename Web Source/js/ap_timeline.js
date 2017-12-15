/**
* Declare namespace if there is none.
*/
if ( typeof(ap) === 'undefined' ) {
   ap = {};
}

/**
 * Timeline is the base class for the Timeline feature.
 */
ap.Timeline = function() {
	
	/**
	 * The <code>timelineURL</code> is the base URL for Timeline operations.
	 */
	this.timelineURL = "FrontServlet";

	/**
	 * The <code>auditId</code> is the current audit id.
	 */
	this.auditId = null;

	/**
	 * The <code>transactionName</code> is the transaction id.
	 */
	this.transactionName = null;
	
	/**
	 * The <code>pageName</code> is the current page id.
	 */
	this.pageName = null;
		
	/**
	 * The <code>workItemId</code> is the current work item id.
	 */
	this.workItemId = null;
	
	/**
	 *  The <code>timelineShown</code> is a flag that indicates if Timeline is shown or not.
	 */
	this.timelineShown = false;
	
	/**
	 *  The <code>currentEventType</code> is the event type  shown
	 */
	this.currentEventType = "";
	
	/**
	 * The <code>csrfToken</code> is the CSRF token to apply to any AJAX call to FrontServlet.
	 */
	this.csrfToken = null;
	
	/**
	 * display Timeline
	 * @param transactionId is the id of the transaction
	 * @param pageId is the id of the page
	 * @param workItemId is the id of the work item
	 */
	this.displayTimeline  = function(transactionId, pageId, workItemId, csrfToken){

		$("#timeline_dialog").modal('show');
		this.transactionName = transactionId;
		this.pageName = pageId;
		this.workItemId = workItemId;
		this.csrfToken = csrfToken;
		this.loadEvents();	
		this.registerTabHandlers();
		
	};
		
	/**
	 * Make an Ajax request given the HTTP method, action.
	 *
	 * @param eventId is the id of the event
	 */
	this.loadEvents = function(){

		var ajaxReqParams = {};
		ajaxReqParams.WORKITEMID = this.workItemId;
		ajaxReqParams.TRANSACTION_NAME = this.transactionName;
		ajaxReqParams.PAGE_NAME = this.pageName;
		ajaxReqParams.NEXT =   'Timeline';
		ajaxReqParams.METHOD = 'Process';
		ajaxReqParams.ACTION = "Timeline";
		ajaxReqParams.TIMELINE_ACTION= 'listEvent';
		ajaxReqParams.CSRF_TOKEN = this.csrfToken;
		
		$.ajax({
			type: 'POST',
			url: this.timelineURL,
			data: ajaxReqParams
		}).done($.proxy(function (response, textStatus, jqXHR ){
			var data = $.trim(response);
			$('#event-list').html(data);
			this.registerEventHandlers();
			this.showDetail(0);
		},this)).fail($.proxy(function(jqXHR, textStatus, errorThrown) {
			this.updateFailure(errorThrown);
		},this));	
	};
	
	/**
	 * register tab handlers
	 */
	this.registerTabHandlers = function(){
		
		var dataContainers = ['timeline_event_summary','timeline_change_summary','timeline_work_item_data'];		
		$("#timeline-tabs").find("a").each(				
			function (item) {			
				var tabId = $(this).attr("id");	
				$(this).unbind();				
				$(this).bind('click', function(){
					for(var i = 0; i  < dataContainers.length; i++){
						ap.timeline.show($('#' + dataContainers[i]), (tabId.indexOf(dataContainers[i]) >  0));
					}
				});
			}
		);		
	};
	
	/**
	 * show and hide elements
	 */
	this.show = function(elm, show){
		if(elm){
			if(show){
				elm.show();
			}else{
				elm.hide();
			}
		}
	};
	
	/**
	 * register event handlers for events
	 */
	this.registerEventHandlers = function(){
		$("#timeline_event_list").find("a").each(
			function (item) {
				var eventId = $(this).attr("id").split('_');					
				$(this).bind('click', function(){
					ap.timeline.showDetail(eventId[2]);
			});
		});		
	};
	
	/**
	 * Make an Ajax request given the HTTP method, action.
	 *
	 * @param eventId is the id of the event
	 */
	this.showDetail = function(eventId){
		
		if(eventId != this.auditId){	
			
			var ajaxReqParams = {};
			ajaxReqParams.WORKITEMID = this.workItemId;
			ajaxReqParams.TRANSACTION_NAME = this.transactionName;
			ajaxReqParams.PAGE_NAME = this.pageName;
			ajaxReqParams.NEXT =   'Timeline';
			ajaxReqParams.METHOD = 'Process';
			ajaxReqParams.ACTION = "Timeline";
			ajaxReqParams.AUDITID= eventId;
			ajaxReqParams.TIMELINE_ACTION= 'showDetail';
			ajaxReqParams.CSRF_TOKEN = this.csrfToken;

			$.ajax({
				type: 'POST',
				url: this.timelineURL,
				data: ajaxReqParams
			}).done($.proxy(function (response, textStatus, jqXHR ){
				
				this.updateDetails(response);
				$('#timeline_event_list li.active').each(function( index, element ) {
					$(this).removeClass('active');
				});
				
				var selected = $("#timeline_event_"+ eventId);
				if(selected.length >   0){
					selected.addClass('active');
				}else{
					$('#timeline_event_list li').first().addClass('active');
				}
				
				this.auditId = eventId;
				
			},this)).fail($.proxy(function(jqXHR, textStatus, errorThrown) {
				this.updateFailure(errorThrown);
			},this));	
		}
	};

	this.updateDetails = function (response){
		
		var data = $.trim(response);
		$('#timeline_event_detail').empty();
		$('#timeline_event_detail').html(data);

		if(!$("#tab_timeline_event_summary").hasClass('active')){
			$("#tab_timeline_event_summary").addClass('active');
		}
		$("#tab_timeline_work_item_data").removeClass('active');
		$("#tab_timeline_change_summary").removeClass('active');
		
		//show/hide tab
		var changeSummary = $('#timeline_event_detail').find('#timeline_change_summary');
		if(changeSummary.length > 0){
			changeSummary.hide();
			$('#tab_timeline_change_summary').show();
		}else{
			$('#tab_timeline_change_summary').hide();
		}
		
		var snapShotData = $('#timeline_event_detail').find('#timeline_work_item_data');
		if(snapShotData.length  > 0){
			snapShotData.hide();
			$('#tab_timeline_work_item_data').show();
		}else{
			$('#tab_timeline_work_item_data').hide();
		}
	};
	
	/**
	 * Handle onFailure errors
	 */
	this.updateFailure = function(response) {
		var errorMessage = updateStatus.getHeader('ERRORS_MESSAGE');
		if(!errorMessage){
			alert(errorMessage);
		}
	};
};

$(function () {
    ap.timeline = new ap.Timeline();
});