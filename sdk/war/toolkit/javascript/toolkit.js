ap = {};
	
/*
 * Method to check if the string ends with the suffix provided.
 */
ap.endsWith = function(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
};

ap.beginsWith = function(/* string */ search, /* string */ value, /* bool */ trimBefore) {
    if(trimBefore) {
    	search = dojo.string.trim(search);
    }
    if(search.length > value.length) {
        return false;
    }
    return value.substr(0,search.length) === search;
};

/*
* Function to give a deleteConfirmation
*/
function confirmDelete(itemId) {

	var display = false;

	if (ap.endsWith(itemId, '_wrapperDiv'));
		itemId = itemId.replace('_wrapperDiv','');

	//find the first acceptable thing to display
	if (!display && dojo.byId(itemId+".@title"))
		display = dojo.byId(itemId+".@title").value;
	//these two cases are for transactions which have no leading .
	else if (!display && ap.beginsWith('N', itemId, true) && dojo.byId("@title"))
		display = dojo.byId("@title").value;
	else if (!display && ap.beginsWith('N', itemId, true) && dojo.byId("@id"))
		display = dojo.byId("@id").value;
	//end transaction cases
	else if (!display && dojo.byId(itemId+".@legend"))
		display = dojo.byId(itemId+".@legend").value;
	else if (!display && dojo.byId(itemId+".@label"))
		display = dojo.byId(itemId+".@label").value;
	else if (!display && dojo.byId(itemId+".@name"))
		display = dojo.byId(itemId+".@name").value;
	else if (!display && dojo.byId(itemId+".@target"))
		display = dojo.byId(itemId+".@target").value;
	else if (!display && dojo.byId(itemId+".@id"))
		display = dojo.byId(itemId+".@id").value;
	else if (!display && dojo.byId(itemId+".@key"))
		display = dojo.byId(itemId+".@key").value;
	else if (!display && dojo.byId(itemId+".@content"))
		display = dojo.byId(itemId+".@content").value;
	else if (!display && dojo.byId(itemId) && (dojo.byId(itemId).nodeName=='INPUT' || dojo.byId(itemId).nodeName=='SELECT'))
		display = dojo.byId(itemId).value;
	else if (!display && dojo.byId(itemId+"_type"))
		display = dojo.byId(itemId+"_type").value;
	else
		display = itemId;

	return confirm("Are you sure that you want to delete : " +display);
};


/**
 * Show the please wait message, if the parameter is true.  This will block user 
 * entry until all AJAX calls have finished.  For each editor there are 3 calls so each
 * one should finish before the user can edit.
 * @param block is true if the overlay will be shown or false if not.
 */
function toolkitPleaseWait(block) {
	try {
		if(!ap.standby) {
			ap.standby = new dojox.widget.Standby({target: "editorPane"});
			document.body.appendChild(ap.standby.domNode);
			ap.standby.startup();
		}
	   
		if(block) {
			ap.standby.show();
			var displayStyle = 'block';
		} else {
			ap.standby.hide();
		}
	} catch(e) {
		console.error(e);
	}
};

/*
*	Layout Manager is used to setup the dojo layout.  
*/
dojo.declare("LayoutManager", null, {
	constructor: function (options) {
				
			this.mainContainer = new dijit.layout.BorderContainer({'design':'sidebar'}, 'mainContainer');
			this.navMenuPane = new dijit.layout.ContentPane({'region':'left', 'splitter':true, style:"width:15%"}, 'menuPane');
			this.mainContainer.addChild(this.navMenuPane);
			this.editorPane = new dijit.layout.ContentPane({'region':'center'}, 'editorPane');
			this.mainContainer.addChild(this.editorPane);
			this.editorForm  = new dijit.form.Form({},"editorForm");
			this.editorWrapperPane = new dijit.layout.ContentPane({'region':'center'}, 'editorWrapper');
			this.mainContainer.startup();
	},
	
	initializeEditorLayout: function (isCover) {
		this.editorWrapper = new dijit.layout.BorderContainer({'design': 'headline', 'class': 'editorWrapper'}, 'wizard');
		if(!dojo.query('div.locked_artifact', 'wizard')[0]) {
			this.menuContentPane = new dijit.layout.ContentPane({'region': 'top'}, 'contextAction');
			this.editorWrapper.addChild(this.menuContentPane);
			this.editorContentPane = new dijit.layout.ContentPane({'region': 'center'}, 'editor');
			this.editorWrapper.addChild(this.editorContentPane);
			if(!isCover) {
				this.palettePane = new dijit.layout.ContentPane({'region': 'bottom', 'splitter':'true'}, 'paletteContainer');
				this.editorWrapper.addChild(this.palettePane);
			}	
					
			if(this.palettePane) {
				if(isCover) {
					dojo.style(this.palettePane.domNode, "display", "none");
				} else {
					dojo.style(this.palettePane.domNode, "display", "");
				}
			}
		}
		if(!dojo.isChrome){
			this.editorWrapper.startup();
			this.mainContainer.resize();
		}
	},
	
	/**
	 * Builds the buttons for the menu.
	 * @param editor the editor this belongs to
	 * @param menuElement the menu container to search from
	 * @param canHaveDuplicates if two ids will be identical and need separate buttons
	 */
	buildMenuButtons: function(editor, menuElement, canHaveDuplicates) {
		//create the dropdown button if needed
		dojo.query('div.action', menuElement).forEach(dojo.hitch(this, function(node, index) {
	 		var button = dijit.byId(node.id);
	 		if(button && canHaveDuplicates) {
	 			node.id = node.id + "_" + menuElement;
	 		} 
	 		if(!button || canHaveDuplicates) {
		 		if(dojo.hasClass(node, 'dropdown')) {
		 			var menuNode = dojo.query('div.dropShadow', node)[0];
		 			var menu = new dijit.Menu({}, menuNode);
		 			var list = dojo.query('ul', node)[0];
		 			dojo.query('li', node).forEach(function(node) {
		 				var menuItem = new dijit.MenuItem({
		 					label: node.innerHTML,
		 					title: node.title,
		 					onClick: dojo.hitch(editor, function(event) {
			 					ap.master._pageBodyClickEventDelegateHandler(event, menuNode);
			 				})
		 				}, node.id);
		 				menu.addChild(menuItem);
		 				menuItem.set("class", node.className);
		 			});
		 			button = new dijit.form.DropDownButton({
		 				label: dojo.query('span.apbuttonLabel', node)[0].innerHTML,
		 				dropDown: menu,
		 				title: node.title
		 			}, node.id);
		 			dojo.destroy(list);
		 		} else {
		 			var button = new dijit.form.Button({
		 				label: dojo.query('span.apbuttonLabel', node)[0].innerHTML,
		 				title: node.title,
		 				onClick: dojo.hitch(editor, function(event) {
		 					ap.master._pageBodyClickEventDelegateHandler(button.id);
		 				})
		 			}, node.id);
		 			dojo.addClass(button.focusNode, node.className);
		 		}
	 		}
    	 }));
	},
	
	destroy: function(destroyLayout) {
		this.palettePane = null;
		this.menuContentPane = null;
		this.editorContentPane = null;
		if(this.editorWrapper) {
			this.editorWrapper.destroyRecursive(false);
		}
		this.editorWrapper = null;
		if(!destroyLayout) {
			this.editorWrapperPane.destroy();
			this.editorWrapperPane = null;
			this.editorForm.destroy();
			this.editorForm = null;
			this.mainContainer.destroyRecursive();
			this.mainContainer = null;
		}
	}
});

/**
 * The MenuButton class manages the toolkit menu buttons.  It is only responsible
 * for the behavior of the buttons themselves, not the actions that they should
 * trigger.  So, after creating a MenuButton object to manage your new button,
 * be sure to register whatever events you need to on that button to make it fire
 * your events.
 */

