
var spinnerSpan = $('<span class="pull-right spinner-container"></span>') ;
var spinnerOpts = {
					  lines: 8, // The number of lines to draw
					  length: 3, // The length of each line
					  width: 4, // The line thickness
					  radius: 2, // The radius of the inner circle
					  corners: 1, // Corner roundness (0..1)
					  rotate: 0, // The rotation offset
					  direction: 1, // 1: clockwise, -1: counterclockwise
					  color: '#fff', // #rgb or #rrggbb or array of colors
					  speed: 1, // Rounds per second
					  trail: 20, // Afterglow percentage
					  shadow: false, // Whether to render a shadow
					  hwaccel: false, // Whether to use hardware acceleration
					  className: 'spinner', // The CSS class to assign to the spinner
					  zIndex: 2e9, // The z-index (defaults to 2000000000)
					  top: '50%', // Top position relative to parent
					  left: '90%' // Left position relative to parent
					};

$(document).ready(function() {

	new ap.ModalAccountSearchManager('move-workitem-search-input', 'move-workitem-search-button', 'move-workitem-search-results-listing', ap.MoveManager.selectAccount, false, true);
	var accountSearchmanager =  new ap.ModalAccountSearchManager('move-account-search-input', 'move-account-search-button', 'move-account-search-results-listing', ap.MoveManager.selectAccount, false, true );
	$('#move-workitem-account-modal .account-search-button').on('click', function(e){

		if($(this).hasClass('active')){
	    	$('#move-workitem-account-modal button').removeAttr('disabled');
			$('#move-account-search').addClass('hidden');
			accountSearchmanager.reset();
			
		}else{
			$('#move-account-search').removeClass('hidden'); 
			$('#move-workitem-account-modal button:not(.account-search-button,.close, #move-account-search-button,.new-account)').attr('disabled','disabled');
		}
	});

	$('#move-workitem-account-modal').on('show.bs.modal', function (e) {
		$('#move-workitem-account-modal .account-search-button').removeClass('active');

    	$('#move-workitem-account-modal button').removeAttr('disabled');
		$('#move-account-search').addClass('hidden');
		accountSearchmanager.reset();
		
	});
	
	$('#move-workitem-account-modal .new-account').on('click', function(e){				
		var spinner = new Spinner(spinnerOpts).spin();
	    $(this).append(spinner.el);
	    
	    var transactionName = ap.selectedWorkItemTransactionId;
		var workItemId = ap.selectedWorkItem;
		var	csrfToken = ap.csrfToken;
		var pageName =   '';
	    if(transactionName === undefined){ 
	    	transactionName = $('#TRANSACTION_NAME').val();
			workItemId = $('#WORKITEMID').val();
			csrfToken = $('#CSRF_TOKEN').val();
			pageName = $('#PAGE_NAME').val();
	    }
	    
		$.post('WorkItemAction', {
			action: 'MoveWorkItems',
			TARGET_ACCOUNT: '-1',
			TRANSACTION_NAME: transactionName,
			SRC_ACCOUNT: '-1',
			WORKITEMID: workItemId,
			CSRF_TOKEN : csrfToken
		},
		function(response, textStatus, jqXHR) {
				
			response = $.trim(response);
			var data = $.parseJSON(response);				
			var url = location.href;
			var index = url.indexOf('DisplayWorkInProgress');
			if(index < 0){
				index = url.indexOf('FrontServlet');
			}
			url = url.substring(0, index);			
			url += 'FrontServlet?PAGE_NAME=accountInformation&TRANSACTION_NAME=account&WORKITEMID='+ data.response.results +'&FIRST_TIME=false&METHOD=Display&CSRF_TOKEN=' + csrfToken;
			url += '&MOVE_TRANSACTIONNAME=' + transactionName +  '&MOVE_WORKITEMID='+ workItemId; 
			if(pageName != ''){
				url += '&MOVE_PAGENAME=' + pageName;
			}
			$('#move-workitem-account-modal').modal('hide');
			$('.spinner-container').remove();	
			location.href = url;						
		})
		.fail(function(data, textStatus, jqXHR) {
			ap.consoleError("Work item move failed - " + textStatus);
			$('.spinner-container').remove();	
		});
	});
	
	$('#move-account-success').on('hidden.bs.modal', function () {
		
		var url = location.href;
		var index = url.indexOf('DisplayWorkInProgress');		
		if(index < 0){//back to work item
			index = url.indexOf('FrontServlet');
			if(url.indexOf("PAGE_NAME")  < 0){
				url = url.substring(0, index);	
        		url += 'FrontServlet?PAGE_NAME='  + $('#PAGE_NAME').val() + '&TRANSACTION_NAME='  + $('#TRANSACTION_NAME').val();
        		url += '&CSRF_TOKEN='  + $('#CSRF_TOKEN').val() + '&WORKITEMID='  + $('#WORKITEMID').val();
        		url += '&FIRST_TIME=false&METHOD=Display';
        	}
			location.href = url;
		}else{   //back to account
			url = url.substring(0, index);			
			url += 'DisplayWorkInProgress?action=Open&WorkListType=AccountItemsView&WORKITEMID=' + ap.selectedAccountId; 
		}
		
		$('.spinner-container').remove();	
		location.href = url;
	
     }); 
		
});

