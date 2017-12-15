/** 
 * @fileoverview This file contains the Option List product definition
 * editor.  This will render an existing CodeListRef xml file for editing.
 * @author Patrick Kaeding pkaeding@agencyport.com
 * @version 0.1  
 */
/**
 * Constructs a new OptionListEditor object.
 * @constructor
 * @class The OptionListEditor class sets up the editor for any option list template files
 * for a given LOB.
 * @return A new OptionListEditor instance
*/

dojo.declare("OptionListEditor", Editor, {
	constructor: function (product, artifactId, artifactType) {

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
	 * Add new code list.
	 * @param product Current product (LOB) 
	 * @param artifactId Current artifact (code list file in this case)
	 */
	addOptionList: function addOptionList(path, action) {
		
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
		var request = new ToolkitRequest('addOptionList',
								{'artifactType': 'codeList',
								 'action': 'addOptionList',
								 'path': path
								},
								this,
								successHandler(optionListContainer,path),
								this.ajaxFailureHandler);
								
			//request.url = 'toolkit/dynamiclists/dynamicListTemplate.jsp?artifactType=codeList&action=add';
			//Register the request with ajax manager 
			ap.AjaxManager.processRequest(request);
	},
		
	/**
	 * Add new option from the server
	 * @param fieldId Id of the DOM element that the add button was clicked. 
	 * @param templateId Id of the DOM for the template top level 
	 * @param templateIndex Index of the current option list 
	 */
	addOption: function addOption(optionListId, action) {
		// grab the DOM element which contains the options for this option list
		var optionContainer = dojo.byId(optionListId + '_fields_container');
		
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
		var request = new ToolkitRequest('addOption',
							{'artifactType': 'codeList',
							 'codeListid': optionListId, 
							 'product': this.product,
							 'artifactId': this.artifact,
							 'action': 'addOption',
							 'path': optionListId
							},
							this,
							successHandler(optionContainer),
							this.ajaxFailureHandler);
							
		//request.url = 'toolkit/codelists/option.jsp?artifactType=codeList&action=add';
		//Register the request with ajax manager 
		ap.AjaxManager.processRequest(request);
	},
	
	onClickEvent: function(item, event) {
		if(dojo.hasClass(item, 'deleteRowAction')) {
			  this.deleteEditorRow(item);
		}
	},
	/**
	 * Function to handle all adds
	 */
	addNew : function(path,action){
		if(action == "addOptionList"){
			this.addOptionList(path, action);
		}else if(action == "addOption"){
			this.addOption(path, action);
		}
	}
});