dojo.declare("MenuButton", null, {

	/**
	 * Set up object, and register events on on it to make it behave properly.
	 */
	constructor: function (domId) {
		/**
		 * The button itself
		 */
		this.node = dojo.byId(domId.id);

		//array to hold all events for this button
		this.buttonEvent = new Array();
		/**
		 * the option list, if this is a dropdown button.  If not, this will be null.
		 */
		this.options = null;

		//var optionsList = this.elt.select('div.dropShadow');
		var optionsList = dojo.query('div.dropShadow', dojo.byId(domId.id));
		if (optionsList) this.options = optionsList[0];


		dojo.connect(this.node, 'mouseover', this, this.mouseOver(this.node));
		dojo.connect(this.node, 'mouseout', this, this.mouseOut(this.node));
		dojo.connect(this.node, 'mousedown', this, this.mouseDown);
		dojo.connect(this.node, 'mouseup', this, this.mouseUp);
		dojo.connect(document.body, 'mouseup', this,this.mouseUp);
		if (this.options) {
			this.optionsDefaultTopOffset = this.options.style.top;
			//dojo.connect(this.node, 'click', this,this.eltClick);
			dojo.connect(document.body, 'click', this, this.bodyClick);
			dojo.query('li',this.options).forEach(dojo.hitch(this,function (item) {
				dojo.connect(item, 'click', this,this.eltClick);
				dojo.connect(item, 'mouseover', this, this.mouseOver(item));
				dojo.connect(item, 'mouseout', this, this.mouseOut(item));
			}));

		}
		// Prevent selecting button text in IE:

		this.node.onselectstart = function () {return false;};
	},
	/**
	 * Destroy everything associated with this button
	 */
	destroy: function () {
		if(this.buttonEvent) {
			dojo.forEach(this.buttonEvent, function(item, index) {
				dojo.disconnect(item);
			});
		}
		this.buttonEvent = null;
	},

	/*
	 * Used to create events for button.
	 */
	createButtonEvents: function (node, type, eventFunction) {
		this.buttonEvent.push(dojo.connect(this.node, type, this, eventFunction));
	},
	/**
	 * When the mouse is hovered over the button, the 'hover' class is added to it.
	 */
	mouseOver: function (element) {
		return function(){
			dojo.addClass(element, 'hover');
		};
	},
	/**
	 * When the mouse stops hovering over the button, the 'hover' class is removed.
	 */
	mouseOut: function (element) {
		return function(){
			dojo.removeClass(element, 'hover');
		};
	},
	/**
	 * When the button is clicked, we add the 'click' class, so that we can get
	 * the tactile feedback.
	 */
	mouseDown: function () {
		dojo.addClass(this.node, 'click');
	},
	/**
	 * When the click is released, the 'click' class is removed to complete the
	 * tactile feedback.
	 */
	mouseUp: function (evt) {
		dojo.removeClass(this.node,'click');
	},
	/**
	 * If the document's body is clicked anywhere, and this button's dropown
	 * options are displayed (if it is a dropdown button), we need to hide them.
	 */
	bodyClick: function () {
		if (this.optionsCurrentlyShown) {
			this.hideOptions();
		}
	},
	/**
	 * When the button is clicked, the options should be shown. If this is not
	 * a dropdown button, nothing will happen.
	 */
	eltClick: function (evt) {
		//evt.stop();
		this.optionsCurrentlyShown ? this.hideOptions() : this.showOptions();
	},
	/**
	 * Hides the dropdown options.
	 */
	hideOptions: function () {
		if(this.options) {
			dojo.removeClass(this.node, 'click');
			//dojo.fadeOut({duration: 300, node : this.options}).play();
			dojo.style(this.options,'display','none');
			this.optionsCurrentlyShown = false;
		}
	},
	/**
	 * Shows the dropdown options.
	 */
	showOptions: function () {

		//Close any other dropdowns that may be open
		dojo.query('div.dropShadow').forEach(function(item, i) {
			dojo.style(item,'display','none');
		});

		// determine if we should pop up or down:
		//need to convert to dojo
		if(this.options) {
			this.options.style.top = this.optionsDefaultTopOffset;
			dojo.style(this.options,'display','block');
			this.optionsCurrentlyShown = true;
		}
	}
});


/**
 * Shows the palette that has been clicked and hides the other palettes.
 * @param idToShow The id of the field we will show
 * @param idToHighlight The id of the palette "tab" that will be highlighted
 * @return
 */
function focusTab(idToShow, idToHighlight){

	//need to grab the parent so we can loop through tabs and palette content
	var highlightId = dojo.byId(idToHighlight);
	var tabListParent = dojo.byId(highlightId.parentNode);
	var paletteRoot = dojo.byId(tabListParent.parentNode);
	//grabing palette content and tabs
	var subpalettes = dojo.query('.palette_tab',paletteRoot);
	var tabs = dojo.query('.tab',tabListParent);

	//hide all palettes
	for (var i=0; i < subpalettes.length; i++){
		dojo.style(subpalettes[i], 'display', 'none');
	}

	//remove the focus from currently focused tab
	for (var i=0; i < tabs.length; i++){
		dojo.removeClass(tabs[i], 'focusedTab');
	}

	//show new palette content
	var paletteTab = dojo.byId(idToShow);
	dojo.style(paletteTab, 'display', 'block');

	//focus on proper tab
	if (highlightId) {
		dojo.style(highlightId, 'display', 'inline');
		dojo.addClass(highlightId, 'focusedTab');
	}

	subpalettes = null;
	tabs = null;
	highlightId = null;
	tabListParent = null;
	paletteRoot = null;
};

/*
* Ajax Manager class is the gateway for all the ajax calls made to the server.
* It processes one call at a time and does not let duplicate call to go to the server(e.g when a link is clicked twice)
*
*/
dojo.declare("AjaxManager",null,{
	/*
	* Initialize the class.
	*/
	constructor: function () {
		this.init();
	},

	/*
	* Destruct the class.
	*/
	selfDestruct: function () {
		this.ajaxQueue = null;
	},

	init: function(){
		this.ajaxQueue = new Array();
		this.requestInProgress = false;
	},
	/*
	*Main function that deals with determining if an ajax has to be processed
	* and queues it up for processing
	*/
	processRequest: function(toolkitRequest){
		//check if the toolkitRequest is already in queue.
		var queueLen = this.ajaxQueue.length;
		var reqExists = false;
		for(var ix=0;ix<queueLen;++ix){
			if(toolkitRequest.reqId == this.ajaxQueue[ix].reqId){
				reqExists = true;
				break;
			}
		}

		if(reqExists == true){
			console.info("Request already being processed");
			return;
		}

		this.ajaxQueue.push(toolkitRequest);

		if(this.requestInProgress == false){
			this.execute();
		}
	},

	/*
	*Execute the ajax request
	*/
	execute: function(){
		if(this.ajaxQueue.length > 0){
			this.call(this.ajaxQueue[0]);
		}
	},

	/*
	*This is where the actual Ajax call happens.
	*Bind the appropriate object instance to execute the response handlers.
	*/
	call: function(req){
		this.requestInProgress = true;
		var successHandler = function(transport,ioArgs){
			var handler = req.onSuccess.apply(req.caller, [transport,ioArgs]);
		 };
		var failureHandler = function(){
	  		var handler = req.onFailure.apply(req.caller);
			this.removeRequest(req);
		};
		var completHandler =function(){
			this.removeRequest(req);
			this.requestInProgress = false;
	  		this.execute();
	  		};

		dojo.xhrPost({
			url: req.url,
			content: req.parameters,
			form: req.form,
			load: dojo.hitch(this,successHandler),
			error: dojo.hitch(this,failureHandler),
			handle: dojo.hitch(this,completHandler)
		});

	},
	removeRequest: function(req){
  		dojo.forEach(ap.AjaxManager.ajaxQueue, function(item,index,array){
			if(array[index] == req){
				var element = array.splice(index, 1);
				element = null;
			}
		});
	}
});

//Store the refernce of AjaxManger in ap namespace
ap.AjaxManager = new AjaxManager();

/*
* ToolkitRequest class warps the request parameters and response handlers for a given ajax request.
*/
dojo.declare("ToolkitRequest",null, {
	/*
	*Initialize the request.
	*@param reqId is the indentifier used to check if a particular call is in progress.
	*@param caller is the instance of the calling class
	*@param url is the URL for the server. It is always 'Toolkit'
	*@param method is the Http method. We always use 'post'
	*@param parameters is the array of parameters.
	* 	e.g. Post the name value pairs
		{'templateid': templateId, 'templateIndex': templateIndex, 'index': fieldCount }
	*   e.g. Post the data on a particular div
		var formData = Form.serialize($('editor'), true);
	*@param onSuccess is the function that is supposed to be called on sucessful execution of ajax call
	*@param onFailure is the function that is supposed to be called on failure of execution of ajax call
	*/
	constructor: function (reqId, reqParams, caller, sucessHandler, failureHandler) {
		this.reqId = reqId;
		this.form = null;
		this.caller = caller;
		this.url = 'Toolkit?product=' + caller.product + '&artifactId=' + caller.artifact;
		this.method = 'post';
		this.parameters = reqParams;
		this.onSuccess = sucessHandler;
		this.onFailure = failureHandler;
	}
});
ap.Validation={};
ap.Validation.Required = {
	validator: function (value, constraints) {
		if(ap.master.isVisible(this.domNode) && this.required && value.length == 0){
				return false;
		}else{
			return true;
		}
	},
	props: {
		promptMessage: 'Please enter a value',
		invalidMessage: 'Please enter a numeric value'
	},
	getProps: function(){
		return dojo.clone(this.props);
	}
};

ap.Validation.Numeric = {
	validator: function (value, constraints) {
		if(ap.master.isVisible(this.domNode) && this.required && value.length == 0){
				return false;
		}

		if ((dojo.trim(value).length > 0 && !value.match(/^\d*$/))) {
			return false;
		}else{
			return true;
		}
	},
	props: {
		promptMessage: 'Please enter a value',
		invalidMessage: 'Please enter a numeric value'
	},
	getProps: function(){
		return dojo.clone(this.props);
	}

};

ap.Validation.AlphaNumeric = {
	validator: function (value, constraints) {
		if(ap.master.isVisible(this.domNode) && this.required && value.length == 0){
				return false;
		}
		if (!value.match(/^[\d\w]*$/)) {
			return false;
		}else{
			return true;
		}
	},
	props: {
		promptMessage: 'Please enter a value',
		invalidMessage: 'Please enter an alphanumeric value'
	},
	getProps: function(){
		return dojo.clone(this.props);
	}
};
ap.Validation.IdCharacters = {
	validator: function (value, constraints) {
		if(ap.master.isVisible(this.domNode) && this.required && value.length == 0){
				return false;
		}

		if (value.match("/[<>\"/]/") || (this.required && value.length == 0)) {
			return false;
		}else{
			return true;
		}
	},
	props: {
		promptMessage: 'Please enter a value',
		invalidMessage: "Please enter a unique value. Please do not use spaces, <, >, /,"
	},
	getProps: function(){
		return dojo.clone(this.props);
	}
};

