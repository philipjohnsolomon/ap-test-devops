/**
 * @fileoverview This file contains the cover sheets for the left navigation menu.
 * this also calls out when a file is clicked to create dialog boxes from this menu.
 * @author Rob W
 * @version 0.1
 */
/**
 * Constructs a new CoversEditor object.
 * @constructor
 * @class The CoverEditor class sets up the editor for any cover pages.
 * @return A new CoversEditor instance
*/

dojo.declare("CoversEditor", null, {
	constructor: function(type, productId, artifactType) {
		this.dialog = null;
		this.productId = productId;
		this._pageBodyClickEventDelegate = null;
		this.events = new Array();
		this.lastEvent = new Array();
		this.lastButton = null;
		this.menuItem = this.getMenuItem(this.productId);
		this.paletteManagers = new dojox.collections.Dictionary();
		this.loadCover(type, productId, artifactType);
	},
	destroy: function() {
		ap.layoutManager.destroy(true);
		this.destroyLastEvent();
		//Destroy all the events
		dojo.disconnect(this._pageBodyClickEventDelegate);
		if(this.events) {
			var eventsCnt = this.events.length;
			for(var ix=0;ix<eventsCnt;++ix){
				var eventHandle = this.events.pop();
				dojo.disconnect(eventHandle);
				eventHandle = null;
			}
		}
		if(this.dialog) {
			this.dialog.destroy();
			this.dialog = null;
		}

		if(this.paletteManagers) {
			var e=this.paletteManagers.getIterator();
			while(!e.atEnd()){
				e.get().value.destroy();
			}
		}

		var wizard = dojo.byId('wizard');
		if (wizard) {
			dojo.empty(wizard);
		}

		this._pageBodyClickEventDelegate = null;
		this.pageBody = null;
		this.menuItem = null;
		wizard = null;
		this.lastEvent = null;
		this.events = null;
		this.menuItem = null;
		this.dialog = null;
		this.paletteManagers = null;
	},

	loadCover: function(type, productId, artifactType) {
		//function that would handle the successful response
		var successHandler = function(response){
			/**
			*	A reference to the pageBody.
			*/
			//this.pageBody = dojo.byId('pageBody');
			dijit.byId('editorWrapper').set('content', response);
			//this.pageBody.innerHTML = response;
			var wizard = dojo.byId('wizard');
			ap.layoutManager.initializeEditorLayout(true);
			ap.layoutManager.buildMenuButtons(this, 'contextAction');
			//ap.layoutManager.mainContainer.resize();
			this.createEvents(wizard);
		};

		//function that would handle the failure reponse
		this.failureHandler = function(){
			alert('Failed to load cover page');
		};

		//Create the ToolkitRequest
		var request = new ToolkitRequest('loadCover'+this.artifactType,
										 {'artifactType': artifactType, 'type': type, 'action': 'cover', 'productId': productId},
										 this,
										 successHandler,
										 this.failureHandler);

		//Register the request with ajax manager
		ap.AjaxManager.processRequest(request);
	},


	/**
	 * createsEvents to be called by all descendants class to take care of page sizing and
	 * adding save event.
	 * @param startingElement Parent element used to start search
	 */
	 createEvents: function(startingElement) {
		 if(startingElement && startingElement.id == 'wizard'){

			 var clickHandler = function(event){
				 this._pageBodyClickEventDelegateHandler(event,dojo.byId('wizard'));
			 };
			 this._pageBodyClickEventDelegate = dojo.connect(dojo.byId('wizard'),'click',this,clickHandler);

		 } else if(startingElement.id != null && startingElement.id.match('toolkitDialogForm')){
			this.registerDijitWidgets(startingElement,'.fieldSet');
		}
	 },

	 destroyLastEvent: function(){
			if(this.lastEvent) {
				var cnt = this.lastEvent.length;
				for(var ix=0;ix<cnt;ix++){
					var eventHandle = this.lastEvent.pop();
					dojo.disconnect(eventHandle);
					eventHandle = null;
				}
			}
		},

	 _pageBodyClickEventDelegateHandler : function(event,container) {

		    var item = event.target;
			if(!item || item.tagName == 'A') return;
			dojo.stopEvent(event);

			this.destroyLastEvent();

			if(this.lastButton) {
				//ap.master.lastButton.destroy();
				this.lastButton.hideOptions();
			}

			while (item.id != null && item.id != container.id) {
				if(dojo.hasClass(item,'deleteProduct')){
					this.menuItem = this.getMenuItem(this.productId);
				 	var itemId = item.id;

					var productId = itemId.split('_')[0];

				 	if (!confirmDelete(this.menuItem.label[0]))
						return;

					this.deleteProduct(productId);

			  		return false;

			  	 } else if(dojo.hasClass(item,'addArtifact')){
					var itemId = item.id;
					var productId = itemId.split('_')[0];
					var type = itemId.split('_')[1];

					this.dialog = new ToolkitDialogBox('toolkitDialogForm', type,
							null, 'toolkit/create/createArtifact.jsp?product=' +productId+'&type='+type);

			  		return false;
			  	 } else if(dojo.hasClass(item,'addArtifactFromXML') || dojo.hasClass(item,'addArtifactFromPDF')){
					var itemId = item.id;
					var productId = itemId.split('_')[0];
					var type = itemId.split('_')[1];

					this.dialog = new ToolkitDialogBox('toolkitDialogForm', type,
							null, 'toolkit/create/importArtifact.jsp?product=' +productId+'&type='+type);

			  		return false;
				 } else if(dojo.hasClass(item,'exportProduct')){
				 	var itemId = item.id;
					var productId = itemId.split('_')[0];

					var iframe = dojo.create('iframe', {src: "Toolkit?action=export&type=exportProduct&productId=" + productId});
			  		iframe.style.display = 'none';
			  		document.body.appendChild(iframe);
			  		return false;
			  		
			  	} else if(dojo.hasClass(item,'exportExcel')){
				 	var itemId = item.id;
					
				 	alert('Please be aware that the export process may take several seconds.');
				 	
					var productId = itemId.split('_')[0];
					var artifactType = itemId.split('_')[1];
					var iframe = document.createElement('iframe');
					iframe.style.display = 'none';
					iframe.src = 'Toolkit?action=export&type=exportExcel&productId=' + productId +'&artifactType=' + artifactType;
					
			  		document.body.appendChild(iframe);
			  		this.handleIframeResponse(iframe);

			  		return false;

				} else if(dojo.hasClass(item,'transferAction')){
					var itemId = item.id;
					var type = itemId.split('_')[0];

					this.dialog = new ToolkitDialogBox('toolkitDialogForm', type,
							null, 'toolkit/create/' + type + '.jsp?type=' + type);

			  		return false;
			  		
				} else if(dojo.hasClass(item,'copyProduct')){
					var itemId = item.id;
					var productId = itemId.split('_')[0];
					
					this.dialog = new ToolkitDialogBox('toolkitDialogForm','copyProduct', null,'toolkit/shared/copyProduct.jsp?product=' +productId);
			  		return false;
				} else if(dojo.hasClass(item, 'action')) {
					var button = new MenuButton(item);
					button.showOptions();
					this.lastButton = button;
			  		return false;
				}else if(dojo.hasClass(item, 'dropShadow')){
					return false;
				}else{
					item = item.parentNode;
				}
	    	}

		},

		deleteProduct: function(productId){
			//function that would handle the successful response
			var successHandler = dojo.hitch(this, function(productId) {
				 return function(){
					var navMenu = ap.toolkitNavMenu;
					//delete the item from the menu
					if(this.menuItem) {
						navMenu.store.deleteItem(this.menuItem);
					}
					//now load the root cover so everything looks normal
					var root = navMenu.store._arrayOfTopLevelItems[0];
					ap.master = ap.toolkitNavMenu.createCover(root.cover);
				 };
			});

			//function that would handle the failure reponse
			this.failureHandler = function(){
				alert('Something went wrong...');
			};

			//Create the ToolkitRequest
			var request = new ToolkitRequest('deleteProduct'+productId,
											 {'action': 'delete',
											 'type' : 'deleteProduct',
											  'productId' : productId},
											 this,
											 successHandler(productId),
											 this.failureHandler);

			//Register the request with ajax manager
			ap.AjaxManager.processRequest(request);
		},

		/**
		 * This retrieves a menu item when given a product id, same id as the menu item from data store.
		 * @param id is the id of the menu item to retrieve
		 * @return the menu item with product id as the identifier
		 */
		getMenuItem: function(id) {
			var navMenu = ap.toolkitNavMenu;
			var item = null;
			if(navMenu) {
				item = navMenu.store._itemsByIdentity[id];
			}
			return item;
		},

		registerDijitWidgets: function(startingElement, paletteTabQueryClass){
			var paletteManager = null;
			if(this.paletteManagers.item(startingElement.id)){
				paletteManager = this.paletteManagers.item(startingElement.id);
			}else{
				paletteManager = new PaletteManager(startingElement);
				this.paletteManagers.add(startingElement.id,paletteManager);
			}
			var temp = dojo.query("input[type='text'], TEXTAREA",startingElement);
			var regValFun = function(tabClassName){
								return function(item,index,array){
									paletteManager.registerValidations(item,tabClassName);
								}
							};
			dojo.forEach(temp,regValFun(paletteTabQueryClass),paletteManager);
		},
		/*
		*Check if the field in question is not visible.
		*It is not visible if the field or any of its ancesters are not visible.
		*/
		isVisible: function(domNode){
			var isInvisible = dojo.some(dojo.query(domNode).parents(),function(ancestor){
				return (ancestor.style.display == 'none');
			});
			return !isInvisible;
		},
		
		/*
		 * Checks iframe respone for a document, which indicates an error condition.
		 * Retrieves message and display it in a dialog box.
		 * 
		 * @param {Object} iframe
		 */
		handleIframeResponse: function(iframe) {
	
			iframe.handleError = function(iframe) {
				var doc = iframe.contentWindow.document;
				if (doc){

					var response = doc.body.innerHTML;
					if (response) {
						response = eval('(' + response + ')');
						var message = '<p>' + response.status + ' - ' + response.message + '</p>';
						
						var dialogBox = new ToolkitDialogBox('excelExportForm', null,
											'Error', null, true, null, message);
					}
				}
			}
			  		
			//IE handles iframe load in different manner than other browsers
			if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera){
						
    			iframe.onreadystatechange = function(){
    						
					if (iframe.readyState == "complete" ){					        	
				   		iframe.handleError(iframe);					        
					}
    			};
			} else {
						
			    iframe.onload = function(){
			    	iframe.handleError(iframe);
			    };
			}
		}
});
