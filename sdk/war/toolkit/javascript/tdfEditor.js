/**
 * @fileoverview This file contains the transaction definition product definition
 * editor.  This will render an existing TDF/Page library file for editing.
 * @author Rob Warner rwarner@agencyport.com
 * @version 0.1
 */
/**
 * Constructs a new TDF editor object.
 * @constructor
 * @class The TDFEditor class sets up the editor for any TDF or page library files
 * for a given LOB.
 * @return A new TDFEditor instance
*/
dojo.declare("TDFEditor",Editor, {
	constructor: function (product, artifactId, artifactType) {

	},


	/**
	 * When a tab is focused hook point to do any processing.
	 * In this case we register the auto complete widget
	 * @param item is the item clicked or the current item being processed
	 * @param event is the click event details
	 */
	onFocusTabEvent: function(item, event) {
		//used if we need a hook when a user clicks on a palette tab
	},

	loadOptionList: function(item) {
		// grab the DOM element containing the option list
		var optionListContainer = dojo.byId(item.id);
		var optionListPath = item.id.split('_')[0];

		// if the container length is not zero then list has been loaded already.
		// we do not want to reload the list on the click which 'closes' the option list.
		if( optionListContainer.length != 0 )
			return;

		var successHandler = function(optionListContainer){
									return function(response){
										var options = dojo.trim(response);
										
										//As long as there are options returned from the server load them
										//Custom lists don't return any values.....
										if (options.length > 0) {
									    	var node = dojo.place(dojo.trim(response),optionListContainer);
									    }
										toolkitPleaseWait(false);
									};
								};

		// create the ToolkitRequest
		var request = new ToolkitRequest('loadOptionList',
								{
								 'action': 'loadOptionList',
								 'path': optionListPath
								},
								this,
								successHandler(optionListContainer),
								this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	dataEntryFieldChangeHandler: function(item){

		var node = item.domNode;

		if(dojo.hasClass(item,'optionListRefresh')) {
			var itemId = item.id;
			var path = itemId.split('_')[0];
			var clickedElement = dojo.byId(itemId);
			var targetBasePath = itemId.split('.@source')[0];
			var targetPath = targetBasePath + ".@target";
			var clickedElementValue = clickedElement.value;

			var successHandler = function(targetPath){
									return function(response){
										var targetElement = dojo.byId(targetPath);
										dojo.empty(targetElement);
										dojo.place(dojo.trim(response), targetElement);
								    };
							    };

			//Create the ToolkitRequest
			var request = new ToolkitRequest('refreshList',
											 {'path': targetBasePath, 'action': 'refreshList',
											 'selectedValue' : clickedElementValue},
											 this,
											 successHandler(targetPath),
											this.ajaxFailureHandler);
			//Register the request with ajax manager
			ap.AjaxManager.processRequest(request);
			  return false;
		} else if(dojo.hasClass(item,'moveDialogRefresh')) {
			this.handleMoveDialogRefresh(item);
		} else if(dojo.hasClass(item,'tdfListRefresh')) {
			this.handleTDFListRefresh(item);
		} else if(dojo.hasClass(item,'refreshXarcRulesList')){
			this.handleXARCListRefresh(item);
		} else if(dojo.hasClass(item,'formatMaskSelector')) {
			this.showOptions(item);
			this.cleanUpFormatMask(item);
		} else if (node && dojo.hasClass(node,'connectorTitleRefresh') ){
			var labelPath = item.id + "_label";
			var labelNode = dojo.byId(labelPath);
			labelNode.innerHTML = item.value;

			return false;
		}
	},

	/**
	* Function that handles clean up of format masks based on select list value.  If the select list
	* has a value then don't delete the format mask otherwise remove it.
	*
	**/
	cleanUpFormatMask: function(item) {

		var path = item.id;
		var baseFormatPath = path.split('.@type')[0];
		var formatDeletePath = baseFormatPath + '.@delete';

		if (item.value) {
			dojo.byId(formatDeletePath).value = 'false';
		} else {
			dojo.byId(formatDeletePath).value = 'true';
		}
		
		if (item.value == 'customNumeric') {
			var customMaskField = dojo.byId(baseFormatPath + '.customMask');
			var customNumericField = dojo.byId(baseFormatPath + '.' + item.value);
			customMaskField.name = "";
			customMaskField.value = "";
			customNumericField.name = baseFormatPath;			
		}
		
		if (item.value == 'customMask') {
			var customNumericField = dojo.byId(baseFormatPath + '.customNumeric');
			var customMaskField = dojo.byId(baseFormatPath + '.' + item.value);
			customNumericField.name = "";
			customNumericField.value = "";
			customMaskField.name = baseFormatPath;
		}
	},

	onClickEvent: function(item, event) {
		if(dojo.hasClass(item, 'deleteRowAction')) {
			  this.deleteRow(item);
		} else if(dojo.hasClass(item,'editorOptionListLoad')) {
			this.loadOptionList(item);
		} else if(dojo.hasClass(item,'move_event')) {
			ap.master.save();
			ap.master.hasUnsavedChanges = false;
			this.loadMoveDialog(item);
		} else if(dojo.hasClass(item,'copy_event')) {
			ap.master.save();
			ap.master.hasUnsavedChanges = false;
			this.loadCopyDialog(item);
		}
	},

	/**
	 * Add page to the top level accordion. We do need to differentiate between tdf and transaction
	 * adds in that the title attribute is not supported at the transaction level.  This forces us
	 * to set the default title value if the type is importPage.
	 * @param path path of entity.
	 * @param addType the type and url to the jsp.
	 *
	 */
	addPage: function addPage(path, action, type) {
		// grab the DOM element containing the current pages
		var pageContainer = dojo.byId('accordion_container');

		var successHandler = function(pageContainer,path,type){
									return function(response){
									    var node = dojo.place(dojo.trim(response),pageContainer);
									    ap.master.accordion.addAccordion(node);
									    ap.master.accordion.openPane(node);
									    ap.master.loadMenu(node.id.split('_')[0]);
									    ap.master.loadPalette(node.id.split('_')[0]);
										this.hasUnsavedChanges = true;
										toolkitPleaseWait(false);
									};
								};

		// create the ToolkitRequest
		var request = new ToolkitRequest('addEntity',
								{'artifactType': 'codeList',
								 'action': action,
								 'path': path,
								 'type': type
								},
								this,
								successHandler(pageContainer,path,type),
								this.ajaxFailureHandler);

		//request.url = 'toolkit/transactiondefinition/editor/' + addType + '.jsp';
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Adds a page element within an existing page level accordions
	 * @param path path of page element.
	 * @param action action to trigger page element add
	 * @param type type of page element to add
	 */
	addPageElement: function addPageElement(path, action, type) {
		// path comes in as page[index].pageElement
		var pageIndex = path.split('.')[0];

		// grab the DOM element containing the page elements.
		var pageElementContainer = dojo.byId(pageIndex + '_Sections_content');
		
		toolkitPleaseWait(true);

		var successHandler = function(pageElementContainer){
								return function(response){
									var place = 'last';
									if('tips' === type) {
										place = 'first';
									}
									var node = dojo.place(dojo.trim(response),pageElementContainer, place);
									ap.master.pageElementAccordion.addAccordion(node, place);
								    ap.master.pageElementAccordion.openPane(node);
									ap.master.loadMenu(node.id.split('_')[0]);
								    ap.master.loadPalette(node.id.split('_')[0]);
								    this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addPageElement',
							{'action': action,
							 'type': type,
							 'path': path
							},
							this,
							successHandler(pageElementContainer),
							this.ajaxFailureHandler);

		//request.url = 'toolkit/codelists/option.jsp?artifactType=codeList&action=add';
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Adds a field element within an existing page element level accordion
	 * @param path path of field element.
	 * @param action action to trigger field element add
	 * @param type type of field element to add
	 */
	addFieldElement: function addFieldElement(path, action, type) {
		// grab the DOM element containing the field elements.
		var fieldElementContainer = dojo.byId(path + '_container');

		toolkitPleaseWait(true);

		var successHandler = function(fieldElementContainer){
								return function(response){
									var node = dojo.place(dojo.trim(response),fieldElementContainer);
									ap.master.loadMenu(node.id.split('_')[0]);
								    ap.master.loadPalette(node.id.split('_')[0]);
								    this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addFieldElement',
							{'action': action,
							 'type': type,
							 'path': path
							},
							this,
							successHandler(fieldElementContainer),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Add new connector or instruction on either the display or process side.
	 * @param path is the denoting where to add connector or instruction.
	 * @param action is the action is trigger on the server side.
	 * @param type is the connector or instruction type attribute to be added.
	 *
	 */
	addConnector: function addConnector(path, action, type ) {
		var connectorContainer = dojo.byId(path + '_container');

		toolkitPleaseWait(true);

		var successHandler = function(connectorContainer){
								return function(response){
									var node = dojo.place(dojo.trim(response),connectorContainer);
								    this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addConnector',
							{'action': action,
							 'type': type,
							 'path': path
							},
							this,
							successHandler(connectorContainer),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Adds a field helper within an existing field element level accordion
	 * @param path path of field helper.
	 * @param action action to trigger field helper add
	 * @param type type of field helper to add
	 */
	addFieldHelper: function addFieldHelper(path, action, type) {
		// grab the DOM element containing the field helpers
		var fieldHelperContainer = dojo.byId(path + '_container');

		toolkitPleaseWait(true);

		var successHandler = function(fieldHelperContainer){
								return function(response){
									var node = dojo.place(dojo.trim(response),fieldHelperContainer);
								    this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addFieldHelper',
							{'action': action,
							 'type': type,
							 'path': path
							},
							this,
							successHandler(fieldHelperContainer),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Adds values to a given select list field element level
	 * @param path path of select list field element.
	 * @param action action to trigger
	 * @param type type of value to add
	 */
	addValues: function addValues(path, action, type) {
		// grab the <table> DOM element containing palette for values for the field element
		var paletteContainer = dojo.byId(path + '.optionList');
		var targetPaletteBasePath = path.split('.optionList')[0];
		var targetPalettePath = targetPaletteBasePath + '_Values';
		var contentToShow = targetPaletteBasePath + '_Values_palette';

		toolkitPleaseWait(true);

		var successHandler = function(paletteContainer,targetPalettePath,contentToShow){
								return function(response){
									var node = dojo.place(dojo.trim(response),paletteContainer);
									focusTab.call(this,contentToShow,targetPalettePath);
								    this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addValues',
							{'action': action,
							 'type': type,
							 'path': path
							},
							this,
							successHandler(paletteContainer,targetPalettePath,contentToShow),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Adds a roster element to a given roster field element level
	 * @param path path of roster field element.
	 * @param action action to trigger
	 * @param type type of roster element to add, either join or column
	 */
	addRosterElement: function addRosterElement(path, action, type) {
		// grab the <table> DOM element containing palette for values for the field element
		var rosterElementContainer = dojo.byId(path + '_container');

		toolkitPleaseWait(true);

		var successHandler = function(rosterElementContainer){
								return function(response){
									var node = dojo.place(dojo.trim(response),rosterElementContainer);
								    this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addRosterElement',
							{'action': action,
							 'type': type,
							 'path': path
							},
							this,
							successHandler(rosterElementContainer),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Adds a XARC rule to connector palette.
	 * @param path path of xarc rule.
	 * @param action action to trigger
	 * @param type type
	 */
	addXARCRule: function addXARCRule(path, action, type) {
		// grab the <tbody> DOM element containing palette for xarc rules
		var xarcRuleContainer = dojo.byId(path + '_container');

		toolkitPleaseWait(true);

		var successHandler = function(xarcRuleContainer){
								return function(response){
									var node = dojo.place(dojo.trim(response),xarcRuleContainer);
									var connectorPath = node.id.split('.xarcRules')[0];
									var connectorPalette = dojo.byId(connectorPath + '_palette');
									this.createEvents(connectorPalette);
								    this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addXARCRule',
							{'action': action,
							 'type': type,
							 'path': path
							},
							this,
							successHandler(xarcRuleContainer),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Adds an execute when triggering action
	 * @param path path of execute when
	 * @param action action to trigger
	 * @param type type
	 */
	addExecuteWhen: function addExecuteWhen(path, action, type) {
		// grab the <tbody> DOM element containing palette for execute
		var executeWhenContainer = dojo.byId(path + '_container');

		toolkitPleaseWait(true);

		var successHandler = function(executeWhenContainer){
								return function(response){
									var node = dojo.place(dojo.trim(response),executeWhenContainer);
									var connectorPath = node.id.split('.executeWhen')[0];
									var connectorPalette = dojo.byId(connectorPath + '_palette');
									this.createEvents(connectorPalette);
								    this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addExecuteWhen',
							{'action': action,
							 'type': type,
							 'path': path
							},
							this,
							successHandler(executeWhenContainer),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Adds a validation and sets palette focus.
	 * @param path path of validation.
	 * @param action action to trigger
	 */
	addValidation: function addValidation(path, action) {

		var type = action.split('-')[1];
		var validationContainer = dojo.byId(path + '_container');
		var targetPaletteBasePath = path.split('.validation')[0];
		var targetPalettePath = targetPaletteBasePath + '_Validations';
		var contentToShow = targetPaletteBasePath + '_Validations_palette';

		var successHandler = function(validationContainer,type,targetPalettePath,contentToShow){
							return function(response){
								var node = dojo.place(dojo.trim(response),validationContainer);
								var nodeId = node.id.replace("_wrapperDiv", "");
								toolkitPleaseWait(false);
								this.hasUnsavedChanges = true;
								focusTab.call(this,contentToShow, targetPalettePath);
								ap.master.dialog = new ToolkitDialogBox('toolkitDialogForm', 'validation',
									null, 'Toolkit?action=loadValidationDialog&type=' + type + '&path=' + nodeId +
										'&product=' + this.product + '&artifactId=' + this.artifact, true, nodeId);
							};
						};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addValidation',
							{'action': 'addValidation', 'path': path, 'type' : type},
							this,
							successHandler(validationContainer,type,targetPalettePath,contentToShow),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);


		return true;
	},

	/**
	 * Adds a validation and sets palette focus.
	 * @param path path of validation.
	 * @param action action to trigger
	 */
	addCorrection: function addCorrection(path, action) {

		var type = action.split('-')[1];
		var correctionContainer = dojo.byId(path + '_container');

		var targetPaletteBasePath = path.split('.correction')[0];
		var targetPalettePath = targetPaletteBasePath + '_Corrections';
		var contentToShow = targetPaletteBasePath + '_Corrections_palette';

		var successHandler = function(correctionContainer,type,targetPalettePath,contentToShow){
							return function(response){
								var node = dojo.place(dojo.trim(response),correctionContainer);
								var nodeId = node.id.replace("_wrapperDiv", "");
								toolkitPleaseWait(false);
								this.hasUnsavedChanges = true;
								focusTab.call(this,contentToShow, targetPalettePath);
								ap.master.dialog = new ToolkitDialogBox('toolkitDialogForm', 'correction',
									null, 'Toolkit?action=loadCorrectionDialog&type=' + type + '&path=' + nodeId +
										'&product=' + this.product + '&artifactId=' + this.artifact, true, nodeId);
							};
						};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addCorrection',
							{'action': 'addCorrection', 'path': path, 'type' : type},
							this,
							successHandler(correctionContainer,type,targetPalettePath,contentToShow),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);


		return true;
	},
	/**
	 * Opens the move dialog in response to a click event
	 * @param item
	 */
	loadMoveDialog: function loadMoveDialog(item) {
		var path = item.id.split('_')[0];
		var moveType = item.id.split('_')[1];

		ap.master.dialog = new ToolkitDialogBox('toolkitDialogForm', 'move', null,
											'Toolkit?action=loadMoveDialog&moveType=' + moveType +
											'&path=' + path +
											'&product=' + this.product +
											'&artifactId=' + this.artifact,
											true, path);

		return true;
	},

	/**
	 * Handles refreshing lists after a move dialog select list value
	 * was changed.  Change event is being triggered in the dialog.
	 *
	 * @param item
	 */
	handleMoveDialogRefresh: function handleMoveDialogRefresh(item) {
		// determine the selected value: i.e. page[0].pageElement[1]
		var refreshFromPath = dojo.byId(item.id).value;

		// determine the target type to refresh and
		// find the correct refresh target in the DOM
		var refreshTargetType = item.id.split('_')[1];
		var refreshTargetClass = '.' + refreshTargetType + '_refresh_target';

		// grab the pageElement and fieldElement lists
		var pageElementList = null;
		var fieldElementList = null;


		if(refreshTargetType === 'page') {
			// page list triggered the change event but we might not have both
			// field element and page elemenet lists within dialog
			// e.g. will only have page element list we're moving a page element.
			pageElementList = dojo.byId(item.id.split('_')[0] + '_pageElement') || null;

			if(pageElementList) {
				fieldElementList = dojo.byId(item.id.split('_')[0]);
			} else {
				pageElementList = dojo.byId(item.id.split('_')[0]);
				fieldElementList = null;
			}
		} else {
			pageElementList = null;
			fieldElementList = dojo.byId(item.id.split('_')[0]);
		}

		// grab the list to refresh
		var selectListToRefresh = dojo.query(refreshTargetClass,'toolkitDialog')[0];

		// determine the move dialog type and pass via post
		var moveDialogType = dojo.byId(item.id.split('.@')[0] + '.@type').value;

		var successHandler = function(pageElementList, fieldElementList){
									return function(response){
										var node = dojo.create('div', {"id": "refreshOptions", 'innerHTML': dojo.trim(response)});
										var pageElementOptions = dojo.query('> #pageElementOptions', node)[0];
										var fieldElementOptions = dojo.query('> #fieldElementOptions', node)[0];

										if(pageElementList) {
											dojo.empty(pageElementList);
											dojo.place(dojo.trim(pageElementOptions.innerHTML), pageElementList);
										}

										if(fieldElementList) {
											dojo.empty(fieldElementList);
											dojo.place(dojo.trim(fieldElementOptions.innerHTML), fieldElementList);
										}
									};
								};

		// create the ToolkitRequest
		var request = new ToolkitRequest('refreshMoveDialogList',
								{
								 'action': 'refreshMoveDialogList',
								 'path': refreshFromPath,
								 'moveDialogType' : moveDialogType
								},
								this,
								successHandler(pageElementList, fieldElementList),
								this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	handleXARCListRefresh: function (item) {
		var ruleLibraryList = item;
		var selectedRuleLibrary = ruleLibraryList.value;
		var path = item.id.split('.@')[0];
		var targetPath = path + '.@ruleId';

		var successHandler = function(targetPath){
								return function(response){
									var targetElement = dojo.byId(targetPath);
									dojo.empty(targetElement);
									dojo.place(dojo.trim(response), targetElement);
							    };
						    };

		//Create the ToolkitRequest
		var request = new ToolkitRequest('refreshXarcRulesList',
										 {
										  'path': path,
										  'action': 'refreshXarcRulesList',
										  'selectedRuleLibrary' : selectedRuleLibrary
										 },
										 this,
										 successHandler(targetPath),
										 this.ajaxFailureHandler);
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	handleTDFListRefresh: function handleTDFListRefresh(item) {
		var pageLibraryList = item;
		var selectedPageLibrary = pageLibraryList.value;
		var path = item.id.split('.')[0];
		var targetPath = path + '.@id';

		var successHandler = function(targetPath){
								return function(response){
									var targetElement = dojo.byId(targetPath);
									dojo.empty(targetElement);
									dojo.place(dojo.trim(response), targetElement);
							    };
						    };

		//Create the ToolkitRequest
		var request = new ToolkitRequest('refreshTDFList',
										 {
										  'path': path,
										  'action': 'refreshTDFList',
										  'selectedPageLibrary' : selectedPageLibrary
										 },
										 this,
										 successHandler(targetPath),
										 this.ajaxFailureHandler);
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Opens the copy field dialog in response to a click event
	 * @param item
	 */
	loadCopyDialog: function loadCopyDialog(item) {
		var path = item.id.split('_')[0];

		ap.master.dialog = new ToolkitDialogBox('toolkitDialogForm', 'copyField', null,
											'Toolkit?action=loadCopyDialog' +
											'&path=' + path +
											'&product=' + this.product +
											'&artifactId=' + this.artifact,
											true, path);

		return true;
	},
	
	openEditorToPath: function(path) {
		// if there is no period as a path delimiter
		// then we are dealing with a page[x] level accordion
		if(path.indexOf('.') === -1) {
			var accordionContainer = dojo.byId(path + '_loadEntry') || dojo.byId(path + '_none');
			this.accordion.openPane(accordionContainer);
			
			 // cleanup the move path
			if(ap.movedToPath == path) {
				this.loadMenu(ap.movedToPath);
			    this.loadPalette(ap.movedToPath);
				ap.movedToPath = null;	
			}
		}
		else {
			// we've atleast got page[x].pageElement[y] so split on the period
			var pageElementPath = path.split('.')[1];
			var fieldElementPath = path.split('.')[2] || null;

			if(fieldElementPath) {
				// focus on the field element
				this.loadMenu(ap.movedToPath);
			    this.loadPalette(ap.movedToPath);

			    // cleanup the move path
			    ap.movedToPath = null;
			} else {
				if(path.indexOf('.connectors[@type=') !== -1) {
					// we just moved a connector
					var connectorsTabPath = path.split('.')[0] + '_Connectors';
					focusTab.call(this, connectorsTabPath + '_palette', connectorsTabPath);
					var accordionContainer = dojo.byId(path.split('_')[0] + '_loadEntry');
					this.connectorAccordion.openPane(accordionContainer);

					if(ap.movedToPath === path) {
						this.loadMenu(ap.movedToPath);
			   			this.loadPalette(ap.movedToPath);
						ap.movedToPath = null;
					}
				} else {
					var accordionContainer = dojo.byId(path + '_loadEntry');
					this.pageElementAccordion.openPane(accordionContainer);

					// if true, then this was a page element move and we've opened the last accordion
					// so cleanup the move path.
					if(ap.movedToPath === path) {
						this.loadMenu(ap.movedToPath);
			   			this.loadPalette(ap.movedToPath);
						ap.movedToPath = null;
					}
				}
			}
		}
	},

	/**
	 * @override
	 * Set value on hidden field based on checkbox value.
	 */
	onCheckboxClick: function(checkbox) {
		var deleteElement = dojo.byId(checkbox.id.split('.@')[0] + '.@delete');
		if(deleteElement)
			deleteElement.value = !checkbox.checked;
	},

	/**
	 * @override
	 * Function to handle all adds of page, pageElements and fieldElements
	 */
	addNew : function(path,action) {
		/* page level adds */
		if( action == 'addDataEntry') {
			this.addPage(path, 'addPage', 'dataEntry');
		} else if( action == 'addRosterPage') {
			this.addPage(path, 'addPage', 'roster');
		} else if( action == 'addCustomPage') {
			this.addPage(path, 'addPage', 'custom');
		} else if( action == 'addImport') {
			this.addPage(path, 'addPage', 'importPage');
		}
		/* page element level adds */
		else if( action == 'addFieldset') {
			this.addPageElement(path, 'addPageElement', 'fieldset');
		} else if( action == 'addIndex') {
			this.addPageElement(path, 'addPageElement', 'index');
		} else if( action == 'addQuestionnaire') {
			this.addPageElement(path, 'addPageElement', 'questionnaire');
		} else if( action == 'addScript') {
			this.addPageElement(path, 'addPageElement', 'script');
		} else if( action == 'addTips') {
			this.addPageElement(path, 'addPageElement', 'tips');
		} else if( action == 'addRoster') {
			this.addPageElement(path, 'addPageElement', 'roster');
		}else if( action == 'addServiceData') {
			this.addPageElement(path, 'addPageElement', 'serviceData');
		}
		/* field element level adds */
		else if( action == 'addCheckbox') {
			this.addFieldElement(path, action, 'checkbox');
		} else if( action == 'addDate') {
			this.addFieldElement(path, action, 'date');
		} else if( action == 'addFile') {
			this.addFieldElement(path, action, 'file');
		} else if( action == 'addFilterlist') {
			this.addFieldElement(path, action, 'filterlist');
		} else if( action == 'addHidden') {
			this.addFieldElement(path, action, 'hidden');
		} else if( action == 'addMessage') {
			this.addFieldElement(path, action, 'message');
		} else if( action == 'addQuestion') {
			this.addFieldElement(path, action, 'question');
		} else if( action == 'addRadio') {
			this.addFieldElement(path, action, 'radio');
		} else if( action == 'addSelectlist') {
			this.addFieldElement(path, action, 'selectlist');
		} else if( action == 'addTextarea') {
			this.addFieldElement(path, action, 'textarea');
		} else if( action == 'addText') {
			this.addFieldElement(path, action, 'text');
		}
		/* connector adds */
		else if( action == 'addXARC') {
			this.addConnector(path, action, 'XARC');
		} else if( action == 'addCustomConnector' ) {
			this.addConnector(path, action, 'custom');
		}
		/* instruction adds */
		else if( action == 'addStatusChange' ) {
			this.addConnector(path, action, 'statusChange');
		} else if( action == 'addAssign' ) {
			this.addConnector(path, action, 'assign');
		} else if( action == 'addGenerateMessage' ) {
			this.addConnector(path, action, 'generateMessage');
		} else if( action == 'addCustomInstruction' ) {
			this.addConnector(path, action, 'custom');
		} else if( action == 'addUpdateAPData' ) {
			this.addConnector(path, action, 'updateAPData');
		} else if( action == 'addUpdateServiceData' ) {
			this.addConnector(path, action, 'updateServiceData');
		}
		
		/* fieldHelper adds */
		else if( action == 'addBalloonFieldHelper') {
			this.addFieldHelper(path, action, 'balloon');
		} else if( action == 'addScriptFieldHelper' ) {
			this.addFieldHelper(path, action, 'script');
		} else if( action == 'addDatePickerFieldHelper') {
			this.addFieldHelper(path, action, 'datePicker');
		}
		/* select list value adds */
		else if( action == 'addXmlReader' ) {
			this.addValues(path, action, 'xmlreader');
		} else if( action == 'addDynamic' ) {
			this.addValues(path, action, 'dynamic');
		} else if( action == 'addCustomList' ) {
			this.addValues(path, action, 'custom');
		}
		/* roster adds */
		else if( action == 'addJoin' ) {
			this.addRosterElement(path, action, 'join');
		} else if( action == 'addColumn' ) {
			this.addRosterElement(path, action, 'column');
		}
		else if( action == 'addConnectorXARCRule' ) {
			this.addXARCRule(path, action, 'xarc');
		} else if( action == 'addConnectorExecuteWhen' ) {
			this.addExecuteWhen(path, action, 'executeWhen');
		}
		else if( action.indexOf('addValidation') > -1 ) {
			this.addValidation(path, action);
		}
		else if( action.indexOf('addCorrection') > -1 ) {
			this.addCorrection(path, action);
		}
	}
});



/**
 * used to toggle the required indicator on and off
 * @param event event that was triggered for the toggle
 * @param updateField Field that will be updated with blank or asterisk
 * @param sourceField Field that caused the change
 * @return
 */
function requiredIndicatorToggle(event, updateField, sourceField) {
	if(event) {
		event.stop();
	}

	if($(sourceField).getValue().length === 0) {
		$(updateField).update();
	} else {
		$(updateField).update('*');
	}
};