ap.MoveManager =  {
		
	   showMove : function() {
			$('#move-account-search-input').val('');
			$('#move-account-search-results-listing').html('');
			$('#move-workitem-account-modal').modal();
			var title = ap.account_management["account.actions.link.workitem"];
			$('#move-account-confirm .modal-title').html(title);	
			$('#move-account-success .modal-title').html(title);
		},
		
		selectAccount :  function ( element, event  ) {

			var accountId = element.closest('tr').attr('id').split('_')[1];
			var accountName = element.closest('tr').find('td:eq(1)').html(); 
			ap.selectedAccountId = accountId;
			var url = location.href;
			var transactionName = ap.selectedWorkItemTransactionId;
		    var srcAccount = ap.selectedWorkItemAccountId;
			var workItemId = ap.selectedWorkItem;
			var	csrfToken = ap.csrfToken;
		    if(url.indexOf("WorkListType")  < 0){ 
		    	transactionName = $('#TRANSACTION_NAME').val();
			    srcAccount= '0';
				workItemId = $('#WORKITEMID').val();
				csrfToken = $('#CSRF_TOKEN').val();
		    }
		    
		    var moveType = 'LINK';
		    if($('#workitem_move_modal').is(':visible')) { 
		    	moveType='MOVE';
		    }
		    var spinner = new Spinner(spinnerOpts).spin();
		    $('#move-workitem-account-modal .account-search-button').append(spinner.el);
		    $.post('WorkItemAction', {
		    	action: 'MoveWorkItems',
		    	TARGET_ACCOUNT: accountId,
		    	TRANSACTION_NAME: transactionName,
		    	SRC_ACCOUNT: srcAccount,
		    	WORKITEMID: workItemId,
		    	CSRF_TOKEN : csrfToken,
		    	MOVE_TYPE : moveType
		    },
		    function(response, textStatus, jqXHR) {
		    	$('#move-workitem-account-modal').modal('hide');
		    	$('#workitem_move_modal').modal('hide');	
		    	response = $.trim(response);
		    	var data = $.parseJSON(response);		
		    	$('#move-account-success #move-account-success-message').html(ap.htmlDecode(data.response.results.message));
		    	$('#move-account-success').modal('show');
		    	$('#move-workitem-account-modal .account-search-button').find('.spinner-container').remove();

		    })
		    .fail(function(data, textStatus, jqXHR) {
		    	ap.consoleError("Work item move failed - " + textStatus);
		    	$('#move-workitem-account-modal .account-search-button').find('.spinner-container').remove();
		    });
						
		}
};


