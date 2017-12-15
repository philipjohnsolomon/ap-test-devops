

var ap = ap || {};
ap.environment = ap.environment || {}; // Global environment variable store.

/**
 * Agencyport Turnstile widget manager.  
 */
ap.TurnstileWidget = function () {

    "use strict";
	/**
	* Service URL for Turnstile file upload.
	*/
    var turnstileServiceURL = "FileUploadServlet";
    
    /**
     * time interval for seeking new updates from server while there are queued items in the list
     */
    this.refreshTimeout = 3000;
    
    /**
     * Delete pop over template.
     */
    var deletePopoverTemplate = "<p>" + ap.core_prompts["action.DeleteConfirmQuestion"] + "</p> " +
	"<div class='btn-group'>" + 
		"<button type='button' class='btn btn-primary ok' >" +ap.core_prompts["action.Yes"] + "</button>" + 
		"<button type='button' class='btn btn-default cancel' >" +ap.core_prompts["action.No"] + "</button>" + 
	"</div>";

    var deletePopoverTemplateWithGUID = "<p>" + ap.core_prompts["action.DeleteConfirmQuestion"] + "</p> " +
	"<div class='btn-group'>" + 
		"<button type='button' class='btn btn-primary ok' id='{{BGUID}}'>" +ap.core_prompts["action.Yes"] + "</button>" + 
		"<button type='button' class='btn btn-default cancel' >" +ap.core_prompts["action.No"] + "</button>" + 
	"</div>";
    /**
     * File Delete button, click on this will trigger a confirmation pop over to be displayed.
     */
    var fileDeleteAction = '<button type="button" class="btn btn-default delete-popover"  data-toggle="popover" data-placement="left" data-html="true" ' +
    						'data-content="' + deletePopoverTemplate + '">' + ap.core_prompts["action.Delete"] + '</button>';
    
    
    /**
     * Table Row template for files .
     */
    var rowTemplate = '<tr data-guid={{GUID}} ><td class="file-column">{{formName}}</td><td class="date-column">{{lastUpdated}}</td>' +
        '<td class="status-column"> <button type="button" class="btn btn-primary" {{disabled}} data-dismiss="modal" > <span  class="pull-left status-descr" >{{status}}</span>{{spinner-container}}</button></td>' +
        '<td> <button type="button" class="close" aria-hidden="true"   data-toggle="popover" data-placement="left" data-html="true" ' +
        '			data-content="' + deletePopoverTemplateWithGUID + '"><i class="fa"></i></button></td></tr>';
    
    
    /**
     * Table Row template for files with error.
     */
    var rowTemplateWithError = '<tr data-guid={{GUID}} ><td>{{formName}}</td><td>{{lastUpdated}}</td>' +
        '<td> <button type="button" class="btn btn-primary error-close"  aria-hidden="true"   data-toggle="popover" data-placement="{{popovertype}}" data-html="true" ' +
        '			data-content="{{error_message}}"><span  class="pull-left status-descr" >{{status}}</span></button></td>' +
        '<td> <button type="button" class="close" aria-hidden="true"   data-toggle="popover" data-placement="left" data-html="true" ' +
        '			data-content="' + deletePopoverTemplateWithGUID + '"><i class="fa"></i></button></td></tr>';
   
    /**
     * Table Row template for files with error.
     */
    var tdTemplateWithError = '<td>{{formName}}</td><td>{{lastUpdated}}</td>' +
        '<td> <button type="button" class="btn btn-primary error-close"  aria-hidden="true"   data-toggle="popover" data-placement="bottom" data-html="true" ' +
        '			data-content="{{error_message}}"><span  class="pull-left status-descr" >{{status}}</span></button></td>' +
        '<td> <button type="button" class="close" aria-hidden="true"   data-toggle="popover" data-placement="left" data-html="true" ' +
        '			data-content="' + deletePopoverTemplateWithGUID + '"><i class="fa"></i></button></td>';
   
    /**
     * Table Row template for workitems listing .
     */
    var wiListRowTemplate = '<tr class="{{styleClass}}" ><td>{{workItemId}}</td> <td> {{lobTitle}}</td><td>  {{url}} </td></tr>';
    
    
    /**
     * Table Row template for workitems listing .
     */
    var wiListRowTemplateError = '<tr class="{{styleClass}}" ><td>{{workItemId}}</td> <td> {{lobTitle}}</td><td><button type="button" class="btn btn-primary pull-right" aria-hidden="true" data-toggle="popover" data-placement="bottom" data-html="true" ' +
    			'data-content="{{error}}"><span  class="pull-left status-descr">' + ap.core_prompts["action.Error"] + '</span></button></td></tr>';

    /**
     * Header section for Forms Processed.
     */
    var formsHeading = '<div class="list-group-item"><h4 class="list-group-item-heading">' + ap.core_prompts["header.Title.FormsProcesses"] + '</h4></div>';

    /**
     * Header section for Forms Not Processed.
     */
    var formsNotProcessedHeading =	'<div class="list-group-item">'
    							+	'<h4 class="list-group-item-heading toggler forms-not-processed">'
    							+	'<a data-toggle="collapse" data-target=".unprocessed-forms" href="#unprocessed-forms" class="collapsed">'
    							+	'<i class="fa"></i> <span>' + ap.core_prompts["header.Title.FormsNotProcessed"] + ': ' + '{{noforms}}' +'</span></a>'
    							+	'</h4>'
    							+	'<div id="unprocessed-forms" class="{{dropDefault}} unprocessed-forms">{{formsList}}</div>'
    							+	'</div>';
    
    /**
     * Header section for Forms Not Processed.
     */
    var formsNotRecognizedHeading =	'<div class="list-group-item">'
    							+	'<h4 class="list-group-item-heading toggler forms-not-processed">'
    							+	'<a data-toggle="collapse" data-target=".unprocessed-pages" href="#unprocessed-pages" class="collapsed">'
    							+	'<i class="fa"></i><span>' + ap.core_prompts["header.Title.PagesNotRecognized"] + ': ' + '{{noforms}}' + '</span></a>'
    							+	'</h4>'
    							+	'<div id="unprocessed-pages" class="{{dropDefault}} unprocessed-pages">{{formsList}}</div>'
    							+	'</div>';
    
    /**
     * repeating template for the list of forms
     */
    var formsTemplate = '<div class="list-group-item">{{formId}}</div>';

    /**
     * File List Row template.. the table row that displays the file name, size and delete action.
     */
	var fileListRowTemplate = '<tr {{class}} ><td class="file-name">{{fileName}}</td><td class="file-size">{{fileSize}}</td><td class="file-action">{{action}}</td></tr>';
	
	/**
	 * Alert template for file validation
	 */
	var fileUploaderAlertdivTemplate = '<div id="file-uploader-validation-message" class="alert alert-danger">{{message}}</div>';
	
	/**
	 * Alert template for status view
	 */
	var showStatusAlertdivTemplate = '<div id="show-status-validation-message" class="alert alert-danger">{{message}}</div>';
	
	var accountMessageTemplate = '<span>' + "{{message}}" + ' <b>{{accountName}}</b>.</span>'; 
	
	var spinnerSpan = $('<span class="pull-right spinner-container"></span>') ;
	
	
	/**
	 * Currently selected account ID , set from call back of search results.
	 */
	this.currentAccountId = null ;
	
	/**
	 * Progress Spinnner widget options.
	 */
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
	
	/**
	* File upload Data - blueimp object that holds on to the files that are selected
	* for uploading.
	* <code>files</code> holds the files list after a process is applied.
	*/
	this.fileUploadData = null;
	
	this.widgetOpen = false;
	/**
	 * Launch the Turnstile upload widget - Launch point is generally global.
	 * @param accountId  - optional parameter. if present, this has to be a valid account number. 
	 * 	uploaded workitems will be associated with the selected account, identified by the accountID.
	 */
	this.launchUploadWidget = function ( accountId ) {
		this.resetFileuploadSection();
		$("#turnstile-upload-widget").modal('show');
		
		this.currentAccountId = accountId ? accountId : null ; // Note that accountId can be undefined, this condition is utilized when account association decision is made.
	};
	
	
	/**
	 * File upload section reset. 
	 */
	this.resetFileuploadSection = function (){
		
		$("#file-uploader-widget button").attr("disabled", false);
		$("#file-uploader-validation-message").remove();
		$('a[href="#turnstile-files-selector"]').tab('show');
		
		$("#fileupload-file-listing").html('');
		
		this.fileUploadData = null;
	};

 
	
    /**
     * Process the Staged Upload item, Default implementation opens the LOB Transaction list.
     * should a different workflow is desired, override this function and apply your processing logic.  
     * @param guid - the guid associated with the staged item.
     */
    this.processStagedUpload = function(guid){
    	$('#turnstile-file-upload-status').scrollTop(0);
    	this.showLobSelector(guid); 
    };
    
 
    /**
     * Delete a staged item.
     */
    this.deleteStagedItem = function (guid) {

        $.ajax({
            type: "POST",
            url: turnstileServiceURL,
            dataType: "JSON",
            data: {
                'requestType': "delete",
                'guid': guid
            }
        }).always(function () {
                ap.turnstileWidget.showUploadStatus();
           });
    };

	
    
    this.renderUploadStatusTableContent = function ( msg ){

        var innerHTML = '';
        
        msg.list.forEach( function (val, index ) {
    
            if(val.status != 4 ){
            	var tmp = rowTemplate;
            	innerHTML += tmp.split("{{formName}}").join(val.fileName).split("{{lastUpdated}}").join(val.lastUpdateTime)
            	.split("{{disabled}}").join(val.status == 3 ? 'onclick="ap.turnstileWidget.processStagedUpload(\'{{GUID}}\')"' : 'disabled')
            	.split("{{spinner-container}}").join( (val.status == 1 || val.status == 2) ? '<span class="pull-right spinner-container"></span> ' : '')
            	.split("{{status}}").join(val.statusDesc)
            	.split("{{GUID}}").join(val.guid)
            	.split("{{BGUID}}").join(val.guid);
            }else{
            	var tmp = rowTemplateWithError;
            	if (index === msg.list.length - 1) {
            		tmp = tmp.replace("{{popovertype}}","top");
                	
            	} else {
            		tmp = tmp.replace("{{popovertype}}", "bottom")
            	}  
            	innerHTML += tmp.split("{{formName}}").join(val.fileName).split("{{lastUpdated}}").join(val.lastUpdateTime)
            	.split("{{error_message}}").join(val.message)
            	.split("{{GUID}}").join(val.guid)
            	.split("{{BGUID}}").join(val.guid)
            	.split("{{status}}").join(val.statusDesc);
            }
        });
        
       
        $('#turnstile-report-table').html(innerHTML);
        
        
        // Set up the pop over on the close button.
        $('#turnstile-report-table .close').popover()
            .on('shown.bs.popover', function () {
                var $popup = $(this);
                $(this).next('.popover').find('button.cancel').click(function (e) {
                    $popup.popover('hide');
                });
                $(this).next('.popover').find('button.ok').click(function (e) {
                    $popup.popover('hide');
                    ap.turnstileWidget.deleteStagedItem($(this).attr("id"));
                });
			});
        
        var spinner = new Spinner(spinnerOpts).spin();
        $('#turnstile-report-table button .spinner-container').append(spinner.el);
        
        $("#turnstile-report-table").find('[data-toggle="popover"]').each(function () {
            $(this).popover('show');
            $(this).popover('hide');
        });
        
        //close popover while clicking outside
        $('body').on('click', function (e) {
            $('[data-toggle="popover"]').each(function () {
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
                    $(this).popover('hide');
                }
            });
        });
   
    };
    
    
    this.updateUploadStatusTableContent = function (msg, previousMessage) {
    	
    	//check the existing items
    	var $self = this;
    	var dataGuids = $('#turnstile-report-table').find('tr[data-guid]');
    	if(dataGuids.length != msg.list.length){
    		$self.renderUploadStatusTableContent(msg);
    		return;   
    	}
    	
        msg.list.forEach( function (val, index ) {
        	// Previous and current GUID matches - indicating that the indexed element on the list has not changed
        	// this would mean - we can check the status and call for update if needed. 
        	try{
        		if( val.guid === previousMessage.list[index].guid ){
        			if( val.status != previousMessage.list[index].status ){

        				var button = $('#turnstile-report-table tr:eq('+ index +') .btn-primary');
        				button.find('.status-descr').html(val.statusDesc); 

        				if(val.status == 3){
        					button.find('.spinner-container').remove();
        					button.off('click');
        					button.on('click', function ( ){ ap.turnstileWidget.processStagedUpload( val.guid );});
        					button.removeAttr('disabled');
        				}else{        				
        					var tr = $('#turnstile-report-table tr:eq('+ index +')');
        					var tmp = tdTemplateWithError;
        					var innerHTML =  tmp.split("{{formName}}").join(val.fileName).split("{{lastUpdated}}").join(val.lastUpdateTime)
        					.split("{{error_message}}").join(val.message)
        					.split("{{GUID}}").join(val.guid)
        					.split("{{BGUID}}").join(val.guid)
        					.split("{{status}}").join(val.statusDesc);

        					tr.html(innerHTML);
        					$("#turnstile-report-table").find('[data-toggle="popover"]').each(function () {
        						$(this).popover('show');
        						$(this).popover('hide');
        					});

        					// Set up the pop over on the close button.
        					$('#turnstile-report-table .close').popover()
        					.on('shown.bs.popover', function () {
        						var $popup = $(this);
        						$(this).next('.popover').find('button.cancel').click(function (e) {
        							$popup.popover('hide');
        						});
        						$(this).next('.popover').find('button.ok').click(function (e) {
        							$popup.popover('hide');
        							ap.turnstileWidget.deleteStagedItem($(this).attr("id"));
        						});
        					});
        				}
        			}
        		}else{
        			// GUID does not match - abort update operation - call for full re-render.
        			// Not attempting to salvage the table etc as it could be more expensive operation to perform.
        			$self.renderUploadStatusTableContent(msg);
        			return;  // no point in continuing with loop execution. 
        		}
        	}catch(err){
        		$self.renderUploadStatusTableContent(msg);
        		return;   
        	}
        });
        
    };
   
    
    /**
     * Show upload status -  displays the modal dialog with the latest TS processing progress information,
     * 
     */
    this.showUploadStatus = function ( previousMessage) {
    	
    	if(ap.environment.isTurnstileEnabled){
    		var $self = this; 

    		$("#show-status-validation-message").remove();

    		$.ajax({
    			type: "POST",
    			url: turnstileServiceURL,
    			dataType: "JSON",
    			data: {
    				'requestType': "list"
    			}
    		}).done(function (msg) {
    			ap.consoleInfo("Turnstile Status Message status " + msg.status);
    			if (msg.status === 'success') {

    				if(previousMessage){

    					$self.updateUploadStatusTableContent(msg, previousMessage);

    				}else{
    					// Render the list
    					$self.renderUploadStatusTableContent(msg);

    				}
    				var txt = $('a[href="#turnstile-file-upload-status"]').html();
    				if(msg.list.length){


    					$('a[href="#turnstile-file-upload-status"]').html( txt.replace( /\s\((\d+)\)/, "") + " (" + msg.list.length +")" ); 
    					$('#upload-status-count').html(msg.list.length);
    				}else{

    					$('a[href="#turnstile-file-upload-status"]').html( txt.replace( /\s\((\d+)\)/, "") ); 
    					$('#upload-status-count').html("");
    					$('#turnstile-report-table').html("<tr><td>" + ap.core_prompts["label.Template.NoUploadForms"] + "</td></tr>");
    				}

    				if($self.widgetOpen){                
    					setTimeout( function(){ $self.showUploadStatus( msg );}, $self.refreshTimeout);                     
    				}else{
    					ap.consoleInfo('Turnstile widget is closed. Stop updating Turnstile upload status.');
    				}

    			}
    			if(msg.status === 'error'){
    				$('#turnstile-report-table').closest('table').prepend(
    						showStatusAlertdivTemplate.split('{{message}}').join(msg.message) 
    				);
    			}

    		});
    	}
    };

    /**
     * Display the LOB selector modal.
     */
    this.showLobSelector = function (guid) {

    	$('#turnstile-stage-guid').val("");

        $.ajax({
            type: "POST",
            url: turnstileServiceURL,
            dataType: "JSON",
            data: {
                'requestType': "forms",
                'guid': guid
            }
        })
        .done(function (data) {
        	ap.consoleInfo(data);
            var tmpHtml = formsHeading;
            var formsList = data.forms.split(",");

            $.each(formsList, function (key, value) {
                tmpHtml += formsTemplate.split("{{formId}}").join(value);
            });

            $('#forms-list').html(tmpHtml);

            $('#turnstile-transaction-list input[type="checkbox"]').attr('checked', false);
            $('#turnstile-lob-selector').modal();
            $('#turnstile-stage-guid').val(guid);
            
            //form not processed           
            tmpHtml = formsNotProcessedHeading;
            var errorformsList = data.notSupportedForms.split(",");
            var errorFormsHtml = "";
            var numErrors = 0;
            if(errorformsList[0].length == 0){
            	errorFormsHtml += formsTemplate.split("{{formId}}").join("None"); 
            	tmpHtml = tmpHtml.replace("{{dropDefault}}","collapse in");
            	tmpHtml = tmpHtml.replace("{{noforms}}", numErrors);
            }else{
                $.each(errorformsList, function (key, value) {
                	errorFormsHtml += formsTemplate.split("{{formId}}").join(value);
                });  
                numErrors = errorformsList.length;
            	tmpHtml = tmpHtml.replace("{{noforms}}", numErrors);
            	tmpHtml = tmpHtml.replace("{{dropDefault}}","collapse");
            }
           
            tmpHtml = tmpHtml.replace("{{formsList}}", errorFormsHtml);
            $('#error-forms-list').html(tmpHtml);
            
            tmpHtml = formsNotRecognizedHeading;
            
            errorformsList = [];
            var pageCount = 0;
            for(var file in data.notRecognizedForms) {
            	if(!data.notRecognizedForms.hasOwnProperty(file)){
            		continue;
            	}
            	var pages = data.notRecognizedForms[file];
            	pageCount+= pages.length;
            	errorformsList.push(file + ' [' + pages + ']');
            }
            
            errorFormsHtml = "";
            if(errorformsList.length == 0){
            	errorFormsHtml += formsTemplate.split("{{formId}}").join("None"); 
            	tmpHtml = tmpHtml.replace("{{dropDefault}}","collapse in");
            	tmpHtml = tmpHtml.replace("{{noforms}}", pageCount);
            	
            }else{
                $.each(errorformsList, function (key, value) {
                	errorFormsHtml += formsTemplate.split("{{formId}}").join(value);
                }); 
            	tmpHtml = tmpHtml.replace("{{noforms}}", pageCount);
            	tmpHtml = tmpHtml.replace("{{dropDefault}}","collapse");
            }
            tmpHtml = tmpHtml.replace("{{formsList}}", errorFormsHtml)
            $('#unknown-forms-list').html(tmpHtml);
            
        });

    };
    
    
    /**
     * Resets the lightbox, Removes any validation messages and returns scrollbars to top position.
     */
	this.resetLightboxState = function() {
		$('#lob-validation-message').html('');
		$('#lob-validation-message').hide();
		$('#forms-list').scrollTop(0);
	}; 
	
	
    /**
     * Process the Continue of LOB Selection  
     * Override if the workflow needs to be altered. 
     */
    this.processLobSelection = function (){
    	
    	 
    	var $self = this;
    	// Validate that at least one transaction is selected. 
    	if(!$('input[name="transactions"]:checked').length){
    		$('#lob-validation-message').html(ap.core_prompts["prompt.Template.SelectLOB"]);
    		$('#lob-validation-message').show();
    		return false;
    	}
    	
    	this.resetLightboxState();
    	
    	if(ap.environment.isAccountManagementFeatureOn){
    	
    		// Move on to the Account Modals. 
    		$('#turnstile-lob-selector').modal('hide');
        	
    		// if self has an account number, then skip the account number selection. create workitems and 
    		// associate with account at hand. 
    		if( $self.currentAccountId != null ){
    			
    			$self.addProgressIndicatorSpinner($('#turnstile-lob-selector button.continue'));
    	    	$('#turnstile-account-selector button').attr("disabled", "disabled");
    	    	
    			// provide call back to hide the modal
    			this.createWorkItems(function(){ 
    					$self.removeSpinnerControl($('#turnstile-lob-selector button.continue'));
    					$('#turnstile-lob-selector').modal('hide');
    					$self.currentAccountId = null ; // setting back to null.
    				}, $self.currentAccountId );
    		}else{
        		// Move on to the Account Modals. 
        		$('#turnstile-lob-selector').modal('hide');
            	$('#turnstile-account-selector').modal('show');
    		}
        	
    	}else{ 
    		
    		// Set up the spinner and wait for the processing to finish up.
    		$self.addProgressIndicatorSpinner($('#turnstile-lob-selector button.continue'));
        	
        	$('#turnstile-lob-selector button').attr("disabled", "disabled");
        	
        	this.createWorkItems( function() {
        				$('#turnstile-lob-selector').modal('hide');
        				$('#turnstile-lob-selector button').removeAttr("disabled");
        				
        				$self.removeSpinnerControl($('#turnstile-lob-selector button.continue'));
        			});
    	}
    	
    	
    };
    
    /**
     * appends a progress indicator spinner control to the jQuery element object passed in.
     * @param element - jQuery Element on which the spinner is to be attached.
     */
    this.addProgressIndicatorSpinner = function(element){
       	var spinner = new Spinner(spinnerOpts).spin();
    	spinnerSpan.append(spinner.el);
    	element.append(spinnerSpan);
    };
    
    /**
     * Removes a spiner from an element. 
     * @param element - object on which the spinner is attached.
     */
    this.removeSpinnerControl = function(element){
    	element.find('.spinner-container').remove();
    }; 
    
    /**
     * Process cancel action. brings the user back to the status page.
     */
    this.cancelLobSelection = function() {
    	this.resetLightboxState();
    	this.launchUploadWidget( this.currentAccountId);
    };
    
    
    
    /**
     * Indicates if the file upload control has been initialized for the page or not, will be set to true on first access.
     */
    this.fileuploadControlInitialized = false ;
    
    /**
     * The file uploader ( blue imp ) library setup 
     * The file uploader control initialization is done only on modal dialog access. 
     */
    this.setupFileuploaderControls = function ( fileControl, fileDropZone) {
    	if( !this.fileuploadControlInitialized ) {
    		this.fileuploadControlInitialized = true;

    		var $self = this ;
    		/*
    		 * setup blue-imp library
    		 */		
    		$('#'+fileControl).fileupload({
    			url: turnstileServiceURL,
    			dataType: 'json',
    			autoUpload: false,
    			singleFileUploads: false,
    			acceptFileTypes: /(\.|\/)(tiff|pdf|zip)$/i,
    			dropZone : $('#' + fileDropZone),
    			maxFileSize: 15000000} //15 MB
    		).on('fileuploadadd', function (e, data) {
    			
    			$('#file-uploader-validation-message').remove();
    			
    			if(null === $self.fileUploadData ){
    				
    				$self.fileUploadData = $.extend({},data);
    				$self.fileUploadData.files = [];
    			}
    			  
    		}).on('fileuploadprocessalways', function (e, data) {
    			
    			var file = data.files[data.index];
    			var tmpRow, tmpClass, fileName = '';
    			
    			if(file.error){
    				fileName = '<i class="fa fa-exclamation-triangle"  data-toggle="tooltip" data-placement="top" title="'+file.error+'" ></i> '+file.name;
    				tmpClass = 'class="danger"';
    			}else{
    				fileName = file.name;
    			}
    			
    			$self.fileUploadData.files.push(file);
    			
    			var  fileSize = "";
    			if(file && file.size < 1048576 ){
    				fileSize = Math.round(file.size / 1024) + ' KB';
    			}
    			else if(file && file.size >= 1048576) {
    				fileSize = (file.size / 1048576).toFixed(2) + ' MB';
    			}
    			tmpRow = fileListRowTemplate.split("{{fileName}}").join(fileName)
    										.split("{{fileSize}}").join(fileSize)
    										.split("{{class}}").join(tmpClass)
    										.split("{{action}}").join(fileDeleteAction);
    			
    			
    			var fileRow = $(tmpRow);
    			
    			
    			// Initialize the delete pop over and tool tip
    			fileRow.find('button').popover()
    				.on('shown.bs.popover', function () {
    					var $popup = $(this);
    					$(this).next('.popover').find('button.cancel').click(function (e) {
                        $popup.popover('hide');
    				});
                    $(this).next('.popover').find('button.ok').click(function (e) {
                        $popup.popover('hide');
                        ap.turnstileWidget.deleteRow(fileRow);
                    });
    			});
    			
    			fileRow.find('.fa-exclamation-triangle').tooltip();		
    			
    			$("#fileupload-file-listing").append(fileRow);
    	
    			
    		}).on('fileuploadprogressall',function (e, data) {
    			
    			 var progress = parseInt(data.loaded / data.total * 100, 10);
    			 if( !$('#file-uploader-widget div.progress-bar-danger').length){ 
    		        $('#file-uploader-widget .progress-bar').css('width', progress + '%');
    			 }
    		        
    		}).on('fileuploadfail',function (e, data) {
    			 
    			$self.prependAertMessage(data.response().jqXHR.responseJSON.message);
    			$("#file-uploader-widget ").prepend(message);
  
    		}).on('fileuploaddone',function (e, data) {
    			
    			$self.resetFileuploadSection();
    			$('a[href="#turnstile-file-upload-status"]').tab('show');
    			
    		}).on('fileuploaddragover',function (e, data){
    			// Tab is set to lit up to background color 
    			$('#turnstile-files-selector').find(".file-drop-zone").addClass('dropping-in');
    			
    		});
    		
    		// Prevent drag & drop over document 
    		$(document).bind('drop dragover', function (e) {
    		    e.preventDefault();
    		});
    		
    		// lit up drop zone.
    		
    		// turn off the lights when the user leaves the drop zone.
    		
    		$('#turnstile-files-selector').parent().on('dragleave drop', function (e) {
    			$('#turnstile-files-selector').find(".file-drop-zone").removeClass('dropping-in');
    		});
    	}
    };

    var resetAccountSearchModal = function ( accountSearchmanager ){
    	
    	$('#turnstile-account-selector button').removeAttr('disabled');
		$('#turnstile-account-search').addClass('hidden');
		accountSearchmanager.reset();
    };
    
	/**
	* Setup the file upload widget. Initialize the blueimp uploader.
	*/
    this.setup = function (args) {

        if (!args.length) {
            ap.consoleError(ap.core_prompts["message.Template.UploadHandlerElementNotFound"]);
            return;
        }
        
        if(!ap.environment.isTurnstileEnabled){
        	return;
        }
        
        this.showUploadStatus();
        
    	var $self = this;

    	/*
    	 * Event registry  
    	 */ 
    	$('#file-uploader-widget button[type="submit"]').on('click', function(e){ $self.startUpload();}) ;
    	/*
    	 * On Tab show, refresh the list of items.
    	 */
    	$('a[href="#turnstile-file-upload-status"]').on('show.bs.tab', function (e) { $self.showUploadStatus(); });

    	$('#turnstile-lob-selector button.continue').on('click', function(e){ $self.processLobSelection(); });
    	$('#turnstile-lob-selector button.cancel').on('click', function(e){ $self.cancelLobSelection(); });
    	$('#turnstile-lob-selector button.close').on('click', function(e){ $self.resetLightboxState(); });
    	$('#turnstile-upload-widget button.close').on('click', function(e){ $self.resetLightboxState(); });
     
    	var tsSelectAccount =   function ( element, event  ) {

			var accountId = element.closest('tr').attr('id').split('_')[1]; 
			
			ap.consoleInfo("Selected "+accountId+" account for turnstile attach");
			
			$self.currentAccountId = accountId ; // Set up the current account selection. 
			$self.createWorkItemsWithAccount($self.currentAccountId); 
			$self.currentAccountId = null;
    	
    	 };
    		 
    	
    	var accountSearchmanager = new ap.ModalAccountSearchManager('turnstile-account-search-input', 'turnstile-account-search-button', 'turnstile-account-search-results-listing',  tsSelectAccount, false );
    	
    	
    	this.setupFileuploaderControls(args[0],args[1]);
	
		
		// Prevent drag & drop over document 
		$(document).bind('drop dragover', function (e) {
		    e.preventDefault();
		});
		
		$('#turnstile-files-selector').parent().on('dragleave drop', function (e) {
			$('#turnstile-files-selector').parent().removeClass('drop-in'); 
		});
			
		/*
		 * Account Search toggle click - active and inactive state handling.
		 */
		$('#turnstile-account-selector .account-search-button').on('click', function(e){
			
			if($(this).hasClass('active')){
				resetAccountSearchModal(accountSearchmanager);
			}else{
				$('#turnstile-account-search').removeClass('hidden'); 
				$('#turnstile-account-selector button:not(.account-search-button,.close, #turnstile-account-search-button,.no-account,.new-account)').attr('disabled','disabled');
			}
		});
		
		$('#turnstile-account-selector').on('show.bs.modal', function (e) {
			$('#turnstile-account-selector .account-search-button').removeClass('active');
			resetAccountSearchModal(accountSearchmanager);
		});
		
		if($('ul.get-started').length > 0){			
			
			$('ul.get-started').on('shown.bs.dropdown', function (e) { 
				$self.widgetOpen = true;
				$self.showUploadStatus(); 
				ap.consoleInfo('Get-Started:  Start Turnstile upload status update.');
			});
			
			$('ul.get-started').on('hidden.bs.dropdown', function (e) { 				
				ap.consoleInfo('Get-Started: Stop Turnstile upload status update.');
				$self.widgetOpen = false;
			});
		}

		$('#turnstile-upload-widget').on('show.bs.modal', function (e) {
			$self.widgetOpen = true;
			$self.showUploadStatus(); 
			ap.consoleInfo('Turnstile Widget is open. updating Turnstile upload status.');
		});

		$('#turnstile-upload-widget').on('hidden.bs.modal', function (e) {
			$self.widgetOpen = false;
		});
	};
	

	this.deleteRow = function (element) {
		var ix = $(element).index();
		this.fileUploadData.files.splice(ix,1);
		$(element).remove();
		$("#file-uploader-validation-message").remove();
	};
	
	this.startUpload = function () {
		 
		// get rid of any old messages
		$("#file-uploader-validation-message").remove();
		
		// validate - at least one file is needed for uploads
		if(null === this.fileUploadData ||	!this.fileUploadData.files.length){
			this.prependAertMessage(ap.core_prompts["prompt.Template.SelectAFile"]);		
			return false;
		}
		// does any of the files have errors ?
		if (this.fileUploadData.files.filter( 
				function (file) { return file.error; }).length ){
			
			this.prependAertMessage(ap.core_prompts["prompt.Template.FixErrors"]);
			return false;
		}
		
		// disable the buttons before file transmission
		$("#file-uploader-widget button").attr("disabled", true);
		
		this.fileUploadData.submit(); 
		// enable the buttons back . 
		$("#file-uploader-widget button").attr("disabled", false);
	};
	
	
	/**
	 * Create work items and associate with <b>NEW</b> account 
	 * Account ID sent to back end is -1. 
	 */
	this.createWorkItemsAndAccount = function(){
    	
    	var $self = this;
    	
    	$self.addProgressIndicatorSpinner($('#turnstile-account-selector button.new-account'));
    	$('#turnstile-account-selector button').attr("disabled", "disabled");
    	
		// provide call back to hide the modal
		this.createWorkItems(function(){ 
			
			$self.removeSpinnerControl($('#turnstile-account-selector button.new-account')); 
			$self.resetAccountModal();
				$('#turnstile-account-selector').modal('hide');
			}, '-1' );
				
	};
	
	/**
	 * Create work itmes with account 
	 * @param accountId the account id that is used to associate the work items that are created.  
	 */
	this.createWorkItemsWithAccount = function(accountId){

		var $self = this;
     
    	$('#turnstile-account-selector button').attr("disabled", "disabled");
    	
		// provide call back to hide the modal
		this.createWorkItems(function(){ 
			$self.resetAccountModal();
				$('#turnstile-account-selector').modal('hide');
			}, accountId );
		
	};
	
	
	this.resetAccountModal = function () {
		this.removeSpinnerControl($('#turnstile-account-selector button.new-account'));
    	$('#turnstile-account-selector button.account-search-button').removeClass('active');
		$('#turnstile_account_searchInput').val('');
		$('#turnstile-account-search').addClass('hidden');
		$('#turnstile-account-selector button').removeAttr("disabled");
		
	};
	
	/**
	 * Create work Items without accounts. 
	 */
	this.continueWithoutAccount = function () {
		//Add a spinner .. 
		var $self = this;
		
		$self.addProgressIndicatorSpinner($('#turnstile-account-selector button.no-account'));
    	
     	$('#turnstile-account-selector button').attr("disabled", "disabled");
    	
		// provide call back to hide the modal
		this.createWorkItems(function(){ 
			$self.removeSpinnerControl($('#turnstile-account-selector button.no-account'));
				$self.resetAccountModal();
				$('#turnstile-account-selector').modal('hide');
			} );
	};
	
	/**
	 * Create Workitems without an account. 
	 * GUID and Transaction list is retrieved from hidden LOB modal.
	 * @param callback the call back function to be executed on done 
	 * @param accountId - the account ID to which the work items created are to be attached, 
	 * 			accountId -> undefined => createWorkitems without account
	 * 			accountId -> -1        => Create a new Account and associate the work items to that account.
	 * 			accountId -> ####      => Create new work items and attach to the account identified by account id.
	 */
	this.createWorkItems = function( callback , accountId){
		
		var action = (accountId === undefined) ?  'createworkitems':'createworkitemsandaccount';
		
		var accId = (accountId === undefined) ? '' : accountId ;

		$("#turnstile-processed-lob-listing").html("");
		$("#turnstile-processed-message").html("");
				
		var guid = $('#turnstile-stage-guid').val();
		var tranactions =  [];
		
		var $self = this; 
	 	
		$('input[name="transactions"]:checked').map(function(){return tranactions.push(this.value);});
		
	       $.ajax({
	            type: "POST",
	            url: turnstileServiceURL,
	            dataType: "JSON",
	            data: {
	                'requestType': action,
	                'guid': guid,
	                'transactions': tranactions.join(","),
	                'accountid':accId
	            }
	        }).done(function (msg) {
	        	
	        	if(callback && typeof callback === 'function' ){
	        		callback();
	        	}
	        	if(msg.code === "LobNotFound"){
	        		 $('#lob-validation-message').html(msg.message);
		        	 $('#lob-validation-message').show();
		        	 $('#turnstile-lob-selector ').modal('show');
		        	  
	        	}
	        	else{
	        	 	$self.renderWorkitemsList(msg);
		        	$self.showUploadStatus();	  
		        	$('#turnstile-lob-selector .alert-danger').hide()
	        	}
	        	
	            	
	        }).fail(function (msg){
	        	
	        	if(callback && typeof callback === 'function' ){
	        		callback();
	        	}
	        	 
	        	$('#turnstile-error-modal .alert-danger').html(msg.responseJSON.message);
	        	$('#turnstile-error-modal').modal('show');
	        	
	        	$self.showUploadStatus();
	        	
	       });
	};
	/**
	 * Counts number of workitems in the processed list.
	 */
	this.countWorkItems = function(msg) {
		var workItemCount = 0;
		msg.workitems.forEach( function (item){
			workItemCount++;
		});
		return workItemCount;
	}
	
	/**
	 * Count number of errors in workitems list allowing to change message accordingly.
	 */
	this.countErrors = function (msg) {
		var count = 0;
		msg.workitems.forEach( function (item) {
			if( item.status === 'Error'){
				count++;
			}
		});
		return count;
	};
	/**
	 * Render a work items list post the TS processing and creating the workitems in the system
	 */
	this.renderWorkitemsList = function ( msg ){
    	
		var account = msg.workitems.filter( function (item ){ return item.lobCd === 'ACCOUNT';});
		var errorCount = this.countErrors(msg);
		var workItemCount = this.countWorkItems(msg);
		if(account.length){
			//Account creates an additional workitem not looking for errors in the account. Therefore decrementing the workitem count by 1 in account scenarios.
			workItemCount = --workItemCount;
			if( errorCount === workItemCount){
				accountMessageTemplate = accountMessageTemplate.replace("{{message}}", ap.core_prompts["message.Turnstile.message.submittedUnSuccesfulToAccount"]);
				$("#turnstile-processed-message").append(
						accountMessageTemplate.split("{{accountName}}").join(account[0].entityName + " #"+account[0].workitemid)
						.split("{{url}}").join(account[0].url)
						);
			}
			else if(errorCount > 0){
				accountMessageTemplate = accountMessageTemplate.replace("{{message}}", ap.core_prompts["message.Turnstile.message.submittedSuccesfulToAccountWithError"]);
				$("#turnstile-processed-message").append(
						accountMessageTemplate.split("{{accountName}}").join(account[0].entityName + " #"+account[0].workitemid)
											  .split("{{url}}").join(account[0].url)
						);
			}
			else {
				accountMessageTemplate = accountMessageTemplate.replace("{{message}}",ap.core_prompts["message.Turnstile.message.submittedSuccesfulToAccount"]);
				$("#turnstile-processed-message").append(
						accountMessageTemplate.split("{{accountName}}").join(account[0].entityName + " #"+account[0].workitemid)
											  .split("{{url}}").join(account[0].url)
						);
			}
		}else{
			if(errorCount === workItemCount){
				$("#turnstile-processed-message").html(ap.core_prompts["message.Turnstile.message.submittedUnSuccesfulNoAccount"]);
			}
			else if (errorCount > 0) {
				$("#turnstile-processed-message").html(ap.core_prompts["message.Turnstile.message.submittedSuccesfulNoAccountWithError"]);
			}
			else{
				$("#turnstile-processed-message").html(ap.core_prompts["message.Turnstile.message.submittedSuccesfulNoAccount"]);
			}
		}
		
		if($("#open-acct-button") != null){
			$("#open-acct-button").remove();
		}
		msg.workitems.forEach( function (item) {
    		
			if( 'ACCOUNT' !=  item.lobCd) {
			
	    		var wiId = item.workitemid;
	    		if(item.status ==='Error'){
	    			wiId = '<i class="fa fa-exclamation-triangle" ></i>';
	    			$("#turnstile-processed-lob-listing").append(
	    					wiListRowTemplateError.split("{{workItemId}}").join( wiId )
	        						 .split("{{lobTitle}}").join(item.lobDesc)
	        						 .split("{{styleClass}}").join("danger")
	        						 .split("{{error}}").join(item.message));	    
	    		}else{
		    		var url = '<a href="' + item.url +'"' +  'class="btn btn-primary pull-right"' + 'target="_self" >' + ap.core_prompts["action.Open"] + '</a>' ;  	    		
	    			$("#turnstile-processed-lob-listing").append(
	    					wiListRowTemplate.split("{{workItemId}}").join( wiId )
	        						 .split("{{lobTitle}}").join(item.lobDesc)
	        						 .split("{{styleClass}}").join("")
	        						 .split("{{url}}").join(url));	    		
	    		}	    		
			}
    		 
    	});

		$("#turnstile-processed-lob-listing").find('[data-toggle="popover"]').each(function () {
            $(this).popover('show');
            $(this).popover('hide');
        });
		
		$('#turnstile-workitem-selector').modal('show');
		$('#turnstile-workitem-selector').on('hidden.bs.modal', function (e) {
			
			var url = window.location.href;
			if(url.indexOf('AccountItemsView') > -1 || url.indexOf('WorkItemsView') > -1){
				window.location.reload(true);
			}
		});

		
		$('body').on('click', function (e) {
	            $('[data-toggle="popover"]').each(function () {
	                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
	                    $(this).popover('hide');
	                }
	            });
	    });    	
	};
	
	/**
	 * Helper function to prepend alert messages for file upload.
	 */
	this.prependAertMessage = function(message) {
		$("#file-uploader-widget").prepend( fileUploaderAlertdivTemplate.split("{{message}}").join( message ) );	
	};
	
    this.setup(arguments);

};


$(function () {
    ap.turnstileWidget = new ap.TurnstileWidget("fileupload_blueimp","turnstile-files-selector");
});