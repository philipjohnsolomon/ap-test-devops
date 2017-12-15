/**
 * @fileoverview This file contains the dialog box code.  It is used any time a dialog is needed to display data.
 * @author Rob W
 * @version 0.1
 */
/**
 * Constructs a new Dialog Box object.
 * @constructor
 * @class The dialog box is a class for creating input fields that have no
 * place in the main editor screen for the toolkit.  Examples: import, export, add and editor pallete tables.
 * @return A new Dialog Box instance
*/

dojo.declare("ToolkitDialogBox", null, {
	/**
	 * Constructor
	 * @param formId is the formId that will submit back to server
	 * @param type is the type of dialog we are creating
	 * @param errorMessage is the error message to show when something fails
	 * @param href is the href to the server to get content.  Not needed if content parameter is provided.
	 * @param isNew is the flag that signals whether this is a new set of data or not.
	 * @param path is the path of the item to add or edit.  This is used to delete the item on close.
	 * @param content is html content to add to the dialog box.  Not needed if href parameter is provided.
	 */
	constructor: function (formId, type, errorMessage, href, isNew, path, content) {
		this.dialog = null;
		this.dialogId = 'dijitDialog';
		this.dialogType = type;
		this.dialogHREF = href;
		this.dialogContent = content;
		this.isNewContent = isNew;
		this.dialogPath = path;
		this.formId = formId;
		this.error = errorMessage;
		this.product = ap.master.product;
		this.artifact = ap.master.artifact;
		this.menu = ap.toolkitNavMenu;
		this.loadDialog('ToolkitdialogId');
		this.events = new Array();
	},
	destroy: function () {
		if (this.dialog) {
			if (ap.master.paletteManagers) {
				var paletteManager = ap.master.paletteManagers.item(this.formId);
				if (paletteManager) {
					paletteManager.destroy();
					ap.master.paletteManagers.remove(this.formId);

					paletteManager = null;
				}
			}

			var eventsCnt = this.events.length;
			for (var ix = 0; ix < eventsCnt; ++ix) {
				var eventHandle = this.events.pop();
				dojo.disconnect(eventHandle);
				eventHandle = null;
			}
			this.events = null;

			if (this.searchSelect) {
				this.searchSelect.destroy();
				this.searchStore = null;
			}
			this.dialog.destroyRecursive(false);

			this.dialog = null;
		}
	},

	/**
	 * Creates a dialog with content
	 */
	loadDialog: function (dialogId) {

		var dialogBox = dijit.byId(dialogId);
		if (dialogBox) {
			dialogBox.destroyRecursive(false);
		}

		this.dialog = new dijit.Dialog({
			id: dialogId,
            title: '',
            onClick: dojo.hitch(this, function (event) {
            	this.onDialogClick(event);
            }),
            onCancel: dojo.hitch(this, function () {
            	this.onDialogClose();
            }),

 			onDownloadEnd: dojo.hitch(this, function (path) {
				return function () {
					ap.layoutManager.buildMenuButtons(ap.master, path, false);
					ap.master.createEvents(dojo.byId(path));
					this.createEvents(dojo.byId(path));
					this.loadSearchBox();

				};
			}(this.formId))
        });
		if (this.dialogHREF) {
			this.dialog.attr('href', this.dialogHREF + '&type=' + this.dialogType);
		} else if (this.dialogContent) {
			this.dialog.attr('content', this.dialogContent);
		} else if (this.error) {
			var errorDiv = dojo.byId("alert");
			if (!errorDiv) {
				errorDiv = dojo.doc.createElement('div');
				errorDiv.setAttribute('class', "critical");
				errorDiv.setAttribute('id', "alert");
				errorDiv.innerHTML = "<h4 class='critical'>Error</h4><p>" + this.error + "</p>";
			}
			this.dialog.attr('content', errorDiv);
		}
		//this error only happens when the jsp files are not compiled and does not cause any problems
		//but does cause a browser error.  This just stops that error from appearing.
		try {
			this.dialog.show();
		} catch (e) {
		}
	},

	loadSearchBox: function () {

		if (this.dialogType == 'search') {

			var node = dojo.byId('searchField');

			var itemComboBox = dijit.byId(node.id);
			if (itemComboBox) {
				itemComboBox.destroy(true);
			}

			this.searchStore = new dojo.data.ItemFileReadStore({
	            url: 'Toolkit?action=searchItems&artifactId=' + ap.master.artifact + '&product=' + ap.master.product
	        });

	        this.searchSelect = new dijit.form.ComboBox({
	                id: node.id,
	                store: this.searchStore,
			        searchAttr: "name",
					highlightMatch: 'all',
					value: node.value,
					autoComplete: false,
					queryExpr: '*${0}*',
					onChange: function (newValue) {
			        	if (this.item) {
			        		var keyNode = dojo.byId('searchKey');
			        		keyNode.value = this.item.uniqueId[0];
			        	}
					}
			}, node.id);
			ap.master.comboboxes.push(searchSelect);
		}
	},

	createEvents: function (startingElement) {
		var changeEventLists = dojo.query("select.change_event", startingElement);
		for (var i = 0; i < changeEventLists.length; i++) {
			var node = changeEventLists[i];
			var changeEventHandle = dojo.connect(node, 'change', this, function (node) {
  				  return function () {
  					  ap.master.dataEntryFieldChangeHandler(node);
  				  };
  			}(node));

			this.events.push(changeEventHandle);
		}
	},
	onDialogClose: function () {

		if (ap.master.paletteManagers) {
			var paletteMgr = ap.master.paletteManagers.item(this.formId);
			if (paletteMgr) {
				paletteMgr.removeValidation();
			}
		}
		if (this.dialogPath && this.isNewContent) {
			var item = dojo.byId(this.dialogPath + '_delete');
			if (item) {
				ap.master.deleteRow(item, true);
			}
		}
		ap.movedToPath = null;
		this.handleDialogHide(this.dialog);
	},

	onDialogClick: function (event) {
		var target = event.target;
		while (target && target.id != this.formId) {
			if (dojo.hasClass(target, 'dialogAction')) {
				this.submitDialog();
				return false;
			} else if (dojo.hasClass(target, 'apply')) {
				var dialogActionType = 'saveDialog';
				
				if (this.dialogType === 'copyField' || this.dialogType === 'copyBehavior') {
					dialogActionType = 'saveDialogCopy';
				}
				
				if (this.saveDialog(dialogActionType)) {
					ap.master.save();
					ap.master.hasUnsavedChanges = false;
					
					// if this is a move dialog, we need to save the move to path before closing.
					if (this.dialogType === 'move') {
						ap.movedToPath = dojo.byId(this.dialogPath + '.@movePath').value;
					} else if (this.dialogType === 'copyField') {
						ap.movedToPath = this.determineCopyMovePath();						
					} else if (this.dialogType === 'copyBehavior') {
						ap.movedToPath = dojo.byId('targetPath').value;
					}
					
					this.handleDialogHide(this.dialog);
				}
				return false;
			} else if (dojo.hasClass(target, 'dialogSearch')) {
				this.openSeachPane(target);
				this.handleDialogHide(this.dialog);
				return false;
			} else {
				ap.master.hasUnsavedChanges = false;
				target = target.parentNode;
			}
		}
	},

	/**
	 * Function that determines if we need to increment the last index of the move path
	 * during a copy.  If the user has chosed to add the field after an existing field 
	 * the index must be incremented to account for the new field.
	 */
	determineCopyMovePath: function () {
		
		var movePathCandidate = dojo.byId(this.dialogPath + '.@movePath').value;
		var openBracketPos = movePathCandidate.lastIndexOf("[");
		var closeBracketPos = movePathCandidate.lastIndexOf("]");
		var order = dojo.byId(this.dialogPath + '.@order').value;
		var index = movePathCandidate.substring(openBracketPos + 1, closeBracketPos);
			
		if (index >= 0 && order === 'after') {
			incrementedIndex = (Number(index) + 1).toString();
			var movePathBase = movePathCandidate.substring(0, openBracketPos);
			movePathCandidate = movePathBase + "[" + incrementedIndex + "]";
	    }
		return movePathCandidate;
	},
	
	/**
	 * Calls into setMenuFocus() if dialog is a move dialog.
	 */
	handleDialogHide: function (dialog) {
		if (this.dialogType === 'move' || this.dialogType === 'copyField' || 
			this.dialogType === 'copyBehavior') {
			
			// make sure unsaved changes are cleaned up
			ap.master.hasUnsavedChanges = false;
			
			if (ap.movedToPath !== null) {
				// and reload the editor if move path is set
				ap.toolkitNavMenu.setMenuFocus(this.artifact);
			}
		}
		ap.layoutManager.mainContainer.resize();
		dialog.hide();
	},

	/**
	 * Submits (form submit) the dialog back to the server and page refreshes
	 */
	submitDialog: function () {
		if (!this.validate()) {
			return;
		}

		var dialogForm = dojo.byId(this.formId);
		ap.master.hasUnsavedChanges = false;
		dialogForm.submit();
	},

	showErrorMessage: function (isValid, message) {
		var errorDiv = dojo.byId("validationCreateError");
		var errorP = dojo.query("> P", errorDiv)[0];
		
		if (message == null || message == "") {
		
			message = "Please address the validation error";
		
		}
		
		if (!isValid) {
			errorP.innerHTML = message;
			dojo.style(errorDiv, 'display', 'block');
			var tab = dojo.query('fieldset.fieldSet');
			dojo.addClass(tab, 'invalid');
			return;
		} else {
			dojo.style(errorDiv, 'display', 'none');
			errorP.innerHTML = "";
		}
	},

	validate: function () {
	
		var isValid = true;
		
		if (this.dialogType === 'importProduct') {
			var zipInputField = dojo.byId('file');
			
			// show an error message if the file is not a zip
			if (!zipInputField.value.match('.zip')) {
				this.showErrorMessage(false);
				return false;
			} else {
				this.showErrorMessage(true);
				return true;				
			}
		} else if (this.dialogType == 'copyField') {
			var dialogForm = dojo.byId('toolkitDialogForm');
		
			dojo.query('input', dialogForm).forEach(function (node) {

				 if (node.id != "" && node.id.indexOf('@type') == -1) {
				 	if (node.value == "") {
			
						isValid = false;
						message = "Field must contain a value";

					} else if (node.value.match(/^\d/)) {
			
						isValid = false;
						message = "Field cannot begin with a numeric value";
					}
				}
			});
			this.showErrorMessage(isValid, message);
			return isValid;	
			
		} else if (this.dialogType == 'copyProduct') {
		
			var titleField = dojo.byId('copyProduct_title').value;
			var productIdField = dojo.byId('copyProduct_ID').value;		
			
			if (titleField == "" || productIdField == "") {
			
				isValid = false;
				message = "Field must contain a value";
				
			} else if (titleField.match(/^\d/) || productIdField.match(/^\d/)) {
			
				isValid = false;
				message = "Field cannot begin with a numeric value";
			
			} else if (productIdField.length > 10) {
			
				isValid = false;
				message = "Product ID length cannot exceed 10 characters";
				
			} else {
			
				var menuProducts = this.menu.store._arrayOfTopLevelItems[0].children;
				var message = "";
				
				/**
				*  Perform validation on the user input title as well as the path that will be used for the 
				*  copied product. Want to ensure that neither already exist.
				*
				**/
				for (var i = 0; i < menuProducts.length; i++) {
				
					var node = menuProducts[i];
					var productLabel = node.label[0];
					var productType = node.productType[0];
					var productPath = node.path[0];
							
					if ((productType.toLowerCase() == productIdField.toLowerCase()) ||
							(productPath.toLowerCase() == productIdField.toLowerCase())) {
						
						message = "Product ID in use by an existing Product";
						isValid = false;
						break;
					}	
					
					if (titleField.toLowerCase() == productLabel.toLowerCase()) {
						message = "Product Title in use by an existing Product";
						isValid = false;
						break;
					}	
				}	
			}
			this.showErrorMessage(isValid, message);
			return isValid;		
		}
		
		if (ap.master.paletteManagers) {
			var paletteMgr = ap.master.paletteManagers.item(this.formId);
			var isValid = true;
			if (paletteMgr) {
				//isValid = paletteMgr.validateForm();
				isValid = this.validateForm(paletteMgr);
				this.showErrorMessage(isValid);
				return isValid;
			}
		}else{
			return isValid;
		}
	},
	validateForm: function (paletteMgr) {
			this.isValid = true;
			var tabsEnum = paletteMgr.tabs.getIterator();
			while (!tabsEnum.atEnd()) {
				var tab = tabsEnum.get().value;
				var valEnum = tab.getIterator();
				while (!valEnum.atEnd()) {
					var widget = valEnum.get().value;
					
					if (widget.required) {
						this.isValid = widget.validator(widget.value);
						
						if (!this.isValid) {
							widget.state = 'Error';
							widget.displayMessage(widget.getPromptMessage());
							widget.focus();
							this.isValid = false;
							break;
						}
					}
				}
			}
			return this.isValid;
		},
	/**
	 * Opens the editor accordion, menu and palette based on the
	 * search result entry
	 */
	openSeachPane: function(target) {
		var keyNode = dojo.byId('searchKey');
		var searchPath = keyNode.value;
		var searchPane = dojo.byId(searchPath + '_loadEntry');

		//Account for the fact the behaviors don't have an editor to speak of
		if (searchPath.indexOf('behavior') > -1) {
			ap.master.focusMenu(null, searchPath, searchPath);
		} else {
	    	ap.master.accordion.openPane(searchPane);
	    	ap.master.loadMenu(searchPath,"");
	    }

		ap.master.loadPalette(searchPath);

	},

	/**
	 * Submits the data back to the server (AJAX) and closes the dialog
	 */
	saveDialog: function (dialogType) {
		if (!this.validate()) {
			return false;
		}
		var successHandler = dojo.hitch(this, function(){
							return function (response) {
								 	this.destroy();
								};
						});

			//Create the ToolkitRequest
			var request = new ToolkitRequest(dialogType,
								 {'action': dialogType},
								 this,
								 successHandler(),
								 this.ajaxFailureHandler);
			request.form = dojo.byId(this.formId);
			//Register the request with ajax manager
			ap.AjaxManager.processRequest(request);
			return true;
	},

	ajaxFailureHandler: function() {
		alert(this.error);
	}
});