ap.Validation.CheckboxGroup = {
	validator: function (value, constraints) {
		var id = this.id;
		var formRow = dojo.byId(id+"_formRow");
		if(formRow != null && formRow.parentNode != null){
			if(dojo.query('input:checked', formRow.parentNode).length == 0)
				return false;
		}

		return true;

	},
	props: {
		promptMessage: 'Please select at least one checkbox',
		invalidMessage: 'Please select at least one checkbox'
	},
	getProps: function(){
		return dojo.clone(this.props);
	}
};

dojo.declare("PaletteManager",null, {
	"-chains-": {
	},
	constructor: function(palette){
		this.paletteId = palette.id;
		this.tabs = new dojox.collections.Dictionary();
		this.form = null;
		this.isValid = true;
	},
	destroy: function(){
		var e=this.tabs.getIterator();
		while(!e.atEnd()){
			var validationWidgets = e.get().value;
			var valEnum =validationWidgets.getIterator();
			while(!valEnum.atEnd()){
				var widget = valEnum.get().value;
				widget.destroyRecursive(false);
				widget = null;
			}
			validationWidgets.clear();
			validationWidgets = null;
			valEnum = null;
		}

		this.comboboxes = null;
		this.tabs.clear();
		if(this.form){
			this.form.destroyRecursive(false);
		}
		this.tabs = null;
		e = null;

	},
	addValidation: function(dijitWidget,tab){
		var tabNode;
		if(tab){
			tabNode = tab;
		}else{
			tabNode = this.findPaletteTab(dojo.byId(dijitWidget.id),'.palette_tab');
		}
		if(tabNode){
			var tabMgr = this.tabs.item(tabNode.id);
			tabMgr.add(dijitWidget.id,dijitWidget);
		}
	},

	removeValidation: function(){
		var validationWidget;
		var e = this.tabs.getIterator();
		while(!e.atEnd()){
			var validationWidgets = e.get().value;
			var valEnum = validationWidgets.getIterator();
			while(!valEnum.atEnd()){
				validationWidget = valEnum.get().value;
				validationWidget.state = "";
			}
		}
		if(validationWidget) {
			this.highlightTree(validationWidget);
		}
	},

	findPaletteTab: function(element,paletteTabQueryClass){
		var tab = dojo.query(element).closest(paletteTabQueryClass);
		if(tab && tab[0]){
			var tabElement = null;
			if(tab[0].id.indexOf("_palette")>0){
				tabElement = dojo.byId(tab[0].id.replace('_palette',''));
			}else{
				tabElement = tab[0];
			}
			return tabElement;
		}else{
			return null;
		}

	},
	isWidgetCreated: function(tab,element){
		var tabMgr = this.tabs.item(tab.id);

		if(tabMgr && tabMgr.item(element.id)){
			return true;
		}else{
			return false;
		}
	},
	registerValidations: function(item,paletteTabQueryClass){
		if(item.type == 'hidden' || item.readOnly == true ||
				!(dojo.hasClass(item, "numeric") ||
						dojo.hasClass(item, "alphanumeric") ||
						dojo.hasClass(item, "idCharacters") ||
						dojo.hasClass(item, "validateCheckBoxGroup") ||
						dojo.hasClass(item, "required") ||
						dojo.hasClass(item, "autocomplete") ||
						dojo.hasClass(item, "change_event") ||
						dojo.hasClass(item, "blur_event") ||
						dojo.hasClass(item, "inPlaceDisplay"))) {
			return;
		}

		var tabNode = this.findPaletteTab(item,paletteTabQueryClass);
		if(tabNode == null){
			return;
		}

		if(this.isWidgetCreated(tabNode,item)){
			return;
		}

		var widget = dijit.byId(item.id);
		if(widget){
			widget.destroy(true);
			var tabMgr = this.tabs.item(tabNode.id);
			tabMgr.remove(item.id);
		}

		var tabMgr = this.tabs.item(tabNode.id);
		if(!tabMgr){
			tabMgr = new dojox.collections.Dictionary();
			this.tabs.add(tabNode.id,tabMgr);
		}


		var validationObj = null;
		if(item.tagName == 'INPUT' ||item.tagName == 'TEXTAREA') {
			if(dojo.hasClass(item, 'inPlaceBehind')){
				return;
			}
			var validationFun = function(){return true;};
			var props = {};
			if(dojo.hasClass(item,'numeric')){
				validationFun = ap.Validation.Numeric.validator;
				props = ap.Validation.Numeric.getProps();
				props.required = dojo.hasClass(item,'required');
			}else if(dojo.hasClass(item,'alphanumeric')){
				validationFun = ap.Validation.AlphaNumeric.validator;
				props = ap.Validation.AlphaNumeric.getProps();
				props.required = dojo.hasClass(item,'required');
			}else if(dojo.hasClass(item,'idCharacters')){
				validationFun = ap.Validation.IdCharacters.validator;
				props = ap.Validation.IdCharacters.getProps();
				props.required = dojo.hasClass(item,'required');
			}else if(dojo.hasClass(item,'validateCheckBoxGroup')){
				validationFun = ap.Validation.CheckboxGroup.validator;
				props = ap.Validation.CheckboxGroup.getProps();
				props.checked = item.checked;
				props.value = item.value;
			}else if(dojo.hasClass(item,'required')){
				validationFun = ap.Validation.Required.validator;
				props = ap.Validation.Required.getProps();
				props.required = dojo.hasClass(item,'required');
			}
			props.displayedValue = item.value;
			props.style = "";

			if(dojo.hasClass(item, 'autocomplete')) {
				var store = new dojo.data.ItemFileReadStore({
			       	url: 'Toolkit?action=autoFieldValue&artifactId=' + ap.master.artifact + '&product=' + ap.master.product});

				props.id = item.id;
				props.store = store;
				props.searchAttr = 'name';
				props.highlightMatch = 'all';
				props.value = item.value;
				props.autoComplete = false;
				props.queryExpr = '*${0}*';
					props.dropDownPosition = ["above"];
				validationObj = new dijit.form.ComboBox(props, item.id);
			}else if(item.type == 'checkbox'){
				validationObj = new dijit.form.CheckBox(props, item.id);
			}else {
				validationObj = new dijit.form.ValidationTextBox(props,item.id);
				validationObj.attr('value',item.value);
			}
			//We have to set the name on the focus node separately and not pass it in as in the props.name
			//since there is a bug in dijit which is terminating the name attribute at the single quote.
			//e.g page[0].connectors[@type='process'].connector[0].@id is getting truncated as page[0].connectors[@type='
			if(validationObj.focusNode){
				validationObj.focusNode.name = item.name;
			}

			validationObj.attr('class', item.className);
			dojo.addClass(validationObj.focusNode, item.className);
			validationObj.validator = validationFun;
			validationObj.paletteTabQueryClass = paletteTabQueryClass;

			validationObj.onChange = dojo.hitch(this,function(validationObj,callOnChange){
					  					return function(newValue){
					  						if(validationObj.declaredClass == "dijit.form.CheckBox" && validationObj.validator){
					  							if(validationObj.validator.apply(validationObj,[newValue,null]) == true){
					  								validationObj.state = "";
					  							}else{
					  								validationObj.state = "Error";
					  							}
					  							this.highlightTree(validationObj);
					  							ap.master.onCheckboxClick(validationObj);
					  						}
					  						if(callOnChange == true){
					  							ap.master.dataEntryFieldChangeHandler(validationObj);
					  						}
					  						if(validationObj.declaredClass == "dijit.form.ComboBox") {
					  							if(validationObj.item) {
					  								validationObj.attr('value', validationObj.item.uniqueId[0]);
					  		            		}
					  						}
					  						ap.master.hasUnsavedChanges = true;
					  					};
					  				}(validationObj,dojo.hasClass(item,'change_event')));
		  	validationObj.onBlur = dojo.hitch(this,function(validationObj,callOnBlur){
						  				return function(){
						  					this.highlightTree(validationObj);
						  					if(callOnBlur == true){
						  						ap.master.dataEntryFieldBlurHandler(validationObj);
						  					}
						  				};
						  			}(validationObj,dojo.hasClass(item,'blur_event')));

			tabMgr.add(item.id,validationObj);

		}else if(item.tagName == 'SPAN' && dojo.hasClass(item,'inPlaceDisplay')){
			var tipNode = dojo.query('.inPlaceTip',item);
			var dijitWidget = dijit.byId(tipNode[0].id);
			if(dijitWidget && dijitWidget instanceof dijit.InlineEditBox){
				dijitWidget.destroy(true);
			}
					
			dijitWidget = this.addInplaceEditor(tipNode[0],"dijit.form.ValidationTextBox");
			var inputFieldId = dijitWidget.id.split('_')[0];
			var inputField = dojo.byId(inputFieldId);


			var validationFun = function(){return true;}
			var props = {};
			if(dojo.hasClass(inputField,'numeric')){
				validationFun = ap.Validation.Numeric.validator;
				props = ap.Validation.Numeric.getProps();
				props.required = dojo.hasClass(inputField,'required');
			}else if(dojo.hasClass(inputField,'alphanumeric')){
				validationFun = ap.Validation.AlphaNumeric.validator;
				props = ap.Validation.AlphaNumeric.getProps();
				props.required = dojo.hasClass(inputField,'required');
			}else if(dojo.hasClass(inputField,'idCharacters')){
				validationFun = ap.Validation.IdCharacters.validator;
				props = ap.Validation.IdCharacters.getProps();
				props.required = dojo.hasClass(inputField,'required');
			}else if(dojo.hasClass(inputField,'required')){
				validationFun = ap.Validation.Required.validator;
				props = ap.Validation.Required.getProps();
				props.required = dojo.hasClass(inputField,'required');
			}
			props.displayedValue = inputField.value;
			props.style = "";
			dijitWidget.editorParams = props;
			dojo.addClass(dijitWidget, inputField.className);
			dijitWidget.paletteTabQueryClass = paletteTabQueryClass;

			//This is a work around. For some reason the editWiget on a inline editor is created only when the editor is in display.
			//We are registering a validtion on it.
			//TOBE FIXED
			var onClickHandler = function(paletteManager,validationFun){
									return function(){
										this.wrapperWidget.editWidget.validator = validationFun;
										this.wrapperWidget.editWidget.paletteManager = paletteManager;
										this.wrapperWidget.editWidget.onChange = dojo.hitch(this, function(newValue) {
											if(!this.wrapperWidget.editWidget.isValid()) {
												this.onChange(this.wrapperWidget.editWidget.paletteManager,dojo.hasClass(inputField,'change_event'));
											}
										});
									};
								};

			dijitWidget.onclickHandler = onClickHandler(this,validationFun);
			dijitWidget.connect(dijitWidget, "edit", "onclickHandler");
			
			var changeHandler = function(paletteManager,callOnChange){
									return function(newValue){
										var inplaceSpanId = this.id;
										var inputFieldId = inplaceSpanId.split('_')[0];
										var inputField = dojo.byId(inputFieldId);
										if(inputField){
											inputField.value = this.attr('value');
										}
										if(this.wrapperWidget && this.wrapperWidget.editWidget){
											this.state = this.wrapperWidget.editWidget.state;
										}
										paletteManager.highlightTree(this);
										if(callOnChange){
											ap.master.dataEntryFieldChangeHandler(this);
										} else {
											ap.master.hasUnsavedChanges = true;
										}
									};
								};
			dijitWidget.onChange = changeHandler(this,dojo.hasClass(inputField,'change_event'));
			dijitWidget.onBlurHandler = function(paletteManager){
				return function(){
					if(this.wrapperWidget && this.wrapperWidget.editWidget){
						this.wrapperWidget.editWidget.validate();
						this.state = this.wrapperWidget.editWidget.state;
					}
					paletteManager.highlightTree(this);
				};
			}(this);
			dijitWidget.connect(dijitWidget,'onBlur',"onBlurHandler");
			
			//this.wrapperWidget.editWidget.connect(this.wrapperWidget.editWidget, 'onBlur', "function() { alert('blur');}");
			
			if(dijitWidget.value != null && dijitWidget.value.length == 0) {
				dijitWidget.value = null;
			}
			tabMgr.add(tipNode[0].id,dijitWidget);
		}

	},

	addInplaceEditor: function(item,dijitFieldType){
		var inplaceDijit = new dijit.InlineEditBox({
				            	editor: dijitFieldType,
				            	autoSave: true,
				            	noValueIndicator: "(Click here to enter a value)"
					        },
					        item.id);
		if(dijitFieldType == "dijit.form.Textarea"){
			dojo.style(inplaceDijit.domNode, "cols", "30");
			dojo.style(inplaceDijit.domNode, "rows", "3");
		}

		return 	inplaceDijit;
	},

	highlightTree: function(validationWidget){
		var itemId = validationWidget.id;
		var path = itemId;
		
		if(path.lastIndexOf('.')>0){
			path = path.slice(0,path.lastIndexOf('.'));
		}
	
		//Highlight the field label
		var div = dojo.byId(itemId+"_formRow");
		var isFieldValid = (validationWidget.state != 'Error');
		if(div){
			this.addRemoveClass(div,'invalid',!isFieldValid);
		}

		//Find the tab in this palette that needs to be highlighted
		var tabNode = this.findPaletteTab(validationWidget.domNode,validationWidget.paletteTabQueryClass);

		//Get the cummulative status of all the field on this tab
		var isTabValid = true;
		if(tabNode){
			isTabValid = this.validateTab(tabNode);
			this.addRemoveClass(tabNode,'invalid',!isTabValid);
		}

		/*Execute this logic atleast once.
		  Walk the tree in the editor why spliting the path on '.'
		  Find the palette manager for each iteration and use the cummulitive status to set the error class
		*/
		do{
			var isValid = isTabValid;

			//Node that needs to be highlighted on the editor.
			//Look for id that ends with _loadEntry or class palette_toggle
			var tobeHighlighted =  dijit.byId(path+'_loadEntry');

			if(tobeHighlighted && tobeHighlighted instanceof dijit.TitlePane){
				tobeHighlighted = tobeHighlighted.titleBarNode;
			}else{
				tobeHighlighted = dojo.byId(path+'_loadEntry');
				if(!tobeHighlighted){
					if( itemId.indexOf("@") === 0 && this.declaredClass == "PaletteManager") {
						path = this.paletteId.split('_')[0];
						tobeHighlighted = dojo.byId(path);
				
					} else {
						tobeHighlighted = dojo.byId(path);
						if(tobeHighlighted && !dojo.hasClass(tobeHighlighted,'palette_toggle')){
							tobeHighlighted = null;
						}
					}
				}

			}
			//This is a hard code for xarc rules editor where the path could be "rule[1].step.selectNodes.where[1].operator.operand[0]"
			//We don't want to hightlight both operand and operator since they are displayed as peers in the UI

			//If there is nothing to highlight, why check the validation status.
			if(tobeHighlighted != null && !ap.endsWith(tobeHighlighted.id, "operator")){
				//Palette Manager for this palette. Take the cummilative status of all the tabs in this palette.
				var paletteMgr = ap.master.paletteManagers.item(path+'_palette');
				if(paletteMgr){
					 var isPaletteValid = paletteMgr.validateForm();
					 isValid = isTabValid && isPaletteValid;

					 //In cases where you have nested accordions we need to consider the validation status of
					 //all the children when determining the final error status
					 //We are not performing the validation again, we are just checking the validation status
					 ap.master.paletteManagers.forEach(function(entry){
					 	if(entry.key.indexOf(path) >=0 ){
					 		var isChildValid = entry.value.validateForm();
					 		isValid = isValid && isChildValid;
					 	}
					 },this)
				}

				this.addRemoveClass(tobeHighlighted,'invalid',!isValid);
			}

			if(path.lastIndexOf('.')>0){
				path = path.slice(0,path.lastIndexOf('.'));
			}else{
				path = "";
			}
		}while(path.length >0);
	},

	addRemoveClass: function(node,className,shouldAddClass){
		if(shouldAddClass == true && !dojo.hasClass(node,className)){
			dojo.addClass(node,className);
		}else if(shouldAddClass == false && dojo.hasClass(node,className)){
			dojo.removeClass(node,className);
		}
	},

	validateTab: function(tab){
		var tabMgr = this.tabs.item(tab.id);
		var isValid = true;
		tabMgr.forEach(function(entry){
			if(entry.value.state== 'Error'){
				isValid = false;
			}
		},this);
		return isValid;
	},
	validateForm: function(){
		this.isValid = true;
		var tabsEnum = this.tabs.getIterator();
		while(!tabsEnum.atEnd()){
			var tab = tabsEnum.get().value;
			var valEnum =tab.getIterator();
			while(!valEnum.atEnd()){
				var widget = valEnum.get().value;
				//if(dojo.isFunction(widget.isValid) && widget.state == 'Error'){
				if(widget.state == 'Error'){
					this.isValid = false;
				}
			}
		}
		return this.isValid;
	}

});

	dojo.declare("Editor",null, {
		"-chains-": {
			dataEntryFieldChangeHandler: "after",
			dataEntryFieldBlurHandler: "after"
		},
		constructor: function(product, artifactId, artifactType){
			this.initialize(product, artifactId, artifactType);
		},
		initialize: function initialize(product, artifactId, artifactType){
			this.product = product;
			this.artifact = artifactId;
			this.hasAccordionSetup = false;
			this.dialog = null;
			this.events = new Array();
			this.lastEvent = new Array();
			this.paletteManagers = new dojox.collections.Dictionary();
			this.currentPaletteId = artifactId+"_palette";
			this.currentMenuId = artifactId+"_menu";
			//this.inplaceEditor = new InPlaceEditing();
			this.invalidSaveMessage = 'Cannot save item with invalid data.';
			this.hasUnsavedChanges = false;
			/**
			*	A reference to the pageBody.
			*/
			this.pageBody = dijit.byId('editorWrapper');
			/**
			* Holds the reference to _pageBodyClickEventDelegateHandler.
			* Main pupose is to unregiter/stopObserve the event.
			*/
			this._pageBodyClickEventDelegate = null;

			this.paletteClickEventDelegate = null;

			this.menuClickEventDelegate = null;

			/**
			 * the accordionWrapperClass is a class name that is used on elements
			 * that wrap the accordion toggle and content pairs.
			 */
			this.accordionWrapperClass = "accordion_container";
			/**
			 * the accordionToggleClass is the class used to indicate an element
			 * is an accordion toggle.
			 */
			this.accordionToggleClass = "accordion_toggle";

			/**
			 * main accordion for every editor.  first one loaded when visiting an editor
			 */
			this.accordion = null;

			/**
			 * accordion container for page elements.  Nested under the main accordion for
			 * tdf and page library.
			 */
			this.pageElementAccordion = null;

			/**
			 * accordion container for connector elements.  Nested under the main accordion for
			 * tdf and page library.
			 */
			this.connectorAccordion = null;
			this.comboboxes = new Array();

			this.loadEditor();
		},

		destroy: function(){
			//Destroy all the events
			dojo.disconnect(this._pageBodyClickEventDelegate);
			dojo.disconnect(this.paletteClickEventDelegate);
			dojo.disconnect(this.menuClickEventDelegate);

			this.destroyLastEvent();

			if(this.events) {
				var eventsCnt = this.events.length;
				for(var ix=0;ix<eventsCnt;++ix){
					var eventHandle = this.events.pop();
					dojo.disconnect(eventHandle);
					eventHandle = null;
				}
			}
			
			//destroy all accordions and null out references
			if(this.accordion) {
				this.accordion.destroy();
			}
			if(this.pageElementAccordion) {
				this.pageElementAccordion.destroy();
			}
			if(this.connectorAccordion) {
				this.connectorAccordion.destroy();
			}
			this.accordion = null;
			this.pageElementAccordion = null;
			this.connectorAccordion = null;

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

			ap.layoutManager.destroy(true);
			
			if(this.pageBody) {
				this.pageBody.destory();
				dojo.empty(this.pageBody);
			}
			
			var wizard = dojo.byId('wizard');
			if (wizard) {
				dojo.empty(wizard);
			}

			if(this.comboboxes) {
				for(var ix=0;ix<this.comboboxes.length;++ix){
					this.comboboxes[ix].destroy();
				}
			}

			this.comboboxes = null;
			this.events = null;
			this.pageBody = null;
			this._pageBodyClickEventDelegate = null;
			this.paletteClickEventDelegate = null;
			this.menuClickEventDelegate = null;
			this.paletteManagers = null;

		},

		loadEditor: function(){
			//function that would handle the successful response
			var successHandler = function(response){
				    this.pageBody.set('content', response);
				    if(ap.master.accordion) {
				    	ap.master.accordion.destroy();
				    	ap.master.accordion = null;
				    }
				    ap.master.accordion = new ToolkitAccordionPane('accordion_container', 'accordion');
				    var wizard = dojo.byId('wizard');
					this.createEvents(wizard);
					this.createEvents(dojo.byId('editor_header'));
					this.createEvents(dojo.byId(ap.master.artifact + '_palette'));
					
					ap.layoutManager.initializeEditorLayout();
					ap.layoutManager.buildMenuButtons(this, 'contextAction', true);
					// open the top level accordion on the movedToPath
					if(ap.movedToPath) {
						this.openEditorToPath(ap.movedToPath.split('.')[0]);
					}
			};

			//function that would handle the failure reponse
			this.failureHandler = function(){
				console.error(this);
				alert('Something went wrong...');
			};

			//Create the ToolkitRequest
			var request = new ToolkitRequest('loadEditor'+this.artifactType,
											 {'artifactType': this.artifactType, 'action': 'init'},
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
			if(startingElement) {
				if(startingElement.id == 'wizard'){
					//ap.dragManager.resizeHandler();

					var keyPressFunc = function(event){this.pageBodyKeyPressHandler(event,dojo.byId('editorWrapper'));};
					var keyPressHandler = dojo.connect(dojo.byId('editorWrapper'),'keypress',this,keyPressFunc);

					var clickHandler = function(event){this._pageBodyClickEventDelegateHandler(event,dojo.byId('editor_inner'));};
					this._pageBodyClickEventDelegate = dojo.connect(dojo.byId('editor_inner'),'click',this,clickHandler);

					var paletteClickHandler =  function(event){this._pageBodyClickEventDelegateHandler(event,dojo.byId('palette'));};
					this.paletteClickEventDelegate = dojo.connect(dojo.byId('palette'),'click',this,paletteClickHandler);

					var menuClickHandler =  function(event){this._pageBodyClickEventDelegateHandler(event,dojo.byId('contextAction'));};
					this.menuClickEventDelegate = dojo.connect(dojo.byId('contextAction'),'click',this,menuClickHandler);

				}else if(startingElement.id != null && startingElement.id.match('_palette')){
					this.registerDijitWidgets(startingElement,'.palette_tab'); //".palette_tab, .fieldSet, .header_span"
				}else if(startingElement.id != null && (startingElement.id.match('_loadEntry') || startingElement.id.match('toolkitDialogForm'))){
					this.registerDijitWidgets(startingElement,'.fieldSet');
				}else if(startingElement.id != null &&  startingElement.id.match('editor_header')){
					this.registerDijitWidgets(startingElement,'.header_span');
				}
			}
		},

		destroyLastEvent: function(){
			if(this.lastEvent) {
				var cnt = this.lastEvent.length;
				for(var ix=0;ix<cnt;ix++){
					var eventHandle = this.lastEvent.pop();
					dojo.disconnect(eventHandle);
				}
			}
		},

		/*
		*Update the display value in the editor when a field value is change in the palette
		*The id of the corresponding span in the editor should be id + '_displayText'
		*/
		updateTitle: function(itemId,text){
			var titleId = itemId + '_displayText';
			var titleNode = dojo.byId(titleId.replace('_inPlaceTip',''));
			if(titleNode){
				if(text.length == 0){
					text = "(Select Value)";
				}
				// if this is a required field, we need to update the text
				// because we don't want to display true/false inside the editor
				if(itemId.indexOf('.@required') !== -1) {
					if(text === 'false') {
						text = '';
					} else if(text === 'true') {
						text = '*';
					}
				}
				titleNode.innerHTML = text.replace("<", "&lt;");
			}
		},
		dataEntryFieldChangeHandler: function(item){
			if(!this.hasUnsavedChanges &&  !dojo.hasClass(item,'dirtyTrackerEvent') ) {
	  			this.hasUnsavedChanges = true;
  			}
  			if(dojo.hasClass(item,'accordion_update') || (item.focusNode && dojo.hasClass(item.focusNode,'accordion_update'))){
  				// split on '.@' to get at the root of the path
				var accordionId = item.id.split('.@')[0];
				var accordionDijit = dijit.byId(accordionId+'_loadEntry') || dijit.byId(accordionId + '_none');
				if(accordionDijit){

					var titleValue = item.value;

					//Account for the case where a Page Name is selected from a select list
					//on the Transactions palette.  In this case we want the display value from the
					//select list as opposed to the value.
					if (item.type == 'select-one') {
						var selectedIndex = item.options.selectedIndex;
						titleValue = item.options[selectedIndex].text;
						//Update the @title field if it exists.  Will be hidden for Transactions
						var titleField = dojo.byId(accordionId +'.@title');
						if (titleField) {
							titleField.value = titleValue;
						}

					}
					accordionDijit.attr('title',titleValue);
				}

				//Update a field label
				var text = item.value;
				if(item.tagName && item.tagName.toLowerCase() === 'select'){
					text = item.options[item.selectedIndex].text;
				}
				this.updateTitle(item.id,text);
			}

		},
		dataEntryFieldBlurHandler: function(item){

		},

		openEditorToPath: function(path) {

		},

		/**
		 * Hook point to handle checkbox click
		 * @param item
		 */
		onCheckboxClick: function(item) {

		},

		registerDijitWidgets: function(startingElement, paletteTabQueryClass){
			var paletteManager = null;
			if(this.paletteManagers.item(startingElement.id)){
				paletteManager = this.paletteManagers.item(startingElement.id);
			}else{
				paletteManager = new PaletteManager(startingElement);
				this.paletteManagers.add(startingElement.id,paletteManager);
			}
			var temp = dojo.query("input[type='text'],input[type='checkbox'], TEXTAREA, SPAN.inPlaceDisplay",startingElement);
			var regValFun = function(tabClassName){
								return function(item,index,array){
									paletteManager.registerValidations(item,tabClassName);
								}
							};
			dojo.forEach(temp,regValFun(paletteTabQueryClass),paletteManager);
		},

		/**
		 * Deletes an artifact based on the id of the artifact provided
		 * @param artifactId is the artifact id of the artifact we are deleting
		 */
		deleteArtifact: function(artifactId){

	 		this.successHandler = function(artifactId){
				return function(){

				 	//ap.master.destroy();
					var navMenu = ap.toolkitNavMenu;

					//delete the item from the menu
					var menuItem = navMenu.store._itemsByIdentity[artifactId];
					var parentId = null;
					if(menuItem) {
						parentId = menuItem.parentId[0];
						navMenu.store.deleteItem(menuItem);
					}
					//Set the covers page based on the type of artifact that has been deleted.
					if(parentId) {
						ap.toolkitNavMenu.setMenuFocus(parentId);
					}
				 };
			};

			//Create the ToolkitRequest
			var request = new ToolkitRequest('deleteArtifact'+artifactId,
											 {'action': 'delete',
											  'type' : 'deleteArtifact',
											  'productId' : this.product,
											  'artifactId' : artifactId},
											 this,
											this.successHandler(artifactId),
											 this.ajaxFailureHandler);

			//Register the request with ajax manager
			ap.AjaxManager.processRequest(request);
		},

		pageBodyKeyPressHandler: function(event,container){
			var item = event.target;
			if(this.hasUnsavedChanges == false){
				if(item.tagName == 'INPUT' || item.tagName == 'SELECT' || 
						(item.tagName == 'TEXTAREA' && item.id != 'properties_content' )){
					this.hasUnsavedChanges = true;
				}
			}
		},
		_pageBodyClickEventDelegateHandler : function(event,container) {

		    var item = event.target;

			if(!item) return;

			// if a checkbox was clicked, we let the browser handle the toggle of the checkmark
			// and then call into onCheckboxClick() to handle setting of hidden fields.
			if(item.type == 'checkbox') {
				return;
			}

			dojo.stopEvent(event);

			this.destroyLastEvent();

			//destroy the last button that was clicked if it exists.
			//this will close dropdown menus and disconnect all events
			if(ap.master.lastButton) {
				//ap.master.lastButton.destroy();
				ap.master.lastButton.hideOptions();
			}

			if(this.dialog) {
				this.dialog.destroy();
				this.dialog = null;
			}

			while (item.id != null && item.id != container.id) {
				if(item.tagName == 'SELECT' ) {
				  		if(dojo.hasClass(item,'change_event')){
				  			var changeEventHandle = dojo.connect(item,'change',this,function(item){
				  				return function(){
				  					this.dataEntryFieldChangeHandler(item);
				  				};
				  			}(item));
				  			this.lastEvent.push(changeEventHandle);
				  		}else{
				  			var changeHandler = dojo.connect(item,'change',this,function(){
				  				this.hasUnsavedChanges = true;
				  			});
				  		}
				  		if(dojo.hasClass(item,'blur_event')){
				  			var blurEventHandle = dojo.connect(item,'blur',this,function(item){
				  				return function(){
				  					this.dataEntryFieldBlurHandler(item);
				  				};
				  			}(item));
				  			this.lastEvent.push(blurEventHandle);
				  		}
				  		var itemRowPath = item.id.split('\.@')[0];
				  		var row;
				  		if(itemRowPath) {
				  			var row = dojo.byId(itemRowPath + '_wrapperDiv');
				  			if(row) {
				  				if(dojo.isFunction(this.onClickEvent)) {
									this.onClickEvent(row, event);
				  				}
				  			}
				  		}
				  		if(dojo.hasClass(item,'select_list_event')){
							if(dojo.isFunction(this.onClickEvent)) {
								this.onClickEvent(item, event);
							}

							// item.id is an optionList container
							if( dojo.byId(item.id).length != 0 ) {
								// if length is not zero, list has been loaded
								// this is the 'click' which closed the list
								// propagate event up to parent
								item = item.parentNode;
								continue;
							} else {
								// if length is zero, list has not yet been loaded
								// so do not propagate the click event up to parent
								// because the parent will steal focus from the list
								return false;
							}
				  		}
				  		return false;
				 } else if(dojo.hasClass(item,'addNew')) {
						 	this.hasUnsavedChanges = true;
						 	var itemId = item.id;
						 	var path = itemId.split('_')[0];
						 	var action = itemId.split('_')[1];
						 	this.addNew(path,action);
					  		return false;
				 } else if(dojo.hasClass(item,'deleteAction')) {

						var itemId = item.id;
						var deleteId = itemId.split("_delete")[0];

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

  						dojo.style(this.currentMenuId,"display","none");
						dojo.style(this.artifact + '_menu','display','inline');

						return false;

				 	} else  if(dojo.hasClass(item,'deleteArtifact')) {

						var itemId = item.id;
						var deleteId = itemId.replace("_delete", "");

						if (!confirmDelete(deleteId))
							return;

						var deleteElement = dojo.byId(deleteId);

						if(deleteElement) {
							this.deleteArtifact(deleteId);
						}

						return false;

				 } else if (dojo.hasClass(item, 'tdf_crossReference')) {

				  	var artifactId = dojo.query('input.artifactId',item);
					var path = item.id.split('_')[0];

					ap.movedToPath = path;
					ap.toolkitNavMenu.setMenuFocus(artifactId[0].value);
					return false;

				 } else if (dojo.hasClass(item, 'behaviors_crossReference')) {

				  	var artifactId = dojo.query('input.artifactId',item);
					var path = item.id.split('_')[0];

					ap.movedToPath = path;
					ap.toolkitNavMenu.setMenuFocus(artifactId[0].value);

					return false;
				}else if(dojo.hasClass(item, 'palette_toggle')) {
					toolkitPleaseWait(true);
					this.focusMenu(event,item.id);
					this.focusPalette(event,item.id);
					return false;
		  		} else if(dojo.hasClass(item,'tab')) {
					focusTab.call(this, item.id + '_palette', item.id);
					if(dojo.isFunction(this.onFocusTabEvent)) {
						this.onFocusTabEvent(item, event);
					}
					return false;
				} else if(dojo.hasClass(item,'save')){
					ap.master.save();
					return false;
				} else if(dojo.hasClass(item,'export')){
					var iframe = dojo.create('iframe', {src: "Toolkit?action=export&type=exportArtifact&productId=" + this.product + "&artifactId=" + this.artifact});
			  		iframe.style.display = 'none';
			  		document.body.appendChild(iframe);
			  		return false;
				} else if(dojo.hasClass(item,'import')){
					var iframe = dojo.create('iframe', {src: "Toolkit?action=import&type=importArtifact&type&productId=" + this.product + "&artifactId=" + this.artifact});
			  		iframe.style.display = 'none';
			  		document.body.appendChild(iframe);
			  		return false;
				} else if(dojo.hasClass(item, 'editAction')) {
					this.dialog = new ToolkitDialogBox('toolkitDialogForm', 'property', 'Error committing data, please verify data is correct.', "Toolkit?action=" + item.id.split('_')[1] + "&product=" + this.product + "&artifactId=" + this.artifact + "&path=" + item.id.split("_")[0])
					return false;
				} else if(dojo.hasClass(item, 'search')) {
					this.dialog = new ToolkitDialogBox('toolkitDialogForm', 'search', 'Error searching for data, please verify data is correct.', "Toolkit?action=loadSearch&product=" + this.product + "&artifactId=" + this.artifact)
					return false;
				} else if(dojo.hasClass(item, 'action')) {
					//var button = new dijit.form.DropDownButton();
					//ap.master.lastButton = button;
					if(dojo.isFunction(this.onClickEvent)) {
						return this.onClickEvent(item, event);
					}
			  		return false;
				}else if(dojo.hasClass(item, 'dropShadow')){
					return false;
				}else{
					if(dojo.isFunction(this.onClickEvent)) {
						this.onClickEvent(item, event);
					}
					item = item.parentNode;
				}
	    	}

		},

		/**
		 * Deletes a row from the palette
		 * @param item is the button item that was clicked that contains the id of the field to delete
		 * @param skipConfirm is used to skip the delete confirmation.  Used when closing an unsaved dialog.
		 */
		deleteRow: function(item, skipConfirm) {

			 var itemId = item.id;

			  var deleteId = itemId.replace("_delete", "");
			  var deleteIndicatorField = deleteId + '.@delete';
			  var deleteRow = deleteId + "_wrapperDiv";
			  var deleteElement = dojo.byId(deleteRow);

			  if (!skipConfirm && !confirmDelete(deleteId))
			  	return;

			  this.hasUnsavedChanges = true;

			  if(deleteElement) {
				  dojo.style(deleteElement,"display","none");
				  dojo.byId(deleteIndicatorField).value = 'true';
			  }

			  return false;
		},

		/**
		 * Deletes a row from the editor
		 * @param item is the button item that was clicked that contains the id of the field to delete
		 * @param skipConfirm is used to skip the delete confirmation.  Used when closing an unsaved dialog.
		 */
		deleteEditorRow: function(item, skipConfirm) {

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

		isUsedBy: function(deleteId){
			var refDiv = deleteId + "_Used By_content";
			var refNode = dojo.byId(refDiv);
			if(refNode){
				var refElements = dojo.query("table>tbody>tr:first-child",refNode);
				if(refElements != null && refElements.length > 0){
					return true;
				}
			}

			return false;
		},
		/*
		* This function is called for all the add actions. Its sub class responsibility to do
		* different stuff for each of the add types
		*/
		addNew: function(path,action){
			if(dojo.isFunction(this[action])){
				this[action].apply(this,[path,action]);
			}
		},
		saveAndDestroyPalette: function(paletteId,path,type){
			var paletteId = this.currentPaletteId;
			if(paletteId == null || paletteId == ""){
				this.loadPaletteInternal(path,type);
				return;
			}
			var paletteManager = this.paletteManagers.item(paletteId);
			if(!paletteManager || paletteManager.isValid == false){
				//This palette has encountered a server side error. 
				if(paletteManager && paletteManager.errorNode != null){
					this.dialog = new ToolkitDialogBox('toolkitDialogForm', null, "",null,null,null,paletteManager.errorNode);
                	var loadId = paletteId.split('_')[0];
                	var pane = dojo.byId(loadId+"_loadEntry");
                	if(pane){
                		this.accordion.openPane(pane);
                	}
                	this.loadPaletteInternal(loadId);
					this.loadMenu(loadId);					
					return;
				}
				this.loadPaletteInternal(path,type);
				return;
			}

			var palette = dojo.byId(paletteId);
			if(palette){
				var paletteForm = dijit.byId(paletteId);
				if(!paletteForm){
					paletteForm  = new dijit.form.Form({},paletteId);
					paletteForm.attr('class', palette.className);
				}
				paletteManager.form = paletteForm;
				var successHandler = function(paletteId,path, type){
										return function(response,ioargs){
											try{
												var status = true;
												if(ioargs.xhr){
													status = ioargs.xhr.getResponseHeader('requestProcessed');
												}

												if(status === "true"){
													var paletteManager = ap.master.paletteManagers.item(paletteId);
													if(paletteManager){
														paletteManager.destroy();
														ap.master.paletteManagers.remove(paletteId);
														paletteManager.form.destroyRecursive(true);
														paletteManager.form=null;
													}
									                this.loadPaletteInternal(path,type);
								                }else{
													var paletteManager = ap.master.paletteManagers.item(paletteId);
													paletteManager.isValid = false;
													paletteManager.errorNode = dojo.trim(response);
								                	this.dialog = new ToolkitDialogBox('toolkitDialogForm', null, '',null,null,null,paletteManager.errorNode);
								                	var loadId = paletteId.split('_')[0];
								                	var pane = dojo.byId(loadId+"_loadEntry");
								                	if(pane){
								                		this.accordion.openPane(pane);
								                	}
								                	this.loadPaletteInternal(loadId);
													this.loadMenu(loadId);
								                }
											}catch(e){
												console.error(e);
											}
		    							}
									};
				//Create the ToolkitRequest
				var request = new ToolkitRequest('saveAndDestroyPalette',
												 {'artifactType': this.artifactType, 'action': 'savePalette'},
												 this,
												 successHandler(paletteId,path, type),
												 this.ajaxFailureHandler);
				request.form = paletteManager.form.domNode;
				//Register the request with ajax manager
				ap.AjaxManager.processRequest(request);
			}
		},
		/**
		 * Load the page data from the server, the pages are loaded only when clicked
		 * @param pageElement Element of the page to insert the html from server
		 * @param pageIndex Index of current page used to retrieve the correct page elements
		 */
		loadPalette: function (path, type) {
			this.saveAndDestroyPalette(this.currentPaletteId,path,type);
		},

		loadPaletteInternal: function(path, type){
			var paletteElement = path + '_palette';
			if(!dojo.byId(paletteElement)) {
				var successHandler = function(paletteElement){
										return function(response){
										    dojo.place(dojo.trim(response),'palette');
										    ap.layoutManager.buildMenuButtons(ap.master, path + '_palette');
										    this.focusPalette(null, path, path);
										    this.createEvents(dojo.byId(paletteElement));
										    this.currentPaletteId = paletteElement;
										    toolkitPleaseWait(false);
									    };
								    };

				//Create the ToolkitRequest
				var request = new ToolkitRequest('loadPalette',
												 {'path': path, 'type': type, 'action': 'loadPalette'},
												 this,
												 successHandler(paletteElement),
												this.ajaxFailureHandler);
				//Register the request with ajax manager
				ap.AjaxManager.processRequest(request);
			} else {
				this.focusPalette(null, path, path);
			}
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
											dojo.place(dojo.trim(response),'contextAction');
											ap.layoutManager.buildMenuButtons(this, menuElement, true);
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
				this.currentMenuId = menuElement;
			}
		},
		/*
		*find the node that needs to be shown/hidden for this option
		*This is hook point for other editors to override
		*/
		findEntityToDisplay: function(path,option){
			var divToShowHide = dojo.byId(path + '.'+option.value+'_formRow');
			return divToShowHide;
		},

		/**
		*Show/hide nodes based on option selected in a select list.
		*This function does the following
		*1)Show the nodes that are related to the option selected
		*2)Hide the nodes that are related to the options that are not selected
		*3)Reset the validation status for the nodes that are hidden in step 2 above.
		*4)Reset the highlighting on the editor and palette.
		*/
		showOptions: function(item){

			var path = item.id;
			if(path.indexOf('.@')>0){
				path = path.slice(0,path.lastIndexOf('.@'));
			}

			var options = item.options;
			dojo.forEach(options,function(){
				return function(option){
				var optionValue = option.value;
				if(optionValue)
					var divToShowHide = this.findEntityToDisplay(path,option);
				if(divToShowHide){
					if(option.selected){
						dojo.style(divToShowHide,'display','block');
					}else{
						dojo.style(divToShowHide,'display','none');
						var validationObj = null;
						dojo.query('.resetValue',divToShowHide).forEach(function(node){
							if (node.tagName.toLowerCase() === 'select') {
								node.selectedIndex = 0;
							}else{
								var dijitWidget = dijit.byId(node.id);
								if(dijitWidget){
									validationObj = dijitWidget;
									dijitWidget.attr('value',"");
									dijitWidget.state = 'Normal';
								}else{
									node.value = "";
								}
							}
						});
						//We just need one field from this tab to trigger the set effort flags
						if(validationObj){
							var paletteDiv = dojo.query(validationObj.domNode).closest(".palette");
							dojo.forEach(paletteDiv,function(paletteNode){
								var paletteManager = ap.master.paletteManagers.item(paletteNode.id);
								if(paletteManager){
									paletteManager.highlightTree(validationObj);
								}
							},this);
						}
					}
				}
				};
			}(path),this);
	    },

		/**
		* Save Artifacts title and description.
		* @param options.
		*/
		saveTitleData: function (options) {


			var successHandler = function(options){
									return function(response){
									 	//if(options.title)
	    									//dojo.byId(this.product+'_'+this.artifact).innerHTML = options.title;
	    								}
								};

			//Create the ToolkitRequest
			var request = new ToolkitRequest('saveTitleData',
											 {'artifactType': this.artifactType, 'action': 'saveArtifactTitle'},
											 this,
											 successHandler(options),
											 this.ajaxFailureHandler);
			request.form = dojo.byId('editorForm');
			//Register the request with ajax manager
			ap.AjaxManager.processRequest(request);

		},

		focusPalette: function (event, clickedId, path) {

			//stop the event from bubbling up to the previous element
			if(event) {
				dojo.stopEvent(event);
			}

			//if (!event) var e = window.event;
			var clickedElement = dojo.byId(clickedId);
			var clickedElementType = dojo.byId(clickedId + '_type');
			//add palette to the name since each palette should have the same id plus _ palette
			var paletteToShow = dojo.byId(clickedId + '_palette');
			if(clickedElementType && !paletteToShow) {
				var clickedElementValue = clickedElementType.value;
				dojo.removeClass(clickedElement,'needs_palette');
				ap.master.loadPalette(path || clickedId, clickedElementValue);
			} else {

				//the object returned by parentNode is different in IE versus Mozilla
				//so we get the field object using id again so this works in IE

				var subpalettes = dojo.query('.palette','palette');

				for (var i=0; i < subpalettes.length; i++){
					dojo.style(subpalettes[i],'display','none');
				}

				if(paletteToShow) {
					dojo.style(paletteToShow,'display','block');
				} else {
					//show default palette if none is shown
					var basePalette = dojo.byId(this.artifact + "_palette");
					if(basePalette){
						dojo.style(basePalette, 'display', 'block');
					}
				}
				toolkitPleaseWait(false);
			}
		},

		focusMenu: function (event, clickedId, path) {

			//stop the event from bubbling up to the previous element
			if(event) {
				dojo.stopEvent(event);
			}

			var clickedElement = dojo.byId(clickedId);
			var clickedElementType = dojo.byId(clickedId + '_type');
			//add menu to the name since each menu should have the same id plus _menu
			var menuToShow = dojo.byId((path || clickedId) + '_menu');
			if(clickedElementType && !menuToShow) {
				var clickedElementValue = clickedElementType.value;
				this.loadMenu(path || clickedId, clickedElementValue);
			} else {
				//ap.layoutManager.buildMenuButtons(ap.master, menuToShow);
				var title = dojo.query('div.transaction_container','editor');

				dojo.forEach(dojo.query('.focused_page_entity','editor'),function (elt) {
					dojo.removeClass(elt,'focused_page_entity');
				});
				if(clickedElement) {
					dojo.addClass(clickedElement,'focused_page_entity');
				}

				//the object returned by parentNode is different in IE versus Mozilla
				//so we get the field object using id again so this works in IE
				if(menuToShow) {
					var subMenus = dojo.forEach(dojo.query('.menu','contextAction'),function (menu) {
						if (menu.id !== menuToShow.id) {
							dojo.style(menu,'display','none');
						}
					});

					if (menuToShow) {
						dojo.style(menuToShow,'display','inline');
					}
				}
			}
		},
		/**
		 * Saves the artifact to the server by posting the page body.
		 * @return
		 */
		save: function save() {

			var e=this.paletteManagers.getIterator();
			var isValid = true;
			var errorMessage = "Error with palette: ";
			var errorNode = null;
			while(!e.atEnd()){
				var paletteMgr = e.get().value;
				if(paletteMgr.isValid == false){
					errorNode = paletteMgr.errorNode;
					if(paletteMgr.errorNode == null){
						var accordionId = paletteMgr.paletteId.split('.@')[0];
						accordionId = accordionId.split('_palette')[0];
						var accordionDijit = dijit.byId(accordionId+'_loadEntry');
						var title = paletteMgr.paletteId;
						if(accordionDijit){
							title = accordionDijit.attr('title');
						}
						errorMessage = errorMessage + title;
					}
					isValid  = false;
				}
			}

			if(!isValid){
				this.dialog = new ToolkitDialogBox('toolkitDialogForm', null, errorMessage,null,null,null,errorNode);
				return;
			}

			var successHandler = function(transport,ioargs){
				var status = true;
				if(ioargs.xhr){
					status = ioargs.xhr.getResponseHeader('requestProcessed');
				}
				try { 
					if(status === "true"){
						dojo.style(dojo.byId('saving'),'display','block');
						dojo.style(dojo.byId('saving'),'opacity','1');
		                dojo.fadeOut({duration: 3000, node : dojo.byId('saving')}).play();
		                this.hasUnsavedChanges = false;
	                } else {
	                	this.dialog = new ToolkitDialogBox('toolkitDialogForm', null, '',null,null,null,dojo.trim(transport));
	                }
				} catch(e) {
					console.error(e);
				}
			 };


			//Create the ToolkitRequest
			var request = new ToolkitRequest('save'+this.artifactType,
											 {},
											 this,
											 successHandler,
											this.ajaxFailureHandler);
			request.url = request.url + '&action='+'saveArtifact';
			
			request.form = dojo.byId('editorForm');
			//Register the request with ajax manager
			ap.AjaxManager.processRequest(request);
						
		},
		ajaxFailureHandler: function(){
			alert("Something went wrong");
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
		}
		/*
		,showCalendar: function(fieldId){
			//dojo.require("dijit.dijit"); // loads the optimized dijit layer
		    //dojo.require("dijit.Calendar");
			var cal = new dijit.Calendar({},
			        dojo.byId(fieldId+"_fieldHelperCalendarDiv"));
			        dojo.connect(cal, "onValueSelected", function(date) {
			            dojo.byId(fieldId).value = date;
			        });
		}*/
	});

	/*
	* toolkit accordion pane creates accordion panes for each editor
	*/
	dojo.declare("ToolkitAccordionPane", null, {
		/*
		*Initialize the request.
		*@param root is the parent DOM node that contains accordions.
		*@param accordionClass is the class attribute on the accordion DOM nodes. Class is
		*	used to search for all accordion nodes under the root.
		*/
		constructor: function(root, accordionClass) {
			this.root = root;
			this.accordionClass = accordionClass;
			this.previousOpen;
			this.accordionList = new Array();
			if(dojo.byId(root)) {
				this.initialize();
			}
		},

		/*
		 * Destroys the accordion and all the children
		 */
		destroy: function() {
			dojo.forEach(this.accordionList, function(item, index) {
					if(item) {
						item.destroyRecursive();
					}
			});
			this.accordionList = null;
		},

		/**
		 * initializes the accordion by searching and creating accordion elements based
		 * on root node and class.
		 * @param root is the root node to search for accordions to create
		 * @param accordionClass is the accordion class we are searching for
		 */
		initialize: function() {

			var queryString = ' > .' + this.accordionClass;
			dojo.query(queryString, dojo.byId(this.root)).forEach(
						dojo.hitch(
								this, function (item, index) {
									try {
											this.addAccordion(item, index);
									}
										catch (exception) {
											alert(exception);
										}
										}
								  )
			);
		},
		/*
		 * Add new accordion to the list of accordions
		 */
		addAccordion : function(item, place) {
			var path = item.id.split('_')[0];
			var action = item.id.split('_')[1];
			var titlePane = new dijit.TitlePane( {
				title : item.title,
				open : false,
				preventCache : true,
				preload: false,
				href: 'ToolkitFrontServlet?product=' + ap.master.product + '&artifactId=' + ap.master.artifact + '&action=' + item.id.split('_')[1] + '&path='	+ item.id.split('_')[0],
				onClick : dojo.hitch(this, function(event) {
					var target = event.currentTarget;
					var originalTarget = event.target;
					var targetPane = dijit.byId(target.id);
					if(targetPane && !targetPane.isLoaded && targetPane.href != '') {
						targetPane.refresh();
					}
					var originalDijit = dijit.byId(originalTarget);
					dojo.stopEvent(event);
					//if the target id was not dijit.TitlePane then call method to
					//handle event otherwise process titlepane.
					if(!originalDijit || (!(originalDijit instanceof dijit.TitlePane) &&
							!dojo.hasClass(originalDijit, 'dijitTitlePaneTitle') &&
							!dojo.hasClass(originalDijit, 'dijitTitlePaneTextNode') &&
							!dojo.hasClass(originalDijit, 'dijitTitlePaneTitleFocus'))) {
						ap.master._pageBodyClickEventDelegateHandler(event, target);
					} else {
						if(this === ap.master.pageElementAccordion) {
							if(ap.master.connectorAccordion) {
								ap.master.connectorAccordion.closeAll();
							}
						} else if(this == ap.master.connectorAccordion) {
							if(ap.master.pageElementAccordion) {
								ap.master.pageElementAccordion.closeAll();
							}
						}

						//remove focused class.  This is only used when we are focused on titlepane bu
						//the titlepane is closed.
						if(this.previousOpen && dojo.hasClass(this.previousOpen.titleBarNode, 'focused')) {
							dojo.removeClass(this.previousOpen.titleBarNode, 'focused');
						}
						toolkitPleaseWait(true);
						//let's close all other open accordions
						if (this.previousOpen) {
							if (this.previousOpen.open
									&& target.id != this.previousOpen.id) {
								this.previousOpen.toggle();
								this.previousOpen = targetPane;
							} else {
								if(target.id === this.previousOpen.id) {
									dojo.addClass(targetPane.titleBarNode, 'focused');
								}
								this.previousOpen = targetPane;
							}
							//let's make sure that the proper menu is loaded
							ap.master.loadMenu(targetPane.id.split('_')[0],targetPane.id.split('_')[1]);
							ap.master.loadPalette(targetPane.id.split('_')[0]);
						} else {
							ap.master.loadMenu(targetPane.id.split('_')[0],targetPane.id.split('_')[1]);
							ap.master.loadPalette(targetPane.id.split('_')[0]);
							this.previousOpen = targetPane;
						}
					}
				}),
				onDownloadEnd: dojo.hitch(this, function(path) {
					return function(){
						console.info('In download end for accordion.');
						ap.layoutManager.buildMenuButtons(ap.master, path + "_loadEntry");
						//setup nested accordion for TDF / Page Library
						var pageElementContent = dojo.byId(path + "_" + 'Sections_content');
						if(pageElementContent) {
							ap.master.pageElementAccordion = new ToolkitAccordionPane(pageElementContent.id, 'accordion');
						}
						var connectorContent = dojo.byId(path + "_" + 'Connectors_content');
						if(connectorContent) {
							ap.master.connectorAccordion = new ToolkitAccordionPane(connectorContent.id, 'accordion');
						}
						this.previousOpen.focusNode.scrollIntoView();
						ap.master.createEvents(dojo.byId(path+"_loadEntry"));

						if(ap.movedToPath) {
							var pageElementPath = ap.movedToPath.split('.')[0] + '.' + ap.movedToPath.split('.')[1];
							var fieldElementContainer = dojo.byId(pageElementPath + '.fieldElement_container');

							if(fieldElementContainer) {
								// if we find a fieldElement container, than we've already opened the pageElement accordion
								// so we need to focus on the specific fieldElement
								ap.master.openEditorToPath(ap.movedToPath);
							} else {
								// if we don't find a fieldElement container, then we have yet to open the
								// pageElement level accordion
								ap.master.openEditorToPath(pageElementPath);
							}
						}
						console.info('Exiting download end for accordion.');
						toolkitPleaseWait(false);
					}
				}(path))

			}, item.id);
			titlePane.attr('class', 'accordion');
			if(action === 'none') {
				titlePane.attr('href', '');
			}
			dojo.place(titlePane.domNode, dojo.byId(this.root), place);
			this.accordionList.push(titlePane);
		},

		openPane: function(node) {
			if(this.previousOpen && this.previousOpen.open && node.id != this.previousOpen.id) {
				
				if (dijit.byId(this.previousOpen.id)) {
					this.previousOpen.toggle();
				}
			}
			
			if( this.previousOpen && dijit.byId(this.previousOpen.id) && dojo.hasClass(this.previousOpen.titleBarNode, 'focused')) {
				dojo.removeClass(this.previousOpen.titleBarNode, 'focused');
			}
			var pane = dijit.byId(node.id);
			if(!pane.open) {
				if(!pane.isLoaded && pane.href != '') {
					pane.refresh();
				}
				pane.toggle();
			}
			this.previousOpen = pane;
		},

		closeAll: function() {
			if(this.previousOpen && this.previousOpen.open) {
				this.previousOpen.toggle();
				if(dojo.hasClass(this.previousOpen.titleBarNode, 'focused')) {
					dojo.removeClass(this.previousOpen.titleBarNode, 'focused');
				}
			}
			this.previousOpen = null;
		},

		/**
		 * Deletes the accordion based on the id given
		 * @param id the id of the accordion that should be deleted
		 */
		deleteAccordion: function(id) {
			// accordions within the TDF have a suffix of _none because they should not be 'opened'
			// all the rest of the accordions have the suffix of _loadEntry.  account for both.
			var accordion = dijit.byId(id + '_loadEntry') || dijit.byId(id + '_none');
			//this should always be the case
			if(accordion === this.previousOpen) {
				this.previousOpen = null;
			}
			if(accordion) {
				accordion.destroyRecursive();
			}
		}

	});

/**
 * Focus on a specific field.  Since we need to use a timeout for
 * focusing on a field we put the method here were we can easily get at it.
 * @param fieldId is the field we want to focus on.
 */
ap.focusField = function(newField) {
		var field = dojo.byId(newField + ".@value");
		if(field)
			field.focus();
};

/**
 * Store a reference to the moved to path
 */
ap.movedToPath = null;
