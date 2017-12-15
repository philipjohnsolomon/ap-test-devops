/**
 * @fileoverview This XARCRuleWizard is used to add/edit XArc rules.
 * @author Pradeep Namepally
 * @version 0.1
 */
/**
 * Constructs a Xarc editor/palette.
 * @constructor
 * @class The XARCRuleWizard class sets up the editor for adding/editing xarc rules.
 * @return A new XARCRuleWizard instance
*/
dojo.declare("XARCRuleWizard",Editor, /**
 * @author rwarner
 *
 */
{
	constructor: function(product, artifactId) {
	},


	/**
	 * Add new Variable.
	 * @param product Current product (LOB)
	 * @param artifactId Current artifact(view template in this case)
	 */
	addVariable: function addVariable(path,action) {
		var variableContainerId = path+'_variableContainer';
		this.addRuleEntity(path, action, variableContainerId);
	},
	/**
	 * Add new Variable.
	 * @param product Current product (LOB)
	 * @param artifactId Current artifact(view template in this case)
	 */
	addCondition: function addCondition(path,action) {
		var conditionContainerId = path+'_conditionContainer';
		this.addRuleEntity(path, action, conditionContainerId);
	},
	addCustom: function addCondition(path,action) {
		var conditionContainerId = path+'_conditionContainer';
		this.addRuleEntity(path, action, conditionContainerId);
	},
	/**
	 * Add new Message.
	 * @param product Current product (LOB)
	 * @param artifactId Current artifact(view template in this case)
	 */
	addMessage: function addMessage(path, action) {
		var messageContainerId = path+'_messageContainer';
		this.addRuleEntity(path, action, messageContainerId);
	},

	addRule: function(path,action){
		var rules = dojo.byId('accordion_container');
		this.addRuleEntity(path,action,rules);
	},
	/**
	 * Add new dynamic list template.
	 */
	addRuleEntity: function (path,action,container) {
		var successHandler = function(container,action){
								return function(response){
								    var node = dojo.place(dojo.trim(response),container);
								    if(node.id.indexOf('.')<0){
									    this.accordion.addAccordion(node);
									    this.accordion.openPane(node);
								    }
								    var path = node.id.split('_')[0];
								    if(action == "addCustom"){
								    	path = path + ".javaclass";
								    }
								    this.loadPalette(path);
									this.loadMenu(path);
									this.hasUnsavedChanges = true;
									toolkitPleaseWait(false);
								};
							};


		//Create the ToolkitRequest
		var request = new ToolkitRequest('addRuleEntity',
										 {'artifactType': 'rule', 'action': action,
										 'path': path},
										 this,
										 successHandler(container,action),
										this.ajaxFailureHandler);
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);

	},

	loadRule: function (accordionToggleId, action, container) {

		if(dojo.byId(accordionToggleId+'_ruledetails_div'))
			return;

		//function that would handle the sucessful reponse
		var successHandler = function(accordionToggleId, containerParam){
			return function(response){

				if (containerParam == null) {
					containerParam = accordionToggleId+'_container';
				}
				var node = dojo.place(dojo.trim(response),containerParam);
				this.focusMenu(null, accordionToggleId);
				this.focusPalette(null, accordionToggleId);
			};
		};

		//function that would handle the failure reponse
		var failureHandler = function(){
			alert('Something went wrong...');
		};

		//Create the ToolkitRequest
		var request = new ToolkitRequest('loadRule',
										 {'artifactType': 'rule',
										  'action': action, 'path': accordionToggleId
										  },
										 this,
										 successHandler(accordionToggleId, container),
										 failureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},

	dataEntryFieldChangeHandler: function(item){
		if(dojo.hasClass(item, 'pageEntityList_event')) {
			this.refreshPageEntityOptions(item);
			return false;
		}else if(dojo.hasClass(item,'show_options')){
			this.showOptions(item);
			var targetPath = item.id.split('.@');
			if(item.value === 'field') {
				var fieldPath = targetPath[0] + '.field.@fieldKey';
				var field = dojo.byId(fieldPath);
				this.refreshPageEntityOptions(field, true);
			} 
		}else if(dojo.hasClass(item,'operator_editor')){
			this.showSecondOperand(item);
		}else if(dojo.hasClass(item,'variableReference_event')){
			this.updateSelectListValues(item,'.@scope');
		}else if(item.focusNode && dojo.hasClass(item.focusNode,'dateAdd')){
			this.updateDateAdd(item);
		}else if(dojo.hasClass(item,'function_select_list_change')) {
			var itemId = item.id;	
			var selectFieldValue = dojo.byId(itemId).value;	
			var functionId = itemId.split(".@function")[0];
			var substringElement = dojo.byId(functionId + '.fn:substring_formRow');
			if(substringElement){
				if('fn:substring' == selectFieldValue){
					dojo.style(substringElement,"display","block");
				}else{
					dojo.byId(functionId + '.substr_start').value="";
					dojo.byId(functionId + '.substr_end').value="";
					dojo.style(substringElement,"display","none");
				}
			}
		}		
	},
	
	onClickEvent: function(item, event) {
		if(dojo.hasClass(item,'move_event')) {
			ap.master.save();
			ap.master.hasUnsavedChanges = false;
			this.loadMoveDialog(item);
		} else if(dojo.hasClass(item,'operator_editor')) {
			this.updateSelectListValues(item,'.@negate');
		} else if(dojo.hasClass(item, 'deleteRowAction')) {
			this.deleteMessage(item);
			
			var ruleId = item.id.split('.')[0];
			this.loadPaletteInternal(ruleId);
			this.loadMenu(ruleId);
		}
	},
	
	/**
	 * Deletes a message from the editor
	 * @param item is the button item that was clicked that contains the id of the field to delete
	 * @param skipConfirm is used to skip the delete confirmation.  Used when closing an unsaved dialog.
	 */
	deleteMessage: function(item, skipConfirm) {

		 var itemId = item.id;

		  var deleteId = itemId.replace("_delete", "");
		  var deleteElement = dojo.byId(deleteId);

		  var baseDeleteId = deleteId.replace("_wrapperDiv", "");
		  var deleteIndicatorField = baseDeleteId + '.@delete';

		  if (!skipConfirm && !confirmDelete(baseDeleteId))
		  	return;

		  this.hasUnsavedChanges = true;

		  if(deleteElement) {
			  dojo.style(deleteElement,"display","none");
			  dojo.byId(deleteIndicatorField).value = 'true';
		  }

		  return false;
	},
	
	showOptions: function(item){
		if(item.value == "expression"){
			var text = item.value;
			if(item.tagName && item.tagName.toLowerCase() === 'select'){
				text = item.options[item.selectedIndex].text;
			}
			this.updateTitle(item.id,text);
		}
		this.inherited(arguments);
	},
	showSecondOperand: function(item){
		var operandPath = item.id.replace('@type','') + 'operand[1]';
		var operand = dojo.byId(operandPath);
		var operandDelFlag = dojo.byId(operandPath + '.@delete');
		if(operand){
			if(item.value == "" || item.value == "true|"){
				dojo.style(operandPath,'display','none');
				operandDelFlag.value = "true";
			}else{
				dojo.style(operandPath,'display','block');
				operandDelFlag.value = "false";
			}
		}
		this.updateSelectListValues(item,'.@negate');
	},

	updateSelectListValues: function(item,attributePath){
		var fieldValue = item.value;
		var contentHiddenField = dojo.byId(item.id + '.@content');
		var attributeField = dojo.byId(item.id + attributePath);
		if(fieldValue.indexOf('|')>0){
			var attribute = fieldValue.split('|')[0];
			var content = fieldValue.split('|')[1];
			contentHiddenField.value = content;
			attributeField.value = attribute;
		}else{
			contentHiddenField.value = fieldValue.replace('|','');
			attributeField.value = "";
		}

	},

	findEntityToDisplay: function(path,option){
		var divToShowHide;
		var optionValue = option.value;
		if(optionValue == 'expression'){
			if(option.selected){
				focusTab.call(this,path + '_Expression_palette', path + '_Expression')
			}else{
				dojo.style(path + '_Expression_palette', 'display', 'none');
				dojo.style(path + '_Expression', 'display', 'none');
				dojo.removeClass(path + '_Expression', 'focusedTab');
			}
			var expDeleteField = dojo.byId(path + '.expression.@delete');
			if(expDeleteField){
				expDeleteField.value = 	!option.selected;
			}

			divToShowHide = dojo.byId(path + '_expression_palette');
		 }else{
		 	divToShowHide = dojo.byId(path + '.'+optionValue+'_formRow');
		 }
		return divToShowHide;
	},

    focusSubPalette: function(item){
		var paletteId = item.id + '_options_palette';
		var subPalette = dojo.byId(paletteId);
		if(subPalette){
			var subPaletteContainer = subPalette.parentNode;
			dojo.query('.expression_palette_tab',subPaletteContainer).forEach(function(node){
				dojo.style(node,'display','none');
			});
			dojo.query('td',item.parentNode).forEach(function(node){
				dojo.removeClass(node,'focused_page_entity');
			});

			dojo.style(subPalette,'display','block');
			dojo.addClass(item,'focused_page_entity');
		}
    },

	_pageBodyClickEventDelegateHandler: function(event,container) {

	    var item = event.target;

		if(!item) return;

		while (item.id != null && item.id != container.id) {
			if(dojo.hasClass(item,'expression_palette_toggle')) {
				this.focusSubPalette(item);
				return false;
			} else if(dojo.hasClass(item,'copy_event')) {
				var itemId = item.id;
				var path = itemId.split('_')[0];
				var action = itemId.split('_')[1];
				this.addRule(path,action);
				return false;
			 } else if(dojo.hasClass(item,'operator_editor')){
					if(dojo.isFunction(this.onClickEvent)) {
						//If select list is clicked on make sure current selected value is parsed correctly.
						this.onClickEvent(item, event);
						//Break instead of return to ensure that any change_event gets handled by parent.
						break;
					}	
			 }else{
			 	item = item.parentNode;
			}
    	}
		this.inherited(arguments);
	},

	updateTitle: function(itemId,text){
		if(itemId.lastIndexOf('.@fieldKey')>0){
			itemId = itemId.slice(0,itemId.lastIndexOf('.@fieldKey'));
		}
		if(itemId.lastIndexOf('.') != itemId.lastIndexOf('.@')){
			itemId = itemId.slice(0,itemId.lastIndexOf('.'));
		}
		this.inherited(arguments);
	},
	
	/**
	 * Sets the field data necessary for xarc to process the rule and redisplay in the editor.
	 * @param itemId is the field id that will have the value evaluated
	 * @param targetPath is the base path that is used for setting field values.
	 * @param transactionValue is the value of the transaction field.
	 * @param pageValue is the value of the page field
	 * @param pageElementValue is the value of the page element field
	 * @param fieldKey is the key to the field in the tdf, either uniqueId or id
	 * @param fieldValue is the value of the field selected
	 */
	setFieldData: function (fieldId, targetPath, transactionValue, pageValue, pageElementValue, fieldKey, fieldValue) {
		
		var fieldContentElement = dojo.byId(fieldId + '.@content');
		var fieldXpathElement = dojo.byId(targetPath);
		fieldContentElement.value = transactionValue + '/' + pageValue + '/' + pageElementValue + '/' + fieldKey;
		fieldXpathElement.value = fieldValue; 
		var fieldElement = dojo.byId(fieldId);
		var text = fieldElement.options[fieldElement.selectedIndex].text;
		this.updateTitle(fieldId,text);
	},
	
	/**
	 * Refreshes the page field selection drop downs.
	 * @param item is the item that was clicked.
	 * @param isChange is a boolean flag to determine if this is a change to a field type of operand.
	 * @returns {Boolean} false to stop processing the event
	 */
	refreshPageEntityOptions: function(item, isChange) {
		var itemId = item.id;
		var targetPath = itemId.split('.@')[0];
		var transactionPath = targetPath + ".@transactionKey";
		var transaction = dojo.byId(transactionPath);
		var pagePath = targetPath + '.@pageKey';
		var page = dojo.byId(pagePath);
		var pageElementPath = targetPath + ".@pageElementKey";
		var pageElement = dojo.byId(pageElementPath);
		var pageElementValue = pageElement.value;
		var fieldElementPath = targetPath + ".@fieldKey";
		var fieldElement = dojo.byId(fieldElementPath);
		var fieldElementValue = fieldElement.value;
		var fieldKey = fieldElementValue.split('|')[0];
		var fieldValue = fieldElementValue.split('|')[1];
		
		if(itemId.indexOf('.@fieldKey')>0 && !isChange){
			this.setFieldData(itemId, targetPath, transaction.value, page.value, pageElement.value, fieldKey, fieldValue);
			return;
		}
		//need to set page element to any for search when page is changed
		if(itemId.indexOf('.@pageKey') > 0) {
			pageElementValue = "*";
		}

		var successHandler = function(targetPath, clickedId, transaction, page, pageElement, fieldElement){
								return function(response){
									var node = dojo.create('div', {"id": "refreshOptions", 'innerHTML': dojo.trim(response)});
									var pageOptions = dojo.query('> #pageOptions', node)[0];
									var pageElementOptions = dojo.query('> #pageElementOptions', node)[0];
									var fieldElementOptions = dojo.query('> #fieldElementOptions', node)[0];
									if(clickedId.indexOf('@transaction') > 0) {
										//update all three if here
										dojo.empty(page);
										dojo.place(dojo.trim(pageOptions.innerHTML),page);
									}

									//only update this when the clicked id is not a page element
									if(clickedId.indexOf('@pageElement') == -1) {
										//update all three
										dojo.empty(pageElement);
										dojo.place(dojo.trim(pageElementOptions.innerHTML), pageElement);
									}

									//this will always get updated
									dojo.empty(fieldElement);
									var fieldElements = dojo.trim(fieldElementOptions.innerHTML);
									if(fieldElements.length > 0) {
										dojo.place(fieldElements, fieldElement);
										var fieldElementValue = fieldElement.value;
										var fieldKey = fieldElementValue.split('|')[0];
										var fieldValue = fieldElementValue.split('|')[1];
										this.setFieldData(fieldElement.id, targetPath, transaction.value, page.value, pageElement.value , fieldKey, fieldValue);
									}

									node = null;
							    };
						    };

		//Create the ToolkitRequest
		var request = new ToolkitRequest('refreshFor',
										 {'path': targetPath, 'action': 'refreshFor', 'transaction': transaction.value,
										 'page' : page.value, 'pageElement': pageElementValue, 'fieldElement': fieldKey
										 },
										 this,
										 successHandler(targetPath, itemId, transaction, page, pageElement, fieldElement),
										this.ajaxFailureHandler);
		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
		  return false;
	},
	
	updateDateAdd: function(item){
		var dateFieldId = item.id.split('_')[0];
		
		var yearFieldValue = dojo.byId(dateFieldId+"_years").value;
		var monthsFieldValue = dojo.byId(dateFieldId+"_months").value;
		var daysFieldValue = dojo.byId(dateFieldId+"_days").value;
		
		yearFieldValue = (yearFieldValue.length == 0)?"0":yearFieldValue;
		monthsFieldValue = (monthsFieldValue.length == 0)?"0":monthsFieldValue;
		daysFieldValue = (daysFieldValue.length == 0)?"0":daysFieldValue;
				
		var dateValue = 'P'+ yearFieldValue + 'Y'
						   + monthsFieldValue + 'M'
						   + daysFieldValue + 'D';
		
		var dateField = dojo.byId(dateFieldId);
		dateField.value = dateValue;
		
		this.updateTitle(dateFieldId, yearFieldValue + ' Years, ' + monthsFieldValue + ' Months, ' + daysFieldValue + " Days");
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
	}
});
