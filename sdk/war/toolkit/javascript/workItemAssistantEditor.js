/** 
 * @fileoverview This file contains the work item assistant product definition
 * editor.  
 * @version 0.1  
 */
/**
 * Constructs a new WorkItemAssistantEditor object.
 * @constructor
 * @class The WorkItemAssistantEditor class sets up the editor for any work item assistant
 * @return A new WorkItemAssistantEditor instance
*/

dojo.declare("WorkItemAssistantEditor", Editor, {
	constructor: function (product, artifactId, artifactType) {
		
	},
	
	dataEntryFieldChangeHandler: function(item){

		if(dojo.hasClass(item,'select_list_change')) {
			var itemId = item.id;	
			var selectFieldValue = dojo.byId(itemId).value;	
			this.updateOptionTarget(item,selectFieldValue );
		}		
		return false;
	},
	
	updateOptionTarget: function(item, selectFieldValue) {
		toolkitPleaseWait(true);
		var itemId = item.id;			
		var target = itemId.split('.@')[1];
		if('target' == target){
			this.hasUnsavedChanges = true;
			toolkitPleaseWait(false);
			return;
		}
		
		var targetPath =  itemId.split('.@source')[0] + '.@target';
		var targetContainer = dojo.byId(targetPath);
		var successHandler = function(targetContainer, targetPath){
									return function(response){
										dojo.empty(targetPath);
									    dojo.place(dojo.trim(response),targetContainer);							    	
										this.hasUnsavedChanges = true;
										toolkitPleaseWait(false);
									};
								};
								
			//Create the ToolkitRequest
		var request = new ToolkitRequest('getOptionTarget',
								{'optionList': selectFieldValue,
								 'action': 'getOptionTarget'
								},
								this,
								successHandler(targetContainer, targetPath),
								this.ajaxFailureHandler);
								
		ap.AjaxManager.processRequest(request);
	},
	
	/**
	 * Given a palette and a path. Check to see if that object has an  
	 * implementation count of zero. If it does mark the accordion with the 
	 * class unused
	 * @param palettePath The palettes path
	 * @param path The entity xpath
	 */
	markUnused: function markUnused(palettePath, path) {
		var palette = dojo.byId(palettePath);
		var numImplementations = palette.down("._numberImplementations");
		if (numImplementations){
			var number = $F(numImplementations);
			if (number == 0)
				dojo.byId(path+'_accordion_toggle').addClassName('unused');
		}
	},		
	
	/**
	 * Add new section.
	 * @param product Current product (LOB) 
	 */
	addSection: function addSection(path, action) {
		
		// grab the DOM element containing the current options lists
		var optionListContainer = dojo.byId('accordion_container');
	
		//this.lastOptionListPath = newFieldId;
		var successHandler = function(optionListContainer,path){
									return function(response){
									    var node = dojo.place(dojo.trim(response),optionListContainer);
								    	//var newOptionListAccordion = dojo.byId(newFieldId);
									    this.accordion.addAccordion(node);
									    this.accordion.openPane(node);
									    ap.master.loadPalette(node.id.split('_')[0]);
										ap.master.loadMenu(node.id.split('_')[0]);
										this.hasUnsavedChanges = true;
										toolkitPleaseWait(false);
									};
								};
								
			//Create the ToolkitRequest
		var request = new ToolkitRequest(action,
								{'artifactType': 'workItemAssistant',
								 'action': action,
								 'path': path
								},
								this,
								successHandler(optionListContainer,path),
								this.ajaxFailureHandler);
								
			ap.AjaxManager.processRequest(request);
	},
		
	/**
	 * Add new option from the server
	 * @param fieldId Id of the DOM element that the add button was clicked. 
	 * @param templateId Id of the DOM for the template top level 
	 * @param templateIndex Index of the current option list 
	 */
	addRole: function addRole(sectionId, action) {
		// grab the DOM element which contains the options for this option list
		var optionContainer = dojo.byId(sectionId + '_fields_container');
		
		toolkitPleaseWait(true);
		
		var successHandler = function(optionContainer){
								return function(response){
									var node = dojo.place(dojo.trim(response),optionContainer);
									var optionPath = node.id.split('.')[0];
									var paletteManager = this.paletteManagers.item(optionPath+"_loadEntry");
									this.createEvents(dojo.byId(optionPath+"_loadEntry"));
									//open the titlepane where we are adding if not open.
									var titlePaneNode = dojo.byId(optionPath + "_loadEntry");
									this.accordion.openPane(titlePaneNode );
									var newField = node.id.split("_")[0];	
									//focus on value input after pane is opened.
									setTimeout(function() {
										ap.focusField(newField);
										},100);
									this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};
	   
	    //Create the ToolkitRequest
		var request = new ToolkitRequest(action,
							{'artifactType': 'workItemAssistant',
							 'sectionId': sectionId, 
							 'product': this.product,
							 'artifactId': this.artifact,
							 'action': action,
							 'path': sectionId
							},
							this,
							successHandler(optionContainer),
							this.ajaxFailureHandler);
		ap.AjaxManager.processRequest(request);
	},
	
	onClickEvent: function(item, event) {
		if(dojo.hasClass(item, 'deleteRowAction')) {
			  this.deleteEditorRow(item);
		}else if(dojo.hasClass(item,'move_event')) {
			ap.master.save();
			ap.master.hasUnsavedChanges = false;
			this.loadMoveDialog(item);
		}
	},
	
	_pageBodyClickEventDelegateHandler: function(event,container) {

	    var item = event.target;
		if(!item) return;
		while (item.id != null && item.id != container.id) {
			if(dojo.hasClass(item,'deleteAction')) {

				var itemId = item.id;
				var deleteId = itemId.replace("_delete", "");

				if(this.isUsedBy(deleteId)){
					this.dialog = new ToolkitDialogBox('toolkitDialogForm', null,
								"This entity cannot be deleted as it is referenced by other artifacts.",null,null,null,null);

						return false;
				}

				if (!confirmDelete(deleteId))
					return;

				var deleteElement = dojo.byId(deleteId.replace(".javaclass",""));
				this.accordion.deleteAccordion(deleteId);

				var deleteIndicatorField = deleteId.replace("_wrapperDiv", "") + '.@delete';

				if(deleteElement) {
					dojo.style(deleteElement,"display","none");
				}

				dojo.byId(deleteIndicatorField).value = 'true';
				this.hasUnsavedChanges = true;
						
				var paletteToHide = dojo.byId(deleteId.replace("_wrapperDiv", "") +'_palette');

				if (paletteToHide) {
					dojo.style(paletteToHide,"display","none");
				}

				this.reloadInitialMenu(deleteId);
				return false;
			}else  if(dojo.hasClass(item,'deleteArtifact')) {

				var itemId = item.id;
				var deleteId = itemId.replace("_delete", "");

				if(this.isUsedBy(deleteId)){
					this.dialog = new ToolkitDialogBox('toolkitDialogForm', null,
								"This entity cannot be deleted as it is referenced by other artifacts.",null,null,null,null);

						return false;
				}
				if (!confirmDelete(deleteId))
					return;

				var deleteElement = dojo.byId(deleteId);

				if(deleteElement) {
					this.deleteArtifact(deleteId);
				}

				return false;
			}else if(dojo.hasClass(item,'copy_event')) {
				var itemId = item.id;
				var path = itemId.split('_')[0];
				var action = itemId.split('_')[1];
				this.addSection(path,action);
				return false;
			 }else{
			 	item = item.parentNode;
			}
    	}
		this.inherited(arguments);
	},

	/**
	 * Load the page data from the server, the pages are loaded only when clicked
	 * @param pageElement Element of the page to insert the html from server
	 * @param pageIndex Index of current page used to retrieve the correct page elements
	 */
	loadMenu: function loadMenu(path, type) {

		var menuElement = path + '_menu';
		if(!dojo.byId(menuElement)) {

			var successHandler = function(menuElement){
									return function(response){
										this.destroyPrevoiusSectionMenu();
									 	dojo.place(dojo.trim(response),'contextAction');
									 	ap.layoutManager.buildMenuButtons(this, menuElement);
										this.focusMenu(null, path);
										this.currentMenuId = menuElement;
						    		};
							    };

			//Create the ToolkitRequest
			var request = new ToolkitRequest('loadMenu',
											 {'path': path, 'type': type, 'action': 'loadMenu'},
											 this,
											 successHandler(menuElement),
											 this.ajaxFailureHandler);
			//Register the request with ajax manager
			ap.AjaxManager.processRequest(request);
		} else {
			this.focusMenu(null, path);
		}
	},
	
	/*
	 * Destroy all buttons from previous list since they are reloaded every time.
	 */
	destroyPreviousButtons: function (item) {
		dojo.query('.dijitButtonContents', item.id).forEach(function(node, index) {
			var dijitNode = dijit.byId(node.id);
			if(dijitNode) {
				dijitNode.destroyRecursive();
			}
		});
	},
	
	destroyPrevoiusSectionMenu : function (){
		var contextAction = dojo.byId('contextAction');
		if(contextAction){
			dojo.query('.section_menu').forEach(dojo.hitch(this, function(item, i) {
				if (item) {
					this.destroyPreviousButtons(item); 
					contextAction.removeChild(item);
					item = null;
				}
			}));
		}
	},
	
	
	reloadInitialMenu: function reloadInitialMenu(deleteId) {

			var successHandler = function(){
									return function(response){
										var menuElement = this.artifact + '_menu';
										this.focusMenu(null, this.artifact);
										this.currentMenuId = menuElement;
						    		};
							    };

			//Create the ToolkitRequest
			var request = new ToolkitRequest('reloadInitialMenu',
											 {	'path': 'section', 
												'type': 'type', 
												'deleteId': deleteId,
												'action': 'reloadInitialMenu'},
											 this,
											 successHandler(),
											 this.ajaxFailureHandler);
			//Register the request with ajax manager
			ap.AjaxManager.processRequest(request);
		
	},
	
	destroyInitialSectionMenu : function (){
		var contextAction = dojo.byId('contextAction');
		if(contextAction){
			dojo.query('.initial_section_menu').forEach(function(item, i) {
				if (item) {
					contextAction.removeChild(item);
					item = null;
				}
			});
		}
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
	 * Function to handle all adds
	 */
	addNew : function(path,action){
		if(action == "addComments" || action == "addFileAttachments" || action == "addActiveUsers"){
			this.addSection(path, action);
		}else if(action == "addRole" || action == "addFileType"){
			this.addRole(path, action);
		}
	}
});
