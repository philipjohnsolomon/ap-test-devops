/**
 * @fileoverview This file contains the Dynamic List Template product definition
 * editor.  This will render an existing Dynamic List Template xml file for editing.
 * @author Rob Warner rwarner@agencyport.com
 * @version 0.1
 */
/**
 * Constructs a new Dynamic List Template object.
 * @constructor
 * @class The DynamicListEditor class sets up the editor for any dynamic list template files
 * for a given LOB.
 * @return A new DynamicListEditor instance
*/

/*
$ = function(){
    return dojo.query.apply(dojo, arguments);
};
dojo.mixin($, dojo);
*/

dojo.declare("DynamicListTemplateEditor",Editor, {
	constructor: function (product, artifactId, artifactType) {
	},

	
	dataEntryFieldChangeHandler: function(item){

		if(dojo.hasClass(item,'select_list_change')) {
			var itemId = item.id;	
			var selectFieldValue = dojo.byId(itemId).value;	
			this.updateComboBoxState(item,selectFieldValue );

		}		
		return false;
	},
	
	
	/**
	 * Gets called when nothing is found  in Editor class.  Hook point for click events
	 * @param item is the item clicked or the current item being processed
	 * @param event is the click event details
	 */
	onClickEvent: function(item, event) {
		if(dojo.hasClass(item,'autocomplete')) {
		
			var itemId = item.id;
			//exclude any widget objects
			if (itemId.indexOf('widget') == -1) {	
				var selectFieldValue = dojo.byId(itemId + '.@type').value;	
				this.updateComboBoxState(item, selectFieldValue);
			}
		} else if(dojo.hasClass(item, 'deleteRowAction')) {
			  this.deleteEditorRow(item);
		}
	},
	
	/**
	*  Function to disable combobox input when associated select list value of singleSpace is
	*  chosen.  Will enable combo boxes when a different value is chosen as well.
	*
	**/
	updateComboBoxState: function(item, selectFieldValue) {
	
		var itemId = item.id;
				
		var comboBoxPath =  itemId.split('.@type')[0];
		var combo = itemId.split('.@type')[0] + '_wrapperDiv';
		var comboContainer = dojo.byId(combo);
		var dijitWidget = dijit.byId(comboBoxPath, comboContainer);
				
		if(dijitWidget && dijitWidget instanceof dijit.form.ComboBox){
				
			if (selectFieldValue == 'singleSpace') {
				dijitWidget.setValue('');
				dijitWidget._setDisabledAttr(true);
			} else {
				dijitWidget._setDisabledAttr(false);
			}
		}
	},
	
	addNew: function(path,action){
		if(dojo.isFunction(this[action])){
			this[action].apply(this,[path,action]);
		}else{
			if(action == 'addDynamicList'){
				this.addDynamicList(path,action);
			}else if(action == 'addListField'){
				this.addDynamicListField(path,action);
			}
		}
	},
	/**
	 * Add new dynamic list template.
	 */
	addDynamicList: function addDynamicList(path,action) {
		
		toolkitPleaseWait(true);
		//we need a unique id
		var dynamicListTemplates = dojo.byId('accordion_container');

		var successHandler = function(dynamicListTemplates){
								return function(response){
								   
								    var node = dojo.place(dojo.trim(response),dynamicListTemplates);
									this.accordion.addAccordion(node);
									toolkitPleaseWait(false);
								};
							};

		//Create the ToolkitRequest
		var request = new ToolkitRequest('addDynamicList',
										 {'artifactType': 'dynamicListTemplate', 'action': action,
										  'path': path},
										 this,
										 successHandler(dynamicListTemplates),
										this.ajaxFailureHandler);
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);

	},

	/**
	 * Add new field from the server
	 * @param templateId Id of the DOM for the template top level
	 * @param templateIndex Index of the current dynamic list template
	 */
	addDynamicListField: function addDynamicListField(path, action) {
		toolkitPleaseWait(true);
		//count of current dynamic lists so when creating field ids we can create the correct x-path
		//var fieldCount = 0;
		var fieldContainerId = path+'_fields_container';
		var fieldContainer = dojo.byId(fieldContainerId);
		/*
		if(fieldContainer) {
			var fields = dojo.query('tr',fieldContainer);
			fieldCount = fields.length;
		}*/

		var successHandler = function(fieldContainer){
			return function(response){
			    dojo.place(dojo.trim(response),fieldContainer);
				var listPath = fieldContainer.id.split('.')[0];
			
				this.createEvents(dojo.byId(listPath+"_loadEntry"));
				
				toolkitPleaseWait(false);
			};
		};
		//Create the ToolkitRequest
		var request = new ToolkitRequest('addDynamicListField',
										 {'artifactType': 'dynamicListTemplate','path': path, 'action': action},
										 this,
										 successHandler(fieldContainer),
										 this.ajaxFailureHandler);
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},
	/**
	 * Searches the DOM for a specific style class and adds the proper event based on the class.
	 * @param startingElement Parent element used to start search for events that need adding.
	 */
	createEvents: function createEvents(startingElement) {
		this.inherited(arguments);
	}
});


