/**
 * @fileoverview This file contains the AgencyPort Account.
 */

/**
* Declare namespace if there is none.
*/
if ( typeof(ap) === 'undefined' ) {
   ap = {};
}
/**
 * Account is the base class for the Account.
 */
ap.Account = function() {
	
	/**
	 * The <code>ACTIONS</code> is the types of account operations.
	 */
	var ACTIONS = { 
		 NONE:0,
		 DELETE_ACCOUNT:1,
		 DISPLAY_ROSTER:2,
		 DISPLAY_EDIT:3,
		 DELETE_ROSTER:4,
		 UPDATE_ROSTER:5,
		 SEARCH_ACCOUNT:6,
		 GET_ACCOUNT_WORKITEM:7,
		 MOVE_WORKITEM:8,
		 MERGE_ACCOUNT:9,
		 AUTO_SEARCH:10
	};
	
	var PAGES = {
		LOCATION: 'location',
		PEOPLE: 'people'
	};
	
	var ACCOUNT_TYPES = {
		PERSONAL:'P',
		COMMERCIAL:'C'
	};
	
	/**
	 * The <code>accountURL</code> is the base URL for account operations.
	 */
	this.accountURL = "FrontServlet";

	/**
	 * The <code>workItemActionURL</code> is the base URL for account delete operations.
	 */
	this.workItemActionURL ="WorkItemAction";
	
	/**
	 * The <code>autosearchProviderURL</code> is the base URL for account search auto completion.
	 */
	this.autosearchProviderURL = "AccountSearchServlet?type=AUTOSEARCH";
	
	
	/**
	 * The <code>searchProviderURL</code> is the base URL for account search.
	 */
	this.searchProviderURL = "AccountSearchServlet?type=SEARCH";
	
	
	/**
	 * The <code>accountId</code> is the current account id.
	 */
	this.accountId = null;

	/**
	 * The <code>accountId</code> is the current account id.
	 */
	this.accountNumber = null;

	
	/**
	 * The <code>srcAccountId</code> is the source account id.
	 */
	this.srcAccountId = null;
	

	/**
	 * The <code>transactionName</code> is the current transaction name.
	 */
	this.transactionName = null;

	/**
	 * The <code>locationFields</code> is the location page fields
	 */
	this.locationFields = new Array();
	

	/**
	 * The <code>contactFields</code> is the contact page fields
	 */
	this.contactFields = new Array();
	
	/**
	 * The <code>accountHolderAddressFields</code> contains the address fields and values
	 */
	this.accountHolderAddressFields = {};
	
	/**
	 * The <code>accountDeleteTargetPage</code> is the landing page after an account is deleted.
	 */
	this.accountDeleteTargetPage ='';
	
	/**
	 * The <code>account_type</code> is the account type
	 */
	this.account_type = '';
	
	/**
	 * The <code>accountName</code> is the account name
	 */
	this.accountName = '';
	
	/**
	* The <code>recordLockStatus</code> field contains the record lock status of the current account.
	* See com.agencyport.database.locking.RecordLockStatus for valid values.
	*/
	this.recordLockStatus = '';
	
	/**
	* The <code>updateInterval</code> account lock interval
	*/
	this.updateInterval= 0;
	
	/**
	* The <code>mergeAutoSearchTip</code> help tip for auto search
	*/
	this.mergeAutoSearchTip = '';
	
	/**
	* The <code>mergeFullSearchTip</code> help tip for full search
	*/
	this.mergeFullSearchTip = '';
	
	/**
	* The <code>mergeHeadTip</code> help tip for account merge
	*/
	this.mergeHeadTip = '';
	
	/**
	* The <code>moveHeadTip</code> help tip for work item move
	*/
	this.moveHeadTip = '';
	
	/**
	* The <code>canMergeWithOtherType</code> indicate that if the account can be merged with other type or not.
	*/
	this.canMergeWithOtherType = true;
	
	/**
	* The <code>worklistTableWidth</code> is the work list table width
	*/
	this.worklistTableWidth = 0;
		    
	/**
	 * The <code>csrfToken</code> is the CSRF token to apply to any AJAX call to FrontServlet.
	 */
	this.csrfToken = null;
	
	/**
	 * The <code>accountContactInfo</code> holds account holder phones and email
	 */
	this.accountContactInfo = {
			'account_title' 	: '',
			'account_address' 	: '', 
			'phone_home'		: '',
			'phone_work'		: '',
			'phone_mobile'		: '',
			'phone_business'    : '',
			'account_email'		: ''
	};
	
	/**
	 * The <code>summaryContactsOnRoster</code> holds account holder phones and email on account holder roster page
	 */
	this.summaryContactsOnRoster = ['', '','ContactHomePhoneNumber','ContactWorkPhoneNumber',
	        'ContactMobilePhoneNumber', 'ContactBusinessPhoneNumber', 'ContactPrimaryEmailAddress'];

	/**
	 * Initialize the Account.
	 * @param accountId is the account id
	 */
	this.init = function(accountId, accountNumber, transactionId, accountType, accountName, updateInterval, csrfToken) {	
		
		this.accountId = accountId;
		this.accountNumber = accountNumber;
		this.transactionName = transactionId;
		this.accountType = accountType;
		this.accountName = accountName;
		this.updateInterval = updateInterval;
		this.csrfToken = csrfToken;
		ap.csrfToken = csrfToken;
		
		//set up the account search for work item move or account merge
		var autoSuggestionUrl = this.autosearchProviderURL + "&id=-" + this.accountId + "&sort=last_update_time desc&value=%QUERY";
		
		//Type ahead
		this.searchBox = $('#' + "move_workitem_search_input");
		
		var bloodhoundOpts = {
			datumTokenizer: function(d) {
				return [d.value];
			},
			queryTokenizer: Bloodhound.tokenizers.whitespace,
			remote: {
				url: autoSuggestionUrl,
				filter: function(parsedResponse) {
					var arr = this.renderSolrData(parsedResponse); 
					return arr;
				}.bind(this)
			}
		};
		
		this.suggestionEngine = new Bloodhound(bloodhoundOpts);
		
		//init suggestion engine
		this.suggestionEngine.initialize();
		
		this.searchBox.typeahead({
			minLength: 3,
			highlight: true,
			hint: false
		},
		{
			source: this.suggestionEngine.ttAdapter()
		})
		.on('typeahead:selected', function(event, suggestion, datasetName) {
			this.addSearchTermtoInputField(suggestion);
		}.bind(this));
		//End Type ahead		
		
		
		$.each(this.accountContactInfo,function(index,key){
			if($(key).length){
				this.accountContactInfo[key] = $(key).html();
			}
		});
		
		
		this.mergeAutoSearchTip = ap.account_management['account.actions.merge.helptip.autosearch'];		
		this.mergeFullSearchTip = ap.account_management['account.actions.merge.helptip.fullsearch'];
				
		this.mergeHeadTip = ap.account_management["account.actions.merge.account.searchAcctMergeTip"] + " <b>" + this.accountName + " #" + this.accountNumber + ".</b>";
		
		this.moveHeadTip=ap.account_management["account.actions.merge.account.searchAcctMoveTip"] + " <b>" + this.accountName + " #" + this.accountNumber + ".</b>";
		
		this.startWorkItemLock();
	};
	this.renderSolrData = function(data) {
		var arr = [];
		var searchVal = this.searchBox.val();
		// Iterate through each of the Solr results, keeping only the first four that we get.
		// All others will be ignored and we'll inform the user that there are <result size> - 4
		// more results available.
		$.each(data.response.docs, function(index, doc) {
			if(index == 4) {
				return;
			}
			var encodedName = ap.htmlEncode(doc.name);
			arr.push({ 
				value: encodedName + ap.account_management["account.management.label.accountHashTag"] + 
							doc.account_number + ((doc.account_type == 'P') ? ap.account_management["account.management.label.person"] : ap.account_management["account.management.label.company"]) 
							+ doc.creation_time,
				id: doc.id,
				name: encodedName,
				searchValue: searchVal,
				account_type: doc.account_type
			});
		});
		
		// The last entry is an indicator of how many more search hits there are if
		// there are more than 4 total.
		if(data.response.docs.length > 4) {
			ap.consoleInfo("Found " + data.response.docs.length + " solr hits.");
			
			if(data.response.docs.length == 5) { 
				arr.push({value: data.response.docs.length - 4 + " " + ap.account_management["label.account.management.other"], 
						id: ap.account_management["label.account.management.more"], name: '', searchValue: searchVal});
			}
			else {
				arr.push({value: data.response.docs.length - 4 + " " + ap.account_management["label.account.management.others"], 
						id: ap.account_management["label.account.management.more"], name: '', searchValue: searchVal});
			}
		}
		
		return arr;
	};	
	/**
	 * Sets the <code>enableWorkItemLock</code> field of this instance.
	 * @param updateInterval is a boolean denoting of WorkItem locking is supported.
	 */
	this.startWorkItemLock= function(){

		if(this.updateInterval > 0){
			this.updateWorkItemLock();
		}
	};
	
	/**
	 * check work item lock from the server.  Called periodically.
	 */
	this.updateWorkItemLock = function() {
		var workItemLock = new ap.WorkItemLockWidget(this.accountId, this.transactionName, PAGES.LOCATION, this.updateInterval, this.csrfToken);
		workItemLock.acquireLock();
		
	};
	
	this.excludeAccountType = function(){
		if(this.account_type == ACCOUNT_TYPES.PERSONAL){
			return ACCOUNT_TYPES.COMMERCIAL;
		}
		return ACCOUNT_TYPES.PERSONAL;
	};
	
	/**
	*	Sets the record lock status of the current work item.
	*	@param recordLockStatus is the record lock status of the work item.
	*/
	this.setRecordLockStatus = function (recordLockStatus) {
		this.recordLockStatus = recordLockStatus;
		this.readOnlyExperience(this.lockedByOtherUser());
	};
	
	this.setCanMergeWithOtherType = function(canMergeWithOtherType){
		this.canMergeWithOtherType = canMergeWithOtherType;
		if(this.canMergeWithOtherType == false){
			this.mergeHeadTip = this.mergeHeadTip + " " + 
				ap.account_management["account.actions.merge.account.restriction"];
		}
	};
	/**
	 * set up read only experience
	 * @param readOnly a flag that indicates if the account is locked or not
	 */
	this.readOnlyExperience = function (readOnly){
		
		if(readOnly){
			$('#readOnlyMessage').show();
			$('#account_controls').hide();
			$('#create_work_item').hide();			
		}else{			
			$('#readOnlyMessage').hide();
			$('#account_controls').show();
			
			if($('#move_work_item_container').is(':visible') == false){			
				$('#create_work_item').show();
			}
		}
	};
	
	/**
	*	Returns if the current work item is currently locked by another user.
	*	@return if the current work item is currently locked by another user.
	*	@type Boolean
	*/

	this.lockedByOtherUser = function() {
		return this.recordLockStatus == "LOCKED_BY_OTHER_USER";
	};
	
	/**
	 * activate account detail tab
	 * @param $li  tab link
	 */	
	this.loadRoster = function(pageid) {	
		var resetPage = PAGES.LOCATION;	
		if(pageid == PAGES.LOCATION){
			resetPage = PAGES.PEOPLE;
		}
		this.resetMessage(resetPage);
		var messageDiv = $('#' + resetPage).find('#messageDiv');
		if(messageDiv.length){
			messageDiv.html('');
		}
		ap.account.displayRoster(pageid);
    };
	
	this.refreshAccountWorkItems  = function(){		
 		ap.filterManager.applyFilters(); 
	};
	
	/**
	 * update the search input box
	 * @param doc   the selected auto suggested entry
	 */
	this.addSearchTermtoInputField = function(doc){
		var id = doc.id;
		var name = doc.name;
		if(id.indexOf("more~") > -1){
			$('#move_workitem_search_input').val(id.substring(5));
			ap.account.searchAccount();
		}else{
			$('move_workitem_search_input').val(name);
			ap.account.searchAccount(id);
		}
		
	};
	
	/**
	 * add additional parameter for account merge search
	 */
	this.setAdditionalSearchParameters = function(url){
		var options = {};
		options.value = $.trim($('#move_workitem_search_input').val());
		if($('#accountAction').val() == ACTIONS.MERGE_ACCOUNT && ap.account.canMergeWithOtherType == false){
			options.account_type='-' + ap.account.excludeAccountType();
		}
				
		return options;
	};
	
	/**
	 * set account holder address as contact address
	 */
	this.applyAccountHolderAddressAsContactAddress = function(elm){
	 
		for (var key in  this.accountHolderAddressFields) {
			var value =  this.accountHolderAddressFields[key];
			if($('#'+key)) {
				$('#'+key).val(value);
			}
		}
	};
	
	/**
	 * set account type
	 * @param account_type  the account type
	 */
	this.setAccountType = function(account_type){
		this.account_type = account_type;
	};
	
	/**
	 * set account name
	 * @param name  the account name
	 */
	this.setAccountName = function(name){
		this.accountName = name;
	};
	
	/**
	 * set landing page after an account is deleted
	 * @param targetPage the landing page after an account is deleted
	 */
	this.setAccountDeleteTarget = function(targetPage){
		this.accountDeleteTargetPage = targetPage;
	};
	
	/**
	 * store the account holder address field and value
	 * @param key, contact address field unique key
	 * @param value, the value of corresponding account holder address field
	 */
	this.setAccountHolderAddressFieldParam = function(key, value){
		this.accountHolderAddressFields[key]= value;
	};
	
	
	/**
	 * store a html page field for validation
	 * @param field  the field object
	 * @param pageId the pageId
	 */
	this.addField = function(field, pageId){
		ap.consoleInfo('account roster: adding page/field ' + pageId + '/' + field.getTdfId() );
		if(PAGES.LOCATION == pageId){
			this.locationFields.push(field);
		}else{
			this.contactFields.push(field);
		}
	};
	
	
	/**
	 * reset fields cache for people page
	 */
	this.clearFields = function(){
		ap.consoleInfo('account roster: clear  page/fields' );
		this.contactFields = null;
		this.contactFields = new Array();
		this.locationFields = null;
		this.locationFields = new Array();
	};
	
	/**
	 * run field validations before the parameters are sent over the wire
	 * @param pageId the page id
	 */
	this.validate = function(pageId){
		if(pageId == PAGES.LOCATION){
			for(var i = 0; i < this.locationFields.length; i++){
				if(!this.locationFields[i].validate()) {
					this.locationFields[i].setFocus();
					return false;
				}
			}
		}else if(pageId == PAGES.PEOPLE){
			for(var i = 0; i < this.contactFields.length; i++){				
				if(!this.contactFields[i].validate()) {
					this.contactFields[i].setFocus();
					return false;
				}
				
			}
						
			//validate roles, at least one
			var rolesCheckedCnt = $('#RolesSection').find('input:checked').length;
			if(rolesCheckedCnt == 0){
				var checkbox = $('#RolesSection').find('input:checkbox:first');			
				checkbox.popover({placement: 'right', 
			        	content: ap.account_management["account.management.contact.role.validation"]
			        })
			        .blur(function () {
			            $(this).popover('destroy');
			        });
				checkbox.focus();
				checkbox.popover('show');
				  
				return false;
			}
		}
		
		return this.customValidate(pageId);		
	};
	
	this.customValidate = function(pageId){
		return true;
	}

	
	/**
	 * add a new location or contact
	 */
	this.addRosterEntry = function(action, pageId){
		this.resetMessage(pageId);
		this.doAdd(action, pageId, 'rosterContainer_' + pageId, 'rosterAddNew' + pageId);
	};
	
	
	/**
	 * show add new entries or send a request to add a new location or contact
	 * @param action  the action: add or cancel
	 * @param pageId the page id-location or people
	 * @param rosterContainerClass the roster container class
	 * @param rosterAddNewContainerId the add new entry section container id
	 */
	this.doAdd = function(action, pageId, rosterContainerClass, rosterAddNewContainerId){
		this.customPreAddRosterEntry(action, pageId, rosterContainerClass, rosterAddNewContainerId);

		if(action == 'add'){
			if(this.validate(pageId)){				
				this.sendUpdateRosterRequest(pageId, 'Process', rosterAddNewContainerId, 'Add');
			}
		}else if(action == 'cancel'){
			var $rosterContainer = $('.'+ rosterContainerClass);
			if($rosterContainer.length){
				$rosterContainer.show();
			}
			$("#" + rosterAddNewContainerId).hide();
		}else{ //show

			var $rosterContainer =$('.'+ rosterContainerClass);
			if($rosterContainer.length){
				$rosterContainer.hide();
			}
			$("#" + rosterAddNewContainerId).css("display","block");
		}
	};
	
	/*
	 * Hook for custom project implementation
	 * @param action  the action: add or cancel
	 * @param pageId the page id-location or people
	 * @param rosterContainerClass the roster container class
	 * @param rosterAddNewContainerId the add new entry section container id
	 */
	this.customPreAddRosterEntry = function(action, pageId, rosterContainerClass, rosterAddNewContainerId){
		
	};



	/**
	 * send a request to  server to get locations or contacts
	 * @param pageId the page id
	 */
	this.displayRoster = function(pageId, priorAction){
		var actionParams = {};
		actionParams.METHOD="Display";
		actionParams.PAGE_NAME=pageId;
		actionParams.URL=this.accountURL; 
		this.makeAjaxRequest(actionParams, ACTIONS.DISPLAY_ROSTER,priorAction);
	};
	
	
	/**
	 * send a request to display entry to be edited
	 * @param pageId the page id
	 * @param transactionId  the transaction id
	 * @param indexName  roster entry index name
	 * 
	 * @param indexPath the index of the entry to be edited
	 */
	this.edit = function(pageId, transactionId, indexName, indexPath){
		
		var actionParams = {};
		actionParams.METHOD="Display";
		actionParams.PAGE_NAME=pageId;
		actionParams[indexName]=indexPath;
		actionParams.EDIT="true";
		actionParams.URL=this.accountURL; 
		this.resetMessage(pageId);
		this.makeAjaxRequest(actionParams,ACTIONS.DISPLAY_EDIT);		
	};
	
	/**
	 * update a contact or location
	 * @param pageid the pageId
	 */	
	this.updateRosterEntry = function(pageId){
		this.customPreUpdateRosterEntry(pageId);
		if(this.validate(pageId)){
			this.sendUpdateRosterRequest(pageId, 'ProcessEdit', 'rosterAddNew' + pageId, 'Save');
		}
	};
	
	this.customPreUpdateRosterEntry = function(pageId){
		
	};
	
	/**
	 * send update request 
	 * @param pageName the page id
	 * @param method the process method, either process or processEdit
	 * @param dataContainer the new entry data container id
	 * @param next the NEXT parameter
	 */
	this.sendUpdateRosterRequest =function(pageName, method, dataContainer, next){		
		var actionParams = {};			
		actionParams.PAGE_NAME = pageName;
		actionParams.METHOD = method;
		actionParams.NEXT=next; 
		actionParams.force_view_on_upload='false'; 
		actionParams.DATA_CHANGED='true';  

		var elm = $("#" + dataContainer);
		if(elm.length){
			var $nodes = elm.find("[type='radio'], [type='hidden'], [type='text'], [type='checkbox'], [type='password'], select, textarea");
			$.each($nodes,function(index,node) {
				var $element = $(node);
				if(node.nodeName.toLowerCase() == 'input' && 
						($element.attr("type").toLowerCase() == 'radio' || $element.attr("type").toLowerCase() == 'checkbox')){
					if($element.prop( "checked" )){					
						actionParams[node.name] =  $element.val();
					}
				}else{
					actionParams[node.name] = $element.val();
				}
			});
			
			if(PAGES.PEOPLE ==  pageName){
				var $accountHolder = $('#contactRoleAccountHolder');
				if($accountHolder.length && $accountHolder.is(':checked')){
					this.updateAccountHolder();
				}
			}
		}
		actionParams.URL=this.accountURL; 
		this.makeAjaxRequest(actionParams, ACTIONS.UPDATE_ROSTER);	
	};
	
	/**
	 * update account holder name and address
	 */
	this.updateAccountHolder = function(){
		var accountTitle = "";
		var $firstName = $('#ContactFirstName');
		if($firstName.length){
			accountTitle = accountTitle + $firstName.val();
		}
		var $lastName = $('#ContactLastName');
		if($lastName.length){
			accountTitle = accountTitle + " " + $lastName.val();
		}		
		var $companyName = $('#ContactCompanyName');
		if($companyName.length){
			accountTitle = $companyName.val();
		}		
		this.accountName = accountTitle;
				
		var contactAddress = '';
		var elms = ['ContactAddressZip', 'ContactAddressState', 'ContactAddressCity', 
					'ContactAddressLine2','ContactAddressLine1']; 
			
		for(var i = 0; i < elms.length; i++){
			var $elm = $(elms[i]);
			if($elm.length && elm.val() != ''){
				this.setAccountHolderAddressFieldParam($elm, $elm.val());
				if(i == 0){
					contactAddress = $elm.val();
				}else{
					var separator = ', ';
					if(i == 1) separator = ' ';
					contactAddress = $elm.val() + separator + contactAddress;
				}
			}else{
				this.setAccountHolderAddressFieldParam($elm, '');
			}
		}
		var $contactAddressType = $('#ContactAddressType');
		if($contactAddressType.length){
			this.setAccountHolderAddressFieldParam('ContactAddressType', $contactAddressType.val());
		}		
		
		this.accountContactInfo['account_title'] = accountTitle;
		this.accountContactInfo['account_address'] = contactAddress;
		var none = ap.account_management["account.management.none"];
		var m = 0;
		for (var key in this.accountContactInfo){
			var $elm = $("#" + this.summaryContactsOnRoster[m]);
			if($elm.length){
				var value = $elm.val();
				value = $.trim(value);				
				if(value == ''){
					value = none;
				}
				this.accountContactInfo[key] = value;
			}
			m++;
		}		
	};
	/**
	 * delete a roster entry
	 * @param args this is a href object
	 */
	this.deleteRosterEntry = function( datapath ){
		ap.cancelPopover(datapath);
		var actionParams = {}; 
		actionParams = this.parseURL($('a[data-path="'+datapath+'"]').attr('data-href'));
		actionParams.URL=this.accountURL; 
		this.makeAjaxRequest(actionParams, ACTIONS.DELETE_ROSTER);
	};
	
	/**
	 * send ajax requests
	 * @param ajaxReqParams location data 
	 * @action  operation
	 */
	this.makeAjaxRequest = function(ajaxReqParams, action, priorAction) {
		
		ap.consoleInfo('Account Details make ajax call.');
		this.preMakeAjaxRequest(ajaxReqParams, action, priorAction);
		if(ajaxReqParams.WORKITEMID == null){
			ajaxReqParams.WORKITEMID = this.accountId;
		}
		ajaxReqParams.TRANSACTION_NAME = this.transactionName;
		ajaxReqParams.CSRF_TOKEN = this.csrfToken;
		this.pleaseWait(true);
		$.ajax({
			type: 'POST',
			url: ajaxReqParams.URL,
			data: ajaxReqParams
		})
		.done($.proxy(function (response, textStatus, jqXHR ){
			response = $.trim(response);
			this.pleaseWait(false);
	    	if(!this.evaluateRosterError(response, ajaxReqParams.PAGE_NAME,jqXHR, action, priorAction)){		    		
	    		var readonly = false;
	    		if(null != jqXHR.getResponseHeader("READONLY")){
	    			readonly = true;
	    		}
	    		if(action == ACTIONS.DELETE_ACCOUNT){
	    			this.updateAccountDeleteResponse(response);
	    		}else if(action == ACTIONS.SEARCH_ACCOUNT){
	    			this.updateAccountSearchResponse(response);
	    		}else if(action == ACTIONS.AUTO_SEARCH){
	    			this.updateAutoAccountSearchResponse(response);
	    		}else if(action == ACTIONS.DISPLAY_EDIT){
	    			var editOnly = this.updateRosterEditResponse(response, ajaxReqParams.PAGE_NAME);
	    			if(editOnly){
	    				readonly = true;
	    			}
	    		}else if(action == ACTIONS.DISPLAY_ROSTER){
	    			this.updateRoster(response, ajaxReqParams.PAGE_NAME,priorAction);
	    		}else if(action == ACTIONS.GET_ACCOUNT_WORKITEM){
	    			this.updateGetAccountWorkItemResponse(response);
	    		}else if(action == ACTIONS.MOVE_WORKITEM){
	    			this.updateAccountMergeOrMoveResponse(response, ACTIONS.MOVE_WORKITEM);
	    		}else if(action == ACTIONS.MERGE_ACCOUNT){
	    			this.updateAccountMergeOrMoveResponse(response,ACTIONS.MERGE_ACCOUNT);
	    		}else{
	    			this.displayRoster(ajaxReqParams.PAGE_NAME, action);
	    		}
	    		this.readOnlyExperience(readonly);
	    		
	    		if(this.customPostMakeAjaxRequest(response, textStatus, jqXHR ) && priorAction == ACTIONS.UPDATE_ROSTER){
	    			this.resetMessage(ajaxReqParams.PAGE_NAME);
	    		}
	    	}
		},this)).fail($.proxy(function(jqXHR, textStatus, errorThrown) {
			this.updateFailure(errorThrown);
			this.pleaseWait(false);
		},this));
	};

	/**
	 * Hook for custom code
	 * @param ajaxReqParams location data 
	 * @action  operation
	 */
	this.preMakeAjaxRequest = function(ajaxReqParams, action, priorAction){
		
	};
	
	/**
	 * Hook for custom code
	 * @param response is ajax response
	 * @param textStatus is the response status
	 * @param jqXHR is the raw ajax response
	 */
	this.customPostMakeAjaxRequest = function(response, textStatus, jqXHR ){
		return true;
	}; 
	
	this.evaluateRosterError = function (response,pageId, jqXHR, action, priorAction){
		
		var errorString = jqXHR.getResponseHeader('ERROR_STRING');
		var customerserviceMsg = ap.account_management["account.management.contact.customerservice"];
		if(null != errorString){
			$("#roster_error").html(errorString + " " + customerserviceMsg);
			$('#lb_account_roster_error_message').modal();
			return true;
		}
		
		var errorReport = jqXHR.getResponseHeader("ERROR_REPORT");
		if(null != errorReport){
			this.updateErrorResponse(response, pageId);
			return true;
		}

		var resposeText = response;
		var $element = $(document.createElement('div'));
		$element.html(resposeText);
		var messageContent = $element.find("#messageDiv");	
		if(messageContent.length && priorAction != ACTIONS.UPDATE_ROSTER && action != ACTIONS.DISPLAY_EDIT){
			var messageDiv = $('#' + pageId).find("#messageDiv");
			if(messageDiv.length > 0){
				messageDiv.html(messageContent.html().trim());
			}
		}
				
		var criticalErrors = $element.find('#alert-danger');
		if(criticalErrors.length && action  !=  ACTIONS.DISPLAY_ROSTER && action != ACTIONS.DISPLAY_EDIT){ 
			return true;
		}
					
		return false;
	};
	
	this.resetMessage = function(pageId){
		
		if(typeof ap.initialDisplayMessageMap !== "undefined"){
			ap.initialDisplayMessageMap.clear();
		}
		
		if(typeof ap.ajaxMessageMap  !== "undefined"){
			ap.ajaxMessageMap.clear();
		}
		var page = $('#' + pageId);
		var initialDisplayMessages = page.find('#initialDisplayMessages');
		if(initialDisplayMessages.length){
			initialDisplayMessages.html('');
		}	
		
		var ajaxMessages = page.find('#ajaxMessages');
		if(ajaxMessages.length){
			ajaxMessages.html('');
		}	
		
	};
	
	/**
	 * update account delete
	 * @param response  account delete ajax response
	 */
	this.updateAccountDeleteResponse = function(res){
		
		var response = eval( "(" + res + ")" );
		var outcome = response.actionResponse[0].outCome;
		if(outcome == 'failure'){
			this.updateErrorResponse(response, null);
		}else{
			setTimeout(function(){
				window.location.href = ap.account.accountDeleteTargetPage;
			},800);	
			
		}	
	};
	
	/**
	 * update account search results
	 * @param response  account search ajax response
	 */
	this.updateAccountSearchResponse = function(response){
		
		var resposeText = response;
		var $element = $(document.createElement('div'));
		$element.html($.trim(resposeText));
		$('#account_search_results').html($.trim($element.html()));
		$('#account_search_result_container').show();
		
		if($('#move_workitem_account_list').length){
			var currentAccountAction = $('#accountAction').val();
			
			if(!$('#no_account').length){
				var $accountHelpTip = $('#account_search_result_container').find('.account_help_tip').first();			
				if($accountHelpTip.length){
					var accountInfo = "<b>" + this.accountName + " Account# " + this.accountNumber + "</b>";
					if(currentAccountAction == ACTIONS.MOVE_WORKITEM){
						$accountHelpTip.html(ap.account_management["account.actions.move.workitem.selectaccount"]);
						//update account select
						$.each($('#account_search_results').find('.account_action_button'),function(index,node){
							$(node).val(ap.account_management["account.management.label.select"]);
						});	

					}else{
						var tips = ap.account.mergeFullSearchTip.replace('{0}', accountInfo);
						$accountHelpTip.html(tips);
					}
				}
				$('#account_search_help').show();
			}else{
				$('#account_search_help').hide();
			}
		}
	};
	
	this.updateAutoAccountSearchResponse = function(response){
		
		var resposeText = response;
		var $element = $(document.createElement('div'));
		$element.html($.trim(resposeText));
		$('#account_search_results').replaceWith($element.html());
		$('#account_search_result_container').show();
		
		if($('#move_workitem_account_list').length){
			var $row = $('#move_workitem_account_list').find('.account_row').first();
			if($row){
				this.srcAccountId = $row.attr("id").substring(8);
				var currentAccountAction = $('#accountAction').val();			
				var $accountHelpTip = $('#account_search_result_container').find('.account_help_tip').first();
				if($accountHelpTip.length){
					var accountInfo = "<b>" + this.accountName + " Account# " + this.accountNumber + "</b>";		
					if(currentAccountAction == ACTIONS.MOVE_WORKITEM){
						$accountHelpTip.html(ap.account_management["account.actions.move.workitem.autoselectaccount"]);
						$.each($('#account_search_results').find('.account_action_button'),function(index,node){
							$(node).hide();
							$('#account_action_column').html("&nbsp;");
						});	
						ap.account.sendGetAccountWorkItemRequest(this.srcAccountId);
					}else{
						var tips = ap.account.mergeAutoSearchTip.replace('{0}', accountInfo);
						$accountHelpTip.html(tips);
					}
				}
			}
			$('#account_search_help').show();			
		}
	};
	
	/**
	 * get work items for the selected account
	 * 
	 * TODO: this is no longer needed .. as move is initiated per work item.
	 */
	this.sendGetAccountWorkItemRequest = function(srcAccountId){
				
		$.each($('#account_search_results').find('.account_row'),function(index,item){
			$node = $(item);
			var highlight = $node.hasClass('account_selected');
			var id = item.id.substring(8);
			var className = $('#account_css_' + id).val();
			if(highlight){
				$node.removeClass('account_selected');	
				$node.addClass(className);
			}
			if(id == srcAccountId){
				$node.removeClass(className);
				$node.addClass('account_selected');
			}
		});	
		
		this.srcAccountId = srcAccountId;
		
		var currentAccountAction = $('#accountAction').val();	
		if(currentAccountAction == ACTIONS.MOVE_WORKITEM){
			var actionParams = {};			
			actionParams.URL = this.workItemActionURL;
			actionParams.WORKITEMID = srcAccountId; 
			actionParams.action='GetRows';
			actionParams.WorkListType='AccountItemsView';
			actionParams.NEXT_PAGE='/account/workItemList.jsp';
			actionParams.CSRF_TOKEN = this.csrfToken;
			this.makeAjaxRequest(actionParams, ACTIONS.GET_ACCOUNT_WORKITEM);	
		}
	};
	
	/**
	 * display work items for the selected account
	 * @param response ajax response object
	 */
	this.updateGetAccountWorkItemResponse = function(response){
		
		var resposeText = response;
		var $element = $(document.createElement('div'));
		$element.html($.trim(resposeText));
		var $elms = $($element.find(".no_workitem_warning"));
		if($elms.length == 0){
			$('#moveButton').show();
		}else{
			$('#moveButton').hide();
		}
		
		$('#workitem_search_help').show();
		
		$('#account_workitem_results').html($element.html());
		$('#workitem_result_container').show();
	};
	
	/**
	 * send a move work item request to server
	 */
	this.sendMoveWorkItemRequest = function(){
		
		var $checkedWorkItems = $('#move_work_list');
		if($checkedWorkItems.length){
			var actionParams = {};	
			actionParams.URL = this.workItemActionURL;
			actionParams.action='MoveWorkItems';
			actionParams.SRC_ACCOUNT = this.srcAccountId;
			actionParams.WORKITEMS = '';
			actionParams.CSRF_TOKEN = this.csrfToken;
			$.each($checkedWorkItems.find('.account_workitems_checkbox'),function(index,el){			
				if($(el).prop("checked")){
					actionParams.WORKITEMS = el.value + "," + actionParams.WORKITEMS; 
				}
			});	

			if(actionParams.WORKITEMS != ''){		
				this.makeAjaxRequest(actionParams, ACTIONS.MOVE_WORKITEM);
			}
		}
	};
	
	/**
	 * update the client with server response for work item move
	 */
	this.updateAccountMergeOrMoveResponse = function(res, action){
		
		var response = eval( "(" + res+ ")" );
		var outcome = response.actionResponse[0].outCome;
		if(outcome == 'failure'){
			alert(response.actionResponse[0].reason);
		}else{
			this.cancelMoveOrMerge();
			this.displayRoster(PAGES.LOCATION);
			this.displayRoster(PAGES.PEOPLE);
			//this.refreshAccountWorkItems();
			this.showAccountMergeOrMoveSuccess(action);			

		}			
	};
	
	this.showAccountMergeOrMoveSuccess = function(action){
		
		var dialog_id = '#lb_account_action_move_message';
		if(action == ACTIONS.MERGE_ACCOUNT){
			dialog_id = '#lb_account_action_merge_message';
		}
		$(dialog_id).modal('show');
	};
		
	/**
	 * update error message
	 * @param response  ajax response
	 * @param pageId  the page id
	 */
	this.updateErrorResponse = function(response, pageId){
		var customerserviceMsg = ap.account_management["account.management.contact.customerservice"];
		$('#account_action_error_messageDiv').html(response.actionResponse[0].reason + " " + customerserviceMsg);
		
		$('#lb_account_action_error_message').modal();
	};

	/**
	 * Get the parameters from the url e.g FrontServlet?PAGE_NAME=location&amp;METHOD=Display&amp;TRANSACTION_NAME=account&amp;WORKITEMID=1005&amp;INDEX.Location=Location[0]&amp;EDIT=true.
	 * will produce an object { 'PAGE_NAME' : 'location',  'METHOD' : 'Display', 'TRANSACTION_NAME': 'account', 'WORKITEMID': 1005, 'INDEX.Location' : 'Location[0]', 'EDIT': true}  
	 * @param url is the url to be processed
	 * @return object
	 */
	this.parseURL = function(url){
		var queryStr = url.indexOf('?')?url.slice(url.indexOf('?') + 1):url;
	    var hashes = queryStr.split('&');
	    var obj = {};
	    for(var i = 0; i < hashes.length; i++)
	    {
	      var hash = hashes[i].split('=');
	      obj[hash[0]] = hash[1];
	    }
	    return obj;
	};
	
	/**
	 * update roster entries
	 * @param response  ajax response
	 * @param pageId  the page id
	 */
	this.updateRoster = function(response, pageId, priorAction){

		ap.consoleInfo('Update Account  on success - begin.');
	    var resposeText = response;
		var $element = $(document.createElement('div'));
		$element.html(resposeText);
		var $theWrapper = $element.find('#roster_wrapper').first();
		var $readOnly = $element.find('#PAGE_READONLY').first();
		var viewOnly = 'false';
		if($readOnly.length){
			viewOnly = $readOnly.val();
		}
			
		if($theWrapper.length){
			
			if(priorAction == ACTIONS.UPDATE_ROSTER){
				var messageDiv = $('#messageDiv');
				var messageContent = $element.find('#messageDiv');
				if(messageDiv.length && messageContent.length){
					messageContent.html(messageDiv.html());
				}
			}
			var theHTML = $theWrapper.html();
			if(PAGES.LOCATION == pageId){
				$('#' + pageId).first().html(theHTML);
			}else{
				$('#' + pageId).first().html(theHTML);

				for (var key in  this.accountContactInfo){
					if($(key).length) {
						$(key).replaceWith(this.accountContactInfo[key]);
					}
				}
			}
			$theWrapper = $('#' + pageId);
			
			var linkContainer = document.createElement('div');
			if(viewOnly != 'true'){
				linkContainer.className = 'rosterAddNewLink';
				linkContainer.id = pageId + 'RosterAddNewLink';
				var link = document.createElement('a');
				link.className = "btn btn-primary";
				link.href = "javascript:ap.account.addRosterEntry('','"+ pageId +"');";

				var addLabel = ap.account_management['action.account.management.addlocation'];
				if(pageId != PAGES.LOCATION){
					addLabel = ap.account_management['action.account.management.addcontact'];
				}
				var linkText = document.createTextNode(addLabel);
				link.appendChild(linkText);
				linkContainer.appendChild(link);
			}
			var $rosterContainer = $theWrapper.find('.rosterContainer').first();
			if($rosterContainer.length){
				$rosterContainer.addClass('rosterContainer_' + pageId);
				if(viewOnly != 'true'){
					$rosterContainer.append(linkContainer);
				}
				
				//remove action delete on the last location  entry
				var $tr = $rosterContainer.find('tbody tr');
				if($tr.length){
					if(pageId == PAGES.LOCATION && $tr.length == 1){					
						var $actionCell = $($tr.get(0)).find(".actionCell").first();
						if($actionCell.length){
							var $deleteActions = $actionCell.find(".deleteAction");
							if($deleteActions.length){
								$deleteActions.first().hide();
							}
						}
					}
					if(pageId == PAGES.PEOPLE){ //find one with AccountHolder
						var $elm = $element.find('#account_holder_index');
						if($elm.length){
							var $actionCell = $($tr[$elm.val()]).find(".actionCell");
							if($actionCell.length){
								var $deleteActions = $actionCell.find(".deleteAction");
								if($deleteActions.length){
									$deleteActions.first().hide();
								}
							}
						}					
					}
				}			
				if(viewOnly == 'true'){
					var $actions = $rosterContainer.find(".actionCell a");
					$.each($actions,function(index,action){
						var $actionItem = $(action);
						if (!$actionItem.hasClass('editAction')){ 
							$actionItem.hide();
						}
						if ($actionItem.hasClass('editAction')){
							$actionItem.html(ap.account_management["action.View"]);
						}
					});
				}
			}
			
			var $rosterAddNew = $theWrapper.find('.rosterAddNew').first();
			$rosterAddNew.attr("id",'rosterAddNew' + pageId);
				
			var $addButton = $theWrapper.find('#addButton').first();
			if($addButton.length){			
				$addButton.attr("onclick", "ap.account.addRosterEntry('add','" + pageId +"')");
				
				var cancelButton = document.createElement('input');
				cancelButton.type = 'button';
				cancelButton.value = ap.core_prompts["action.Cancel"];
				cancelButton.id = 'cancelButton';
				cancelButton.accessKey = 'q';
				cancelButton.className = 'btn btn-default';
				cancelButton.setAttribute("onclick", "ap.account.addRosterEntry('cancel','" + pageId +"')");
				$addButton.parent().append(cancelButton);
			}			
			var $rosterContainer = $('.rosterContainer_' + pageId);
			if($rosterContainer.length){
				$rosterContainer.show();
			}
			$("#rosterAddNew" + pageId).hide();
		}
		ap.consoleInfo('Update Account  on success - end.');
	};
	
	/**
	 * update roster an entry to be edited.
	 * @param response  ajax response
	 * @param pageId  the page id
	 */
	this.updateRosterEditResponse = function(response, pageId) {
		
		ap.consoleInfo('Update Account edit  on success - begin.');
		
	    var resposeText = response;
		var $element = $(document.createElement('div')).html(resposeText);
		var $theWrapper = $element.find('#roster_wrapper');
		
		var $readOnly = $element.find('#PAGE_READONLY');
		var viewOnly = 'false';
		if($readOnly){
			viewOnly = $readOnly.val();
		}
		
		if($theWrapper.length){
			var $rosterAddNew=$theWrapper.find("#rosterAddNew").first();
			if($rosterAddNew.length){
				$rosterAddNew.css("display","block");
				$rosterAddNew.attr("id","rosterAddNew"+ pageId);
			}
			
			var $cancelButton = $theWrapper.find("#cancelButton").first();
			if($cancelButton.length){
				$cancelButton.attr("onclick", "ap.account.displayRoster('" + pageId + "')");
				if(viewOnly == 'true'){
					$cancelButton.val('Back');
				}
			}
			
			var $saveButton = $theWrapper.find("#saveButton").first();
			if($saveButton.length){
				$saveButton.attr("onclick", "ap.account.updateRosterEntry('" + pageId + "')");
				if(viewOnly == 'true'){
					$saveButton.hide();
				}
			}
			
			var locationHTML = $theWrapper.html();
			if(PAGES.LOCATION == pageId){
				$('#' + pageId).first().html(locationHTML);
			}else{
				$('#' + pageId).first().html(locationHTML);
				var $accountHolder = $('#contactRoleAccountHolder');
				if($accountHolder.length && $accountHolder.prop("checked")){
					$accountHolder.prop("disabled",true);
				}
			}
		}		
		ap.consoleInfo('Update Account edit  on success - end.');
		return (viewOnly == 'true');
	};

	/**
	 * Handle onFailure errors
	 */
	this.updateFailure = function(response) {
		if(response){
			var errorMessage = response;
			if(errorMessage){
				alert(errorMessage);
			}
		}
	};
	
	/**
	 * create a new work item in thi account
	 * @param lobs  the LOB select list
	 */
	this.createWorkItem = function(li){
		var value = $(li).attr('value');
		if(value != ''){
			ap.WorkItemList.handleWorkItemActions('Copy', value + "&WORKITEMID=" + ap.account.accountId);
		}
	};
	
	
	/**
	 * account actions
	 * @param action   the action select list
	 */
	this.handleAccountActions = function(action){
		this.customPreHandleAccountActions(action);
		if(action == 'account_delete'){
			$('#lb_confirm_account_delete').modal();
		}else if(action == 'deleteaccount'){
			$('#lb_confirm_account_delete').modal();
			$('#account_action').val('');
		}else if(action == 'moveworkitem'){
			this.showWorkItemMove();
			$('#account_action').val('');
		}else if(action == 'mergeaccount'){
			this.showAccountMerge();
			$('#account_action').val('');
		}else{
			this.cancelMoveOrMerge();
		}
	};
		
	/**
	 * delete account and associated work items
	 */
	this.doAccountDelete = function(){
		var actionParams = {};	
		actionParams.WorkListType = 'AccountsView';
		actionParams.action='Delete'; 
		actionParams.URL=this.workItemActionURL;
		$('#lb_confirm_account_delete').modal('hide');
		this.makeAjaxRequest(actionParams, ACTIONS.DELETE_ACCOUNT);
	};
	
	this.customPreHandleAccountActions = function(action){
		
	};

	/**
	 * display move work item screen
	 */
	this.showWorkItemMove = function(){
		if($('#workitems').hasClass('activated')){
			var $workItemTable = $('.dataTable').first();
			this.worklistTableWidth = $workItemTable.width();						
		}
		$('#accountAction').val(ACTIONS.MOVE_WORKITEM);
		$('#move_workitem_search_input').attr("placeholder", ap.account_management["account.actions.move.workitem.tip"]);
		$('#move_workitem_search_input').val('');
		$('#action_title').html(ap.account_management["account.actions.move.workitem"]);
		$('#instruction_tip').html(this.moveHeadTip);
		this.toggle('workitem_result_container', true);	
		this.showActionContainer();
		$('#account_search_help').hide();
		$('#workitem_search_help').hide();
		$('#moveButton').hide();
		$('#create_work_item').hide();
	};
	
	/**
	 * cancel move work item or account merge
	 */
	this.cancelMoveOrMerge = function(){
		
		this.hideActionContainer();		
		this.toggle('workitem_result_container', true);			
		$('#accountAction').val(ACTIONS.NONE);
		$('#move_workitem_search_input').val('');
		$('#account_search_results').empty();
		$('#create_work_item').show();
		
		if($('#workitems').hasClass('activated')){
			ap.filterManager.applyFilters();
		}
	};
	
	
	
	/**
	 * search accounts for work item move
	 */
	this.searchAccount =  function(id){
		
		var actionParams = {};	
		actionParams.URL=this.searchProviderURL; 
		actionParams.NEXT_PAGE='/account/accountList.jsp';
		var searchValue = $.trim($('#move_workitem_search_input').val());
		this.toggle('workitem_result_container', true);	
		$('#moveButton').hide();
		this.toggle('account_search_result_container', true);
		if(id != null && id != ''){
			actionParams.id=id;
			this.makeAjaxRequest(actionParams, ACTIONS.AUTO_SEARCH);	
			return;
		}
		
		
		if(searchValue.length < 3){
			var $item = $('#account_action_search_btn');
			$item.tooltip({placement: 'auto top', title: ap.account_management["toolTip.Account.ProvideThreeCharacters"], trigger: 'manual'});
			$item.tooltip('show');
			setTimeout(function(){
				$item.tooltip('hide');
			},3000);			
	
			return;
		}
	
		actionParams.value=searchValue;
		actionParams.id='-'+this.accountId;
		
		if($('#accountAction').val() == ACTIONS.MERGE_ACCOUNT && this.canMergeWithOtherType == false){
			actionParams.account_type='-' + this.excludeAccountType();
		}
		this.makeAjaxRequest(actionParams, ACTIONS.SEARCH_ACCOUNT);
	};
	
	/**
	 * show account merge screen
	 */
	this.showAccountMerge = function(){
		$('#merge-account').modal();
	};
	
	/**
	 * merge accounts or move work items
	 */
	this.doMoveOrMerge = function(srcAccountId){
		var action = $('#accountAction').val();
		if(action == ACTIONS.MERGE_ACCOUNT){
			this.sendMergeAccountRequest(srcAccountId);
		}else if(action == ACTIONS.MOVE_WORKITEM){
			this.sendGetAccountWorkItemRequest(srcAccountId);
		}
	};
	
	this.sendMergeAccountRequest = function(srcAccountId){
		if(srcAccountId){
			var actionParams = {};	
			actionParams.WorkListType = 'AccountsView';
			actionParams.action='MergeAccount'; 
			actionParams.URL=this.workItemActionURL; 
			actionParams.SRC_ACCOUNT=srcAccountId;
			actionParams.CSRF_TOKEN = this.csrfToken;
			this.makeAjaxRequest(actionParams, ACTIONS.MERGE_ACCOUNT);
		}
	};
	
	/**
	 * bring up the move work item or merge account screen
	 */
	this.showActionContainer = function(){
		
		$('#account_search_results').html("&nbsp;");
		$('#account_workitem_results').html("&nbsp;");

		this.toggle('account_details_container', true);
		this.toggle('account_edit', true);
		this.toggle('move_work_item_container', false);	
	};
	
	/**
	 * hide the move work item or merge account screen
	 */
	this.hideActionContainer = function(){
		
		this.toggle('account_details_container', false);
		this.toggle('account_edit', false);
	};
	
	this.toggle = function (id, off){
		if(off){
			$("#" + id).hide();
		}else{
			$("#" + id).show();
		}		
	};
	
	this.pleaseWait = function(show){
		if(show){
			$('#pleaseWait div').removeClass('invisible');
		}else{
			$('#pleaseWait div').addClass('invisible');
		}
	};
	
};


