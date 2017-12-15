/**
 * Controller of the ViewWizard editor
 * @constructor
 * @class Controller of the ViewWizard editor
 * @return A new ViewWizard object
*/

dojo.declare("ViewWizard",Editor, {
	constructor: function(product, artifactId, artifactType) {
	},

	dataEntryFieldChangeHandler: function(item){

		if(dojo.hasClass(item,'select_list_change')) {
			var itemId = item.id;	
			var selectFieldValue = dojo.byId(itemId).value;	
			var path = itemId.split('.@type')[0];
			var valueFieldWidget = dijit.byId(path);
			
			if (selectFieldValue == 'singleSpace') {
				
				var valueField = dojo.byId(path);	
				valueField.value = '';
				
				//disable dijit validation on field
				valueFieldWidget._setDisabledAttr(true);
			} else {
				valueFieldWidget._setDisabledAttr(false);
			}
		}		
		return false;
	},
	
	onClickEvent: function(item, event) {
		if(dojo.hasClass(item, 'fieldSet')) {
			 var itemId = item.id;
			 var path = itemId.split('_')[0];
			 this.updateMenu(path, 'fieldSet');
			 return false;
		} else if(dojo.hasClass(item, 'field_toggle')) {
			 var itemId = item.id;
			 var path = itemId.split('_')[0];
			 var clickedElement = dojo.byId(path + '_field_container');
			 var fieldSetPath = item.id.split('.field[')[0];
			 var fieldSetContainer = dojo.byId(fieldSetPath);
			 //need to remove any other fieldcontainers that have focused_page_entity classes
			 dojo.forEach(dojo.query('.focused_page_entity',fieldSetContainer),function (elt) {
					dojo.removeClass(elt,'focused_page_entity')
				});
			 
			 dojo.addClass(clickedElement  ,'focused_page_entity');
			 this.updateMenu(path, 'field');
			 return false;
		} else if(dojo.hasClass(item, 'deleteField_toggle')) {
			 var itemId = item.id;
			 var path = itemId.split('_')[0];
			 var clickedElement = dojo.byId(path + '_deleteField_container');
			 var fieldSetPath = item.id.split('.deleteField[')[0];
			 var fieldSetContainer = dojo.byId(fieldSetPath);
			 //need to remove any other fieldcontainers that have focused_page_entity classes
			 dojo.forEach(dojo.query('.focused_page_entity',fieldSetContainer),function (elt) {
					dojo.removeClass(elt,'focused_page_entity')
				});
			 
			 dojo.addClass(clickedElement  ,'focused_page_entity');
			 this.updateMenu(path, 'field');
			 return false;
		} else if(dojo.hasClass(item, 'deleteFieldSet')) {
			 this.deleteField(item, '_wrapperDiv');
			 var viewPath = item.id.split('.fieldSet[')[0];
			 this.updateMenu(viewPath, 'view');
			 return false;
		} else if(dojo.hasClass(item, 'deleteField')) {
		
			//Default delete type is field.
			var splitType = '.field[';
			var containerType = '_field_container';
			
			//Account for DeleteField type here
			if( item.id.indexOf('deleteField') > -1 ) {
				splitType = '.deleteField[';
				containerType = '_deleteField_container';
			} 
			
			this.deleteField(item, containerType);
			var fieldsetPath = item.id.split(splitType)[0];
			this.updateMenu(fieldsetPath, 'fieldSet');
			return false;
		}
	},

	/**
	* Delete an editor field
	*
	**/
	deleteField: function(item, container) {
	
		var itemId = item.id;
		var deleteId = itemId.replace("_delete", "");
						
		if (!confirmDelete(deleteId))
		 	return;

		var deleteElement = dojo.byId(deleteId + container);
		var deleteIndicatorField = deleteId.replace("_wrapperDiv", "") + '.@delete';

		if(deleteElement) {
			dojo.style(deleteElement,"display","none");
		}

	 	dojo.byId(deleteIndicatorField).value = 'true';
	 	
	 	dojo.style(this.currentMenuId,"display","none");
		this.hasUnsavedChanges = true;
	
		return false;
	},
	
	
	/**
	* Upadate the menu based on the clicking of the Insruction Set
	* If the menu already exists, just return.
	* @param pageElement Element of the page to insert the html from server
	* @param pageIndex Index of current page used to retrieve the correct page elements
	 */
	updateMenu: function(path, type) {
		
		var menuElement = path + '_menu';

		var existingMenu = dojo.byId(menuElement);
		
		if(existingMenu) {
			dojo.destroy(existingMenu);
		}
		
		var successHandler = function(menuElement){
			return function(response){
				dojo.place(dojo.trim(response),'contextAction');
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

	},
	/**
	 * Add new View template.
	 * @param product Current product (LOB)
	 * @param artifactId Current artifact(view template in this case)
	 */
	addView: function addView(path, action) {

		toolkitPleaseWait(true);

		var viewContainer = dojo.byId('accordion_container');
		var viewType = action.split('-')[0];
		var viewClass = action.split('-')[1];

		var successHandler = function(viewContainer, viewType, action){
				return function(response){
							var node = dojo.place(dojo.trim(response),viewContainer);
						 	this.accordion.addAccordion(node);
						 	ap.master.accordion.openPane(node);
							ap.master.loadPalette(node.id.split('_')[0], action);
							ap.master.loadMenu(node.id.split('_')[0], viewType);
							this.hasUnsavedChanges = true;
							toolkitPleaseWait(false);
					};
				};

		var request = new ToolkitRequest('addView',
										 {'artifactType': 'view', 'path' : path,
										  'action': 'addView', 'viewClass' : viewClass, 'type': viewType},
										 this,
										 successHandler(viewContainer, viewType, action),
										this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);

	},

	/**
	* Add a new fieldset to the editor
	*
	**/
	addFieldSet: function addFieldSet(path, action) {

		toolkitPleaseWait(true);
		var fieldSetContainer = path + '_container';
		var viewPath = path.split('.')[0];

		var successHandler = function(fieldSetContainer,viewPath){
								return function(response){
									var node = dojo.place(dojo.trim(response),fieldSetContainer);
									this.createEvents(dojo.byId(viewPath+"_loadEntry"));
									this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

		var request = new ToolkitRequest('addFieldSet',
										 {'artifactType': 'view', 'path' : path,
										  'action': 'addFieldSet'},
										 this,
										 successHandler(fieldSetContainer,viewPath),
										this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);

	},

	/**
	* Add a new field to the editor
	*
	**/
	addField: function addField(path, action) {

		toolkitPleaseWait(true);
		var fieldContainer = path + '_container';
		var viewPath = path.split('.')[0];
		
		var successHandler = function(fieldContainer,viewPath){
								return function(response){
									var node = dojo.place(dojo.trim(response),fieldContainer);
									var viewPath = node.id.split('.')[0];
									this.createEvents(dojo.byId(viewPath+"_loadEntry"));
									this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

		var request = new ToolkitRequest('addField',
										 {'artifactType': 'view', 'path' : path,
										  'action': 'addField'},
										this,
										successHandler(fieldContainer,viewPath),
										this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);

	},

	/**
	* Add a new delete field to the editor
	*
	**/
	addDeleteField: function addDeleteField(path, action) {

		toolkitPleaseWait(true);
		var deleteFieldContainer = path + '_container';
		var viewPath = path.split('.')[0];
		
		var successHandler = function(deleteFieldContainer,viewPath){
								return function(response){
									var node = dojo.place(dojo.trim(response),deleteFieldContainer);
									this.createEvents(dojo.byId(viewPath+"_loadEntry"));
									this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};

		var request = new ToolkitRequest('addDeleteField',
										 {'artifactType': 'view', 'path' : path,
										  'action': 'addDeleteField'},
										this,
										successHandler(deleteFieldContainer,viewPath),
										this.ajaxFailureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);

	},

	/**
	 * @override
	 * Function to handle all adds of page, pageElements and fieldElements
	 */
	addNew : function(path,action) {

		if(action == 'addField'){
			this.addField(path, action);

		} else if(action == 'addFieldSet'){
			this.addFieldSet(path, action);

		} else if(action == 'addDeleteField'){
			this.addDeleteField(path, action);

		} else if( action.indexOf('standard') > -1 ||
			action.indexOf('mutuallyExclusiveFieldSets') > -1 ||
			action.indexOf('display') > -1 ){
				this.addView(path, action);
		}
	}
});
