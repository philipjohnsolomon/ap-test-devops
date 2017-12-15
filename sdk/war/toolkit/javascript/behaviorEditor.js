/**
 * @fileoverview This file contains the objects required for generating a behavior editor objects in the toolkit
 * @author Patrick Kaeding pkaeding@agencyport.com
 * @version 0.1
 */

dojo.declare("TransactionDefinitionBehaviorEditor", Editor, {
	constructor: function (product, artifactId, artifactType) {
		//This artifact has been deleted. Just return
		if (this.deleted == true) {
			return;
		}
		
		//variables stop overeager AJAXers
		this.lastPaletteLoaded = "";
		this.lastMenuLoaded = "";
	},
	
	/**
	*  Will open the editor, menu and palette of a given behavior.  Invoked by Impacted By palette
	*  in the tdf.
	*
	**/
	openEditorToPath: function (path) {
				
		if (path.indexOf('.') === -1) {
			
			var editorType =  path.split('[')[0];
			
			//First time through we're called by loadEditor and pane is
			//not yet opened.
			var accordionContainer = dojo.byId(editorType + '_loadEntry');
			this.accordion.openPane(accordionContainer);

			if (editorType.indexOf('hotField') > -1) {
				editorType = 'hotfield';
			}
			
			this.loadMenu(path, editorType);
			this.loadPaletteInternal(path, editorType);
			
		} else {
		
			//Second time through we're called by accordion.onDownloadEnd
			//we now have the content available to bring into focus.
			var basePath = path.split('.')[0];
			
			//Bring the target behavior into view
			var behavior = dojo.byId(basePath);
			var container = dojo.byId('editor');
			container.scrollTop = behavior.offsetTop;
			
			dojo.addClass(basePath, 'focused_page_entity');
			
			ap.movedToPath = null;
		}
	},

	/**
	 * Gets called when nothing is found  in Editor class.  Hook point for click events
	 * @param item is the item clicked or the current item being processed
	 * @param event is the click event details
	 */
	onClickEvent: function (item, event) {
		if (dojo.hasClass(item, 'deleteRowAction')) {
			this.deleteRow(item);
		} else if (dojo.hasClass(item, 'load_event')) {
			var path = item.id.replace('_wrapperDiv', '');
			var listId = path + ".@transaction";
			var list = dojo.byId(listId);
			this.refreshPageEntityOptions(list);
			dojo.removeClass(item, 'load_event');
			return false;
		} else if (dojo.hasClass(item, 'copy_event')) {
			ap.master.save();
			ap.master.hasUnsavedChanges = false;
			this.loadCopyDialog(item);
		}
	},
	
	/**
	 * Opens the copy behavior dialog in response to a click event
	 * @param item
	 */
	loadCopyDialog: function loadCopyDialog(item) {
		var path = item.id.split('_')[0];

		ap.master.dialog = new ToolkitDialogBox('toolkitDialogForm', 'copyBehavior', null,
											'Toolkit?action=loadCopyDialog' +
											'&path=' + path +
											'&product=' + this.product +
											'&artifactId=' + this.artifact,
											true, path);
		return true;
	},
	
	/**
	 * When a tab is focused hook point to do any processing.
	 * In this case we register the auto complete widget
	 * @param item is the item clicked or the current item being processed
	 * @param event is the click event details
	 */
	onFocusTabEvent: function (item, event) {
		//ony needed if we need a focus hook on a tab
		return;
	},

	/**
	 * Add a new behavior.
	 * @param product
	 * @param artifactId
	 */
	addBehavior: function addBehavior(path, action) {
		toolkitPleaseWait(true);
		// the DOM element accordion_container contains both hotfields and behaviors as children.
		// therefore, we cannot grab accordion_container and count <tr> elements as in other editors.
		// we must grab the _behaviorContainer which is a child of accordion_container and count <tr> elements.
		var behaviorContainer = dojo.byId(this.artifact + '_behaviorContainer');

		//function that will handle the successful response
		var successHandler = function (behaviorContainer) {
			return function (response) {
			    var node = dojo.place(dojo.trim(response), behaviorContainer);
			    var behaviorPane = dojo.byId('behavior_loadEntry');
			    this.accordion.openPane(behaviorPane);
			    this.focusMenu(null, node.id);
			    this.focusPalette(null, node.id);
				toolkitPleaseWait(false);
			};
		};

		//Create the ToolkitRequest
		var request = new ToolkitRequest('addBehavior',
										 {'action': action, 'path': path
										 },
										 this,
										 successHandler(behaviorContainer),
										 this.ajaxFailureHandler);

		//request.url = 'toolkit/behaviors/editor/behavior.jsp';
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Add a new refresh list for a hotfield.
	 *
	 * @param hotfieldId
	 * @param action addRefreshList
	 */
	addRefreshList: function addRefreshList(hotfieldId, action) {
		toolkitPleaseWait(true);

		// grab the _forPalette which the new for clause will be inserted into
		var refreshListContainer = dojo.byId(hotfieldId + '_refreshListPalette');

		var successHandler = function (refreshListContainer) {
			return function (response) {
			    dojo.place(dojo.trim(response), refreshListContainer);
			    ap.layoutManager.buildMenuButtons(ap.master, refreshListContainer.id, false);
				toolkitPleaseWait(false);
			};
		};

		// create the ToolkitRequest to load a new refresh list palette row
		var request = new ToolkitRequest('addRefreshList',
										 {'action': action, 'path': hotfieldId },
										 this,
										 successHandler(refreshListContainer),
										 this.ajaxFailureHandler);

		//request.url = 'toolkit/behaviors/palette/refreshList.jsp'
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Add a new for clause.
	 *
	 * @param behaviorId
	 * @param action addFor
	 */
	addFor: function addFor(path, action) {
		toolkitPleaseWait(true);

		// grab the _forPalette which the new for clause will be inserted into
		var forContainer = dojo.byId(path + '_container');

		var successHandler = function (forContainer) {
			return function (response) {
			    dojo.place(dojo.trim(response), forContainer);
			    ap.layoutManager.buildMenuButtons(ap.master, forContainer, false);
				toolkitPleaseWait(false);
			};
		};

		// create the ToolkitRequest to load a new fpr palette row
		var request = new ToolkitRequest('addFor',
										 {'action': action, 'path': path
										 },
										 this,
										 successHandler(forContainer),
										 this.ajaxFailureHandler);

		//request.url = 'toolkit/behaviors/palette/for.jsp'
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},
	/**
	 * Add a new where precondition clause.
	 * @param behaviorId behavior indexed id
	 * @param action addwhere
	 */
	addWhere: function addWhere(behaviorId, action) {
		toolkitPleaseWait(true);
		// grab the _wherePalette which the new where clause will be inserted into
		var whereContainer = dojo.byId(behaviorId + '_container');

		//function that will handle the successful response
		var successHandler = function (whereContainer) {
			return function (response) {
			    var node = dojo.place(dojo.trim(response), whereContainer);
			    var wherePath = node.id.split('.where')[0];
				var wherePalette = dojo.byId(wherePath + '_palette');
				ap.layoutManager.buildMenuButtons(ap.master, whereContainer, false);
				this.createEvents(wherePalette);
				toolkitPleaseWait(false);
			};
		};

		// create the ToolkitRequest to load a new where palette row
		var request = new ToolkitRequest('addWhere',
										 {'action': action, 'path': behaviorId
										 },
										 this,
										 successHandler(whereContainer),
										 this.ajaxFailureHandler);

		//request.url = 'toolkit/behaviors/palette/where.jsp'
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Add a new alter property row to the palette
	 * @param path is the path of the property being added
	 * @param addType is the type of the property being added
	 */
	addProperty: function addProperty(path, actionType) {
		toolkitPleaseWait(true);
		//var containerPath = path.replace(/\..*/, "");
		//var container = dojo.byId(containerPath + '_propertyPalette');
		var action = actionType.split('-')[0];
		var type = actionType.split('-')[1];
		var pathContainer = dojo.byId(path + '_container');

		var targetPaletteBasePath = path.split('.do.property')[0];
		var targetPalettePath = targetPaletteBasePath + '_alterProperties';
		var contentToShow = targetPaletteBasePath + '_alterProperties_palette';

		var successHandler = function (pathContainer, type, action, targetPalettePath, contentToShow) {
			return function (response) {
				var node = dojo.place(dojo.trim(response), pathContainer);
				var nodeId = node.id.replace("_wrapperDiv", "");
				ap.layoutManager.buildMenuButtons(ap.master, node.id, false);
				toolkitPleaseWait(false);
				focusTab.call(this, contentToShow, targetPalettePath);
			    ap.master.dialog = new ToolkitDialogBox('toolkitDialogForm', 'editProperty', null,
			    		"Toolkit?action=editProperty&type=" + type + "&product=" + this.product +
			    		"&artifactId=" + this.artifact + "&path=" + nodeId, true, nodeId);
			};
		};

		// create the ToolkitRequest
		var request = new ToolkitRequest('addProperty',
										 {'path': path, 'type': type, 'action': action},
										 this,
										 successHandler(pathContainer, type, action, targetPalettePath, contentToShow),
										 this.ajaxFailureHandler);

		ap.AjaxManager.processRequest(request);
	},

	/**
	 * Add a new hot field.
	 * @param product
	 * @param artifactId
	 */
	addHotField: function addHotField(path, action) {
		toolkitPleaseWait(true);
		// the DOM element accordion_container contains both hotfields and behaviors
		// therefore, we cannot grab accordion_container and count <tr> elements as in other editors.
		// we must grab the _hotfieldContainer which is a child of accordion_container and count <tr> elements.
		var hotfieldContainer = dojo.byId(this.artifact + '_hotfieldContainer');

		//function that will handle the successful response
		var successHandler = function (hotfieldContainer) {
			return function (response) { 
			    var node = dojo.place(dojo.trim(response), hotfieldContainer);
			    var hotfiedPane = dojo.byId('hotField_loadEntry');
			    this.accordion.openPane(hotfiedPane);
			    this.focusPalette(null, node.id);
			    this.focusMenu(null, node.id);
				toolkitPleaseWait(false);
			};
		};

		//Create the ToolkitRequest
		var request = new ToolkitRequest('addHotfield',
										 {'action': action, 'path': path
										 },
										 this,
										 successHandler(hotfieldContainer),
										 this.ajaxFailureHandler);

		//request.url = 'toolkit/behaviors/editor/hotfield.jsp';
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	/**
	 * This will handle the clean up necessary when the action is changed.
	 *
	 * This means hiding any alter properties and marking them for deletion when the action
	 * is not alter, hiding the 'add alter property' button when the action is not alter,
	 * and showing it when the action is alter.
	 * @param actionField the select list field that this function listens for changes from
	 * @return
	 */
	changeAction: function changeAction(actionFieldId) {
	
		var baseId = actionFieldId.split('.')[0];
		var actionField = dojo.byId(baseId + '.do.@action');
		var propertyTab = dojo.byId(baseId + '_alterProperties');
		var addPropertyButton = dojo.byId(baseId + '_alter_button');
		var selectedAction = actionField.value;
		
		if (selectedAction === "alter") {
			dojo.style(propertyTab, "display", "");
			dojo.style(addPropertyButton, "display", "");
		} else {
			dojo.style(propertyTab, "display", "none");
			dojo.style(addPropertyButton, "display", "none");

			//set values on delete fields to remove empty aggregates.
			var propertyDeleteFields = dojo.query(baseId + '_propertyPalette', '.deleteProperty');
			//var propertyPalettes = dojo.query(baseId + '_propertyPalette', '.propertyPaletteRow');
			for (var j = 0; j < propertyDeleteFields.length; j++) {
				propertyDeleteFields[j].value = true;
			}

		}
	},

	/**
	 * Load the behavior or hotfield data from the server and create a palette to
	 * hold the data.  This is the area where the data for the file will be updated.
	 * @param path Path for the palette data.
	 * @param type Type of palette that will be loaded
	 */
	loadPaletteInternal: function (path, type) {

		var paletteElement = path + '_palette';

		if (path.indexOf('[') == -1 && type == null) {
			type = 'palette';
			paletteElement = this.artifact + '_palette';
		}

		if (!dojo.byId(paletteElement)) {
			var successHandler = function (paletteElement) {
				return function (response) {
				    dojo.place(dojo.trim(response), 'palette');
				    ap.layoutManager.buildMenuButtons(ap.master, paletteElement);
				    this.focusPalette(null, path, path);
				    this.createEvents(dojo.byId(paletteElement));
					this.currentPaletteId = paletteElement;
				    //we want to display the alter tab correctly first time thru
				    if (type != 'palette' && type != 'hotfield' && type != 'additionalFieldToShred') {
				    	this.changeAction(path);
				    }
				    toolkitPleaseWait(false);
			    };
		    };

			//Create the ToolkitRequest
			var request = new ToolkitRequest('loadPalette',
											 {'path': path, 'type': type, 'action': 'loadPalette'},
											 this,
											 successHandler(paletteElement),
											 this.ajaxFailureHandler);
			//request.url = 'toolkit/codelists/palette/loadPalette.jsp';
			//Register the request with ajax manager
			ap.AjaxManager.processRequest(request);
		} else {
			this.focusPalette(null, path, path);
		}
	},

	dataEntryFieldChangeHandler: function (item) {
		
		if (dojo.hasClass(item, 'pageEntityList_event')) {
			this.refreshPageEntityOptions(item);
			return false;
			
		} else if (dojo.hasClass(item, 'alter_correction')) {
			this.loadAlterCorrection(item);
			return false;
			
		} else if(dojo.hasClass(item, 'refreshXarcRulesList')) {
				
			this.handleXARCListRefresh(item);				
			return false;
			
		} else if (dojo.hasClass(item, 'select_list_change')) {
			var itemId = item.id;	
			var selectFieldValue = dojo.byId(itemId).value;	
			
			var formatMaskPath = itemId.split('.@')[0];
			var customMaskElement = dojo.byId(formatMaskPath + '_formRow');
			
			if (selectFieldValue.startsWith('custom')) {
				dojo.style(customMaskElement, "display", "block");
				
			} else {
				dojo.byId(formatMaskPath).value = "";
				dojo.style(customMaskElement, "display", "none");
			}
		} else if (!dojo.hasClass(item, 'hotfieldKey')) {
			// only change action in behaviors comes from the action drop down
			this.changeAction(item.id);
		}
	},
	
	/**
	* When rule library changes, get the list of rules available in that library
	* and refresh Rule Id list.
	*
	**/	
	handleXARCListRefresh: function (item) {
		var ruleLibraryList = item;
		var selectedRuleLibrary = ruleLibraryList.value;
		var path = item.id.split('.xarcRules')[0];
		var targetPath = path + '.xarcRules.@ruleId';
		
		var successHandler = function(targetPath){
								return function(response){
									var node = dojo.create('div', {"id": "refreshOptions", 'innerHTML': dojo.trim(response)});
									var ruleElementOptions = dojo.query('> #ruleElementOptions', node)[0];
									var targetElement = dojo.byId(targetPath);
									dojo.empty(targetElement);
									dojo.place(dojo.trim(ruleElementOptions.innerHTML), targetElement);
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
	
	refreshPageEntityOptions: function (item) {
		var itemId = item.id;
		var targetPath = itemId.split('.@')[0];
		var transactionPath = targetPath + ".@transaction";
		var transactionInversionPath = transactionPath + "_inversion";
		var transaction = dojo.byId(transactionPath);
		var transactionInversion = dojo.byId(transactionInversionPath).value;
		var pagePath = targetPath + '.@page';
		var pageInversionPath = pagePath + "_inversion";
		var page = dojo.byId(pagePath);
		var pageInversion = dojo.byId(pageInversionPath).value;
		var pageElementPath = targetPath + ".@pageElement";
		var pageElementInversionPath = pageElementPath + "_inversion";
		var pageElement = dojo.byId(pageElementPath);
		var pageElementInversion = dojo.byId(pageElementInversionPath).value;
		var fieldElementPath = targetPath + ".@fieldElement";
		var fieldElementInversionPath = fieldElementPath + "_inversion";
		var fieldElement = dojo.byId(fieldElementPath);
		var fieldElementInversion = dojo.byId(fieldElementInversionPath).value;
		var successHandler = function (targetPath, clickedId, transaction, page, pageElement, fieldElement) {
								return function (response) {
									var node = dojo.create('div', {"id": "refreshOptions", 'innerHTML': dojo.trim(response)});
									var pageOptions = dojo.query('> #pageOptions', node)[0];
									var pageElementOptions = dojo.query('> #pageElementOptions', node)[0];
									var fieldElementOptions = dojo.query('> #fieldElementOptions', node)[0];
									if (clickedId.indexOf('@transaction') > 0) {
										//update all three if here
										dojo.empty(page);
										dojo.place(dojo.trim(pageOptions.innerHTML), page);
									}

									//only update this when the clicked id is not a page element
									if (clickedId.indexOf('@pageElement') == -1) {
										//update all three
										dojo.empty(pageElement);
										dojo.place(dojo.trim(pageElementOptions.innerHTML), pageElement);
									}

									//this will always get updated
									dojo.empty(fieldElement);
									dojo.place(dojo.trim(fieldElementOptions.innerHTML), fieldElement);

									node = null;
							    };
						    };

		//Create the ToolkitRequest
		var request = new ToolkitRequest('refreshFor',
										 {'path': targetPath, 'action': 'refreshFor', 'transaction': transaction.value,
										 'page' : page.value, 'pageElement': pageElement.value, 'fieldElement': fieldElement.value,
										 'transactionInversion': transactionInversion, 'pageInversion': pageInversion,
										 'pageElementInversion': pageElementInversion, 'fieldElementInversion': fieldElementInversion
										 },
										 this,
										 successHandler(targetPath, itemId, transaction, page, pageElement, fieldElement),
										this.ajaxFailureHandler);
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
		return false;
	},

	dataEntryFieldBlurHandler: function (item) {
		//console.log('dataEntryFieldBlurHandler(): ' + item.id);
	},

	/**
	 * Adds a validation and sets palette focus.
	 * @param path path of validation.
	 * @param action action to trigger
	 */
	addValidation: function addValidation(path, action) {

		var validationContainer = dojo.byId(path + '_container');
		var targetPaletteBasePath = path.split('.do.property')[0];
		var targetPalettePath = targetPaletteBasePath + '_alterProperties';
		var contentToShow = targetPaletteBasePath + '_alterProperties_palette';

		var successHandler = function (validationContainer, targetPalettePath, contentToShow) {
							return function (response) {
								var node = dojo.place(dojo.trim(response), validationContainer);
								var nodeId = node.id.replace("_wrapperDiv", "");
								ap.layoutManager.buildMenuButtons(ap.master, node.id, false);
								toolkitPleaseWait(false);
								this.hasUnsavedChanges = true;
								focusTab.call(this, contentToShow, targetPalettePath);
								ap.master.dialog = new ToolkitDialogBox('toolkitDialogForm', 'validation',
									null, 'Toolkit?action=loadValidationDialog&type=validation&path=' + nodeId +
										'&product=' + this.product + '&artifactId=' + this.artifact, true, nodeId);
							};
						};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addValidation',
							{'action': 'addValidation', 'path': path},
							this,
							successHandler(validationContainer, targetPalettePath, contentToShow),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);


		return true;
	},

	/**
	 * Adds a correction and sets palette focus.
	 * @param path path of correction.
	 * @param action action to trigger
	 */
	addCorrection: function addCorrection(path, action) {

		var correctionContainer = dojo.byId(path + '_container');

		var targetPaletteBasePath = path.split('.do.property')[0];
		var targetPalettePath = targetPaletteBasePath + '_alterProperties';
		var contentToShow = targetPaletteBasePath + '_alterProperties_palette';

		var successHandler = function (correctionContainer, targetPalettePath, contentToShow) {
							return function (response) {
								var node = dojo.place(dojo.trim(response), correctionContainer);
								var nodeId = node.id.replace("_wrapperDiv", "");
								ap.layoutManager.buildMenuButtons(ap.master, node.id, false);
								toolkitPleaseWait(false);
								this.hasUnsavedChanges = true;
								focusTab.call(this, contentToShow, targetPalettePath);
								ap.master.dialog = new ToolkitDialogBox('toolkitDialogForm', 'correction',
									null, 'Toolkit?action=loadCorrectionDialog&type=correction&path=' + nodeId +
										'&product=' + this.product + '&artifactId=' + this.artifact, true, nodeId);
							};
						};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('addCorrection',
							{'action': 'addCorrection', 'path': path},
							this,
							successHandler(correctionContainer, targetPalettePath, contentToShow),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);


		return true;
	},

	/**
	 * Updated dialog box contents based on correction type selected
	 * @param item
	 */
	loadAlterCorrection: function loadAlterCorrection(item) {

		var path = item.id.split('.@type')[0];
		var type = item.value;

		var correctionContainer = dojo.byId(path + '_content');

		var successHandler = function (correctionContainer) {
							return function (response) {
								dojo.empty(correctionContainer);
								dojo.place(dojo.trim(response), correctionContainer);
								ap.master.createEvents(dojo.byId(ap.master.dialog.formId));
								ap.master.dialog.createEvents(dojo.byId(ap.master.dialog.formId));
								toolkitPleaseWait(false);
								this.hasUnsavedChanges = true;
							};
						};

	    //Create the ToolkitRequest
		var request = new ToolkitRequest('loadAlterCorrection',
							{'action': 'loadAlterCorrection', 'path': path, 'type' : type},
							this,
							successHandler(correctionContainer),
							this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);


		return true;
	},
	
	/**
	 * Add a new additional field to shred.
	 * @param product
	 * @param artifactId
	 */
	addAdditionalField: function addAdditionalField(path, action) {
		toolkitPleaseWait(true);
		
		var additionalFieldToShredContainer = dojo.byId(this.artifact + '_additionalFieldToShredContainer');

		//function that will handle the successful response
		var successHandler = function (additionalFieldToShredContainer) {
			return function (response) {
			    var node = dojo.place(dojo.trim(response), additionalFieldToShredContainer);
			   // this.focusMenu(null,node.id);
			    ap.layoutManager.buildMenuButtons(ap.master, node.id, false);
			    this.createEvents(dojo.byId('additionalFieldToShred_loadEntry'));
				toolkitPleaseWait(false);
			};
		};

		//Create the ToolkitRequest
		var request = new ToolkitRequest('addAdditionalFieldToShred',
										 {'action': action, 'path': path},
										 this,
										 successHandler(additionalFieldToShredContainer),
										 this.ajaxFailureHandler);

		//request.url = 'toolkit/behaviors/editor/behavior.jsp';
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},
	/**
	 * Override to call the proper method for adding.
	 */
	addNew: function (path, action) {
		var propertyAction = action.split('-')[0];
		if (action == "addNew") {
			this.addOptionList();
		} else if (action == "addHotfield") {
			this.addHotField(path, action);
		} else if (action == "addBehavior") {
			this.addBehavior(path, action);
		} else if (action == "addWhere") {
			this.addWhere(path, action);
		} else if (action == "addFor") {
			this.addFor(path, action);
		} else if (action == "addRefreshList") {
			this.addRefreshList(path, action);
		} else if (action == "addAdditionalFieldToShred") {
			this.addAdditionalField(path, action);
		} else if (propertyAction === 'alter') {

			if (action.indexOf('validation') > -1) {
				this.addValidation(path, action);
			} else if (action.indexOf('correction') > -1) {
				this.addCorrection(path, action);
			} else {
				this.addProperty(path, action);
			}
		}
	}
});