ap.AccountSearchManager = function(){
	
	this.autosearchProviderURL = "AccountSearchServlet?type=AUTOSEARCH&sort=last_update_time desc&value=%QUERY";
	this.searchProviderURL = "AccountSearchServlet?type=SEARCH";
	this.autocompleterWidget;
	this.hasErrors=false;
	
	this.updateList = function(response){
		alert(response);
	};
	
	this.getSelectionId = function(doc){
		var id = '' + doc.id;
		var name = doc.name;
		var $searchContainer = $('div.autosearch');
		var isUpload = false;
		if($searchContainer.length){
			isUpload = $searchContainer.first().parent().hasClass('account_upload');
		}
		if(id.indexOf("~more") == 0){
			this.searchBox.val(id.substring(5));
			ap.accountSearchMgr.launchSearch();
		}else{
			if(isUpload){
				this.searchBox.val($.trim(name));	
				ap.accountSearchMgr.launchSearch();
			}else{
				ap.accountSearchMgr.launchAccount(id,true);
			}
		}
	};

	this.onSuccess = function(response){
		alert("On success" + response.responseText);
	};
	
	this.onComplete = function(){
		alert("onComplete");
	};
	
	this.onException = function(){
		alert("onException");
	};
	
	
	/**
	 * Initialize unified account modal search experience. 
	 * @param searchBoxId - pass in the id of the search input text field.
	 */
	this.initialize = function(searchBoxId){
		

		this.searchBoxId = (searchBoxId === undefined) ? 'account_searchInput' : searchBoxId; 
		//Type ahead
		this.searchBox = $('#' + this.searchBoxId);
		
		this.autoSuggestCount = ap.options.autoSuggestCount;
		
		var bloodhoundOpts = {
				datumTokenizer: function(d) {
					return [d.value];
				},
				queryTokenizer: Bloodhound.tokenizers.whitespace,
				remote: {
					url: this.autosearchProviderURL,
					minLenghth: 3,
					filter: function(parsedResponse) {
						var arr = this.renderSolrData(parsedResponse); 
						return arr;
					}.bind(this)
				}
		};
		
		if(this.autoSuggestCount){
			bloodhoundOpts['limit'] = this.autoSuggestCount;
		}else{
			bloodhoundOpts['limit'] = -1;
		}
		
		this.suggestionEngine = new Bloodhound(bloodhoundOpts);
		
		//init suggestion engine
		this.suggestionEngine.initialize();
		
		this.searchBox.typeahead({
			minLength: 3,
			highlight: true,
			hint: false
		},
		{
			source: this.suggestionEngine.ttAdapter(),
			displayKey: function(data){
				return data.value;
			}
		})
		.on('typeahead:selected', function(event, suggestion, datasetName) {
			this.getSelectionId(suggestion);
		}.bind(this))
		.on('typeahead:cursorchanged', function(event,suggestion, datasetName){
			event.currentTarget.value = suggestion.name;
		}.bind(this));
		//End Type ahead
		
		
		//set up tab
		var $launchTabs = $('#accountnav a');
		$.each($launchTabs,function(index,li) {
			li.setAttribute("onclick", "ap.accountSearchMgr.activateTab(this)");
		});			
	};

	
	this.renderSolrData = function(data) {
		var arr = [];
		var searchVal = this.searchBox.val();
		// Iterate through each of the Solr results, keeping only the first four that we get.
		// All others will be ignored and we'll inform the user that there are <result size> - 4
		// more results available.
		$.each(data.response.docs, function(index, doc) {
			if(index == 4) {
				return;
			}
			var encodedName = ap.htmlEncode(doc.name);
			arr.push({
				value: encodedName + " (" + ap.account_management['label.account.management.hashtag'] + 
					doc.account_number + " - " + ((doc.account_type == 'P')? ap.account_management["account.management.label.person"] : ap.account_management["account.management.label.company"]) + ")",
				id: doc.id,
				name: encodedName,
				searchValue: searchVal
			});
		});
		
		// The last entry is an indicator of how many more search hits there are if
		// there are more than 4 total.
		if(data.response.docs.length > 4) {
			ap.consoleInfo("Found " + data.response.docs.length + " solr hits.");
			if(data.response.docs.length == 5) { 
				arr.push({value: data.response.docs.length - 4 + " " + ap.account_management["label.account.management.other"], 
						id: ap.account_management["label.account.management.more"], name: '', searchValue: searchVal});
			}
			else {
				arr.push({value: data.response.docs.length - 4 + " " + ap.account_management["label.account.management.others"], 
						id: ap.account_management["label.account.management.more"], name: '', searchValue: searchVal});
			}
		}
		
		return arr;
	};
	
	this.buildSearchURL = function(){
		this.hasErrors = true;
		var searchValue = $.trim(this.searchBox.val());
		
		var url = "";
		
		if(searchValue.length > 2){
			url = '&value=' + encodeURIComponent(searchValue);
			this.hasErrors = false;
		}

		var $sortField = $('#sortresults');
		if($sortField.length && $.trim($sortField.val()).length > 0){
			url = url + '&sort=' + $.trim($sortField.val());
		}else{
			url = url + '&sort=last_update_time desc';
		}
		
		var $filterField = $('#filter_type');
		if($filterField.length && $.trim($filterField.val()).length > 0){
			url = url + '&account_type=' + $.trim($filterField.val());
		}
		
		/* Advanced search fields */
		var $account_number = $('#account_number');
		if($account_number.length && $.trim($account_number.val()).length > 2){
			url = url + '&account_number=' + encodeURIComponent($.trim($account_number.val()));
			this.hasErrors = false;
		}
		var $city = $('#city');
		if($city.length && $.trim($city.val()).length > 2){
			url = url + '&city=' + encodeURIComponent($.trim($city.val()));
			this.hasErrors = false;
		}
		var $state_prov_cd = $('#state_prov_cd');
		if($state_prov_cd.length && $.trim($state_prov_cd.val()).length > 0){
			url = url + '&state_prov_cd=' + encodeURIComponent($.trim($state.val()));
			this.hasErrors = false;
		}
		var $postal_code = $('#postal_code');
		if($postal_code.length && $.trim($postal_code.val()).length > 2){
			url = url + '&postal_code=' + encodeURIComponent($.trim($postal_code.val()));
			this.hasErrors = false;
		}
		
		if(this.hasErrors == true){
			var $item = $('#searchBtn');
			$item.tooltip({placement: 'auto top', title: ap.account_management["toolTip.Account.ProvideThreeCharacters"], trigger: 'manual'});
			$item.tooltip('show');
			setTimeout(function(){
				$item.tooltip('hide');
			},3000);			
		}
		
		return url;
	};
	
	this.uploadClose = function(){
		window.location='DisplayWorkInProgress?WorkListType=PendingItemsView';
	};
	
	this.launchSearch = function(){
		var url = this.searchProviderURL + this.buildSearchURL();
		if(this.hasErrors == true){
			return false;
		}
		var $searchContainer = $('div.autosearch');
		var isAjax = false;
		if($searchContainer.length){
			isAjax = $searchContainer.first().parent().hasClass('account_upload');
		}

		if(isAjax){
			var ajaxReqParams = {};
			ajaxReqParams.NEXT_PAGE='/account/uploadAccountList.jsp';
			
			$.ajax({
				type: 'POST',
				url: url,
				data: ajaxReqParams
			})
			.done($.proxy(function(response, textStatus, jqXHR) {
		    	var error = jqXHR.getResponseHeader("ERROR_REPORT");
		    	if(null != error){
		    		this.updateErrorResponse(response, ajaxReqParams.PAGE_NAME);
		    	}else{
		    		var resposeText = response;
		    		$('lightboxSearchResults').html("<tbody>" + resposeText + "</tbody>");
		    	}
			},this))
			.fail($.proxy(function(jqXHR, textStatus, errorThrown) {
				this.updateFailure(errorThrown);
			},this));	
		}else{
			setTimeout(function(){window.location = url;}, 0);	
		}
		
	};
	
	this.upload = function(accountid){
		var processUploadUrl = $('matchedAccountLink').value + "&ACCOUNTID=" + accountid;
		
		setTimeout(function(){window.location = processUploadUrl;}, 0);		
	};
	
	this.backToSearch = function(urlParams){
		var url = this.searchProviderURL;
		url = url + urlParams;
		setTimeout(function(){window.location = url;}, 0);
	};
	
	this.launchAccount = function(accountid,autosearch){
		var url = "DisplayWorkInProgress?action=Open&WorkListType=AccountItemsView&WORKITEMID=" + accountid;
		if (!autosearch){
			var searchURL = this.buildSearchURL();
			url = url + "&origin=" +encodeURIComponent(searchURL);
		}
		setTimeout(function(){window.location = url;}, 0);		
	};
	
	this.createNewAccount = function(validate){
		if(validate){
			this.hasErrors=false;
			var commField = $('#commercialAccount').val();
			
			var fieldType =  commField != null? 'div.commercial': 'div.personal';
			
			$.each($(fieldType),$.proxy(function(idx,el){
				$.each($(el).find('input[type=text]'),$.proxy(function(index,item){
					if($(item).is(':visible') && !this.validateCreateNewAccount(item)){
						this.hasErrors=true;
					}
				},this));
			},this));
			if(!this.hasErrors){
				$('#newaccountForm').submit();
			}
		}else{
			var url = 'FrontServlet?PAGE_NAME=accountInformation&TRANSACTION_NAME=account&FIRST_TIME=true&METHOD=Display';
			setTimeout(function(){window.location = url;}, 0);
		}
	};
	
	this.validateCreateNewAccount = function(item){
		var $label = $("#" + item.id + '_labelText');
		
		if(item.value != null && item.value.length > 0){
			$label.removeClass('problemField');
			return true;
		}else{
			$label.addClass('problemField');
		}

		var $item = $("#" + item.id);
		$item.tooltip({placement: 'auto top', title: ap.account_management["toolTip.Account.RequiredField"] , trigger: 'manual'});
		$item.tooltip('show');
		setTimeout(function(){
			$item.tooltip('hide');
		},3000);			

		 return false;
	};
	
	
	this.toggleAdvanced = function(){
		if($('#advancedSelect').is(":checked")){
			$('#advancedDropDown').show();
			this.searchBox.typeahead('destroy');
			ap.Effects.highlight('#advancedDropDown');
			return false;
		}else{
			$('#advancedDropDown').hide();
			this.initialize();			
			return false;
		}
	};
	
	this.showAccountFields = function(acctType){
		if(acctType == "C"){
			$.each($('div.personal'),function(index,el){
				$(el).hide();
			});
			$.each($('div.commercial'),function(index,el){
				$(el).show();
			});
		}else{
			$.each($('div.personal'),function(index,el){
				$(el).show();
			});
			$.each($('div.commercial'),function(index,el){
				$(el).hide();
			});
		}	
	};
	
	/**
	 * activate account detail tab
	 * @param li  tab link
	 */	
	this.activateTab = function(li) {		
		var tabs =['autosearch', 'newacct'];		
		for(var i = 0; i < tabs.length;i++){
			var $tab = $(tabs[i] + "_tab");
			if(tabs[i] == li.id){
				if(!$(li).hasClass('activated')){
					$tab.show();
					$(li).addClass('activated');
				}
			}else{
				$tab.hide();
				$tab.removeClass('activated');
			}
		}
    };
};







/**
 * Account Search experiance for Modal dialog boxes. This is modeled after the  Account Search Manager from 4.x 
 * and is intended for use when account search is required from MODAL Dialog boxes. 
 * For Eg. Turnstile workflow - account search, Account Merge, Work Item Move etc. 
 * @since 5.0
 */
ap.ModalAccountSearchManager = function(){
	
	this.autosearchProviderURL = "AccountSearchServlet?type=AUTOSEARCH&sort=last_update_time desc&value=%QUERY";
	this.searchProviderURL = "AccountSearchServlet?type=SEARCH&sort=last_update_time desc";
	this.autocompleterWidget;
	this.hasErrors=false;
	
	var singleResultTemplate =  
		'<table class="table table-condensed table-striped prepend-top turnstile-account-search-listing">' +
		'<thead><tr><th colspan="4">1 Account(s) Found</th></tr></thead><tr id="{{id}}"><td class="account-type {{account_type}}"><i class="fa"></i></td><td>{{entity_name}}</td><td>#{{account_number}}</td>'+
				'<td><button type="button" class="btn btn-primary select-account pull-right" >{{select}}</button></td></tr></table>' ; 
	
	this.getSelectionId = function(doc) {

		var id = '' + doc.id;
		var name = doc.name;
		var account_type = doc.account_type;
		if(id.indexOf("~more") == 0){
			this.searchBox.val(doc.searchValue);
			this.launchSearch();
		}else{
			
			this.searchResultsTableContainer.html(
													singleResultTemplate.split("{{id}}").join( 'account_'+id )
													  					.split("{{account_type}}").join(account_type)
													  					.split("{{entity_name}}").join( name)
													  					.split("{{account_number}}").join( id )
													  					.split("{{select}}").join(ap.core_prompts["message.Turnstile.Account.Select"] ) );
	
			this.registerSelectEvent();
		}
	};
	
	/**
	 * Register the select event, the call back function will be passed a reference to the 
	 * selected element and the event 
	 */
	this.registerSelectEvent = function () {
		
		var $self = this ;
		
		$self.searchResultsTableContainer
			 .find('button.select-account')
			 .on('click', function (event) { 
			 				$self.selectCallback( $(this), event );
			 			  } );

	};
	
	/**
	 * account type filter
	 */
	this.addAccountTypeFilter = function(){			
		if(this.applyAccountTypeFilter && ap.account && ap.account.account_type){
			return '&account_type='+ ap.account.account_type;
		}
		
		return '';
	};
	
	/**
	 * Initialize unified account modal search experiance. 
	 * @param searchBoxId - pass in the id of the search input text field.
	 */
	this.initialize = function(searchBoxId, fullSearchActionButtonId, searchResultsTableContainerId, selectCallback,  applyAccountTypeFilter, filtAccount){
		
		if(searchBoxId === undefined) {
			ap.consoleError("Search Text field needs to be provided for initialization.");
			return ;
		} 

		this.selectCallback = selectCallback ;
		this.searchBoxId = searchBoxId; 
		this.searchResultsTableContainer = $('#'+searchResultsTableContainerId);
		this.applyAccountTypeFilter = applyAccountTypeFilter;
	
		//Type ahead
		this.searchBox = $('#' + this.searchBoxId);
		
		var bloodhoundOpts = {
			datumTokenizer: function(d) {
				return [d.value];
			},
			queryTokenizer: Bloodhound.tokenizers.whitespace,
			remote: {
				url: this.autosearchProviderURL,
				replace : function ( url, query){
					var filterString =   (filtAccount && ap.account && ap.account.accountId) ? '&id=-'+ap.account.accountId : '';
					if(filterString == '' && ap.selectedWorkItemAccountId && ap.selectedWorkItemAccountId != '-1' && filtAccount){
						filterString = '&id=-' + ap.selectedWorkItemAccountId;
					}
					if(ap.modalAccountSearchManager){
						filterString +=  ap.modalAccountSearchManager.addAccountTypeFilter();
					}
					ap.consoleInfo("account search filter:" + filterString);
					return url.split("%QUERY").join(query) + filterString;
				},
				filter: function(parsedResponse) {
					var arr = this.renderSolrData(parsedResponse); 
					return arr;
				}.bind(this)
			}
		};
		
		this.suggestionEngine = new Bloodhound(bloodhoundOpts);
		
		//init suggestion engine
		this.suggestionEngine.initialize();
		
		this.searchBox.typeahead({
			minLength: 3,
			highlight: true,
			hint: false
		},
		{
			source: this.suggestionEngine.ttAdapter(),
			displayKey: function(data){
				return data.value;
			}
		})
		.on('typeahead:selected', function(event, suggestion, datasetName) {
			this.getSelectionId(suggestion);
		}.bind(this))
		.on('typeahead:cursorchanged', function(event,suggestion, datasetName){
			event.currentTarget.value = suggestion.name;
		}.bind(this));
		//End Type ahead
	

		var $self = this ; 
		
		$('#'+fullSearchActionButtonId).on('click', function ( e ){
			$self.launchSearch();
		});
	};

	
	this.renderSolrData = function(data) {
		
		var arr = [];
		var searchVal = this.searchBox.val();
		var numDocs = parseInt(data.response.numFound);
		$.each(data.response.docs, function(index, doc) {
			if(index == 4) {
				return;
			}
			var encodedName = ap.htmlEncode(doc.entity_name);
			arr.push({
				value: encodedName + " (#" + doc.account_number + " - " + ((doc.account_type == 'P')? "Personal": "Commercial") + ")",
				id: doc.id,
				name: encodedName,
				searchValue: searchVal,
				account_type: doc.account_type
			});
		});
		
		var numOther = numDocs -4;
		if(numOther > 0) {
			arr.push({value: numOther + " " + (numOther > 1 ? ap.core_prompts["message.Turnstile.Account.Others"] : ap.core_prompts["message.Turnstile.Account.Other"]) , id: "~more", name: '', searchValue: searchVal});
		}
		
		return arr;
		
	};
	
	 	
	this.launchSearch = function(){

		var url = this.searchProviderURL ;
		
		if(ap.modalAccountSearchManager){
			url +=  ap.modalAccountSearchManager.addAccountTypeFilter();
		}
		
		var searchValue = $.trim(this.searchBox.val()); 
		
		if(searchValue.length < 3){			 
			this.hasErrors = true;
			this.searchResultsTableContainer.html(ap.account_management["toolTip.Account.ProvideThreeCharacters"]);
			return;
		}
		
		var $self = this;
		var filterString =  (ap.account && ap.account.accountId) ? '-'+ap.account.accountId : '';
		if(filterString == '' && ap.selectedWorkItemAccountId && ap.selectedWorkItemAccountId != '-1'){
			filterString = '-' + ap.selectedWorkItemAccountId;
		}

		$.post( url, 
				{ 
					'NEXT_PAGE':'/account/accountsList.jsp' , 
					'value':searchValue,
					'id': filterString
				})
		
			.done(function (payload) {
			
				 $self.searchResultsTableContainer.html(payload);
				 
				 // Associate the select button action. 
				 $self.registerSelectEvent();
				
			
			}).fail( function ( payload) {
					ap.consoleError(payload);
			});

	};
	
	this.reset = function () {
		this.searchResultsTableContainer.html('');
		this.searchBox.val(''); 
		
	};
	
     
    this.initialize(arguments[0],arguments[1],arguments[2],arguments[3], arguments[4]); 
};
 

ap.MergeManager =  {
	
	selectAccount :  function ( element, event ) {

		var message = ap.account_management["account.actions.merge.account.confirm"];
		var accountId = element.closest('tr').attr('id').split('_')[1];
		var accountName = element.closest('tr').find('td:eq(1)').html(); 
		var targetAccount = ap.account.accountName;
		message = message.replace("${0}",  ap.htmlDecode(accountName));
		message = message.replace("${1}",  accountId);
		message = message.replace("${2}",  targetAccount);
		
		$('#merge-account-confirm-message').html(message); 
		
		$('#merge-account').modal('hide');
		$('#merge-account-confirm').modal('show');
		
		$('#merge-account-confirm button.btn-primary').off('click');
		$('#merge-account-confirm button.btn-primary').on('click' , function () {			
			ap.account.sendMergeAccountRequest(accountId); 			
		});		
	}
	
};


