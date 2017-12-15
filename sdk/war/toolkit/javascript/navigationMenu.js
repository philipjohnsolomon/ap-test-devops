/**
 * @fileoverview This ConnectorWizard is used to add/edit Connector file artifacts.
 * @author Rob Warner
 * @version 0.1
 */
/**
 * @constructor
 * @class The Navigation Menu class sets up the left navigation menu for the toolkit.
 * @return A new navigation menu instance
*/
dojo.declare("NavigationMenu", null, {
	constructor: function(focusId) {
		this.lastMenuItem = null;
		this.lastMenuNode = null;
		this.cancelFocus = false;
		this.focusId = focusId;
	},

	/**
	 * destroys the navigation menu
	 */
	destroy: function() {
		if(this.store) {
			this.store = null;
		}
		if(this.treeModel) {
			this.treeModel.destroy();
			this.treeModel = null;
		}
		if(this.tree) {
			this.tree.destroyRecursive(false);
			this.tree = null;
		}
		this.destroyCurrentEditor();
		//dijit.byId('navMenu').destroyRecursive(false);

	},
	/**
	 * prepare and load the menu
	 */
	prepare: function() {
		this.store = new dojo.data.ItemFileWriteStore( {
			url : 'Toolkit?action=menu',
			clearOnClose : true,
			urlPreventCache : true
		});

		this.treeModel = new dijit.tree.TreeStoreModel( {
			store : this.store,
			childrenAttrs : [ 'children' ]
		});

		this.tree = new dijit.Tree( {
			model : this.treeModel,
			openOnClick : false,
			persist : false,
			onClick : dojo.hitch(this, function(item, node, event) {
				if(!this.confirmUnsavedChanges()) {
					return;
				} else {
					if(ap.master) {
						ap.master.hasUnsavedChanges = false;
					}
				}
				dijit.focus(node.labelNode);
				this.lastMenuNode = node;
				this.tree.toggleNode(item,node);
				dojo.stopEvent(event);
			}),
			/*
			 * Toggles nodes open and closed
			 */
			toggleNode: dojo.hitch(this, function(item, node) {
				if(node.isExpandable) {
					if(node.isExpanded) {
						this.tree.closeNode(item, node);
					} else {
						this.tree.openNode(item, node);
					}
				} else {
					this.tree.openNode(item, node);
				}
			}),
			openNode : dojo.hitch(this, function(item, node) {
				this.tree._expandNode(node);
				var cover = item.cover;
				if(cover) {
					var productType = item.productType;
					ap.master = this.createCover(cover, item.productId, productType);
				} else if(item.isBottom) {
					var productId = item.productId[0];
					var artifactId = item.id[0];
					var type = item.productType[0];
					ap.master = this.createEditor(productId, artifactId, type);
				}
				return true;
			}),
			closeNode : dojo.hitch(this, function(item, node) {
				this.tree._collapseNode(node);
				var cover = item.cover;
				var productType = item.productType;
				ap.master = this.createCover(cover, item.productId, productType);
				return true;
			}),
			/*
			 * gets the icon class for artifacts on the menu
			 */
			getIconClass : function(item, opened) {
				var className = 'accordion_toggle';
				if (!item || !item.isBottom) {
					if (opened) {
						className = 'accordion_toggle_active';
					}
				} else {
					className = 'artifacts' + ' ' + item.productType;
				}

				return className;
			},
			/*
			 * override of tree onOpen hook point
			 */
			onOpen: function(item, node) {
				if(item.id[0] === 'Products') {
					this.tree.openNode(item, node);
					if(ap.toolkitNavMenu.focusId && ap.toolkitNavMenu.focusId.length > 0) {
						ap.toolkitNavMenu.setMenuFocus(ap.toolkitNavMenu.focusId);
					}
				}
			},
			//commenting this out since it is being called when it should not
			//gives us more control
			focusNode: function(/* _tree.Node */ node){
				// summary:
				//		Focus on the specified node (which must be visible)
				// tags:
				//		protected

				// set focus so that the label will be voiced using screen readers
				//dijit.focus(node.labelNode);
			}
		}, 'navMenu');

	},

	/**
	 * Sets the menu focus to the proper item based on the menu id
	 * @param artifactMenuId is the artifact id that corresponds to the menu.
	 */
	setMenuFocus: function (artifactMenuId) {
		var item = this.store._itemsByIdentity[artifactMenuId];
		var treeNode = this.tree.getNodesByItem(artifactMenuId)[0];
		var parentId = item.parentId[0];
		//the node was not visible so lets open the parent to make it visible
		this.openParentNodes(parentId);
		if(!treeNode) {
			//should be visible now
			treeNode = this.tree.getNodesByItem(artifactMenuId)[0];
			this.tree._expandNode(treeNode);
			dijit.focus(treeNode.labelNode);
			this.tree.openNode(item, treeNode);

		} else {
			dijit.focus(treeNode.labelNode);
			this.tree.openNode(item, treeNode);
		}
	},

	/**
	 * Opens nodes until we have all nodes open to the point where the child is visible
	 * @param nodeId is the node that we are going to open
	 */
	openParentNodes: function(nodeId) {
		var opened = false;
		var item = this.store._itemsByIdentity[nodeId];
		var treeNode = this.tree.getNodesByItem(nodeId)[0];
		var parentId = null;
		if(item.parentId) {
			parentId = item.parentId[0];
		}
		if(treeNode) {
			if(!treeNode.isExpanded) {
				this.tree._expandNode(treeNode);
				//make sure that the parent is opened also
			}
			if(parentId) {
				var parentOpened = this.openParentNodes(parentId);
			}
		} else {
			if(parentId) {
				var parentOpened = this.openParentNodes(parentId);
			}
			treeNode = this.tree.getNodesByItem(nodeId)[0];
			this.tree._expandNode(treeNode);
		}
	},

	/**
	 * Loads the editor that was clicked on
	 * @param productId is the product id we are deaing with
	 * @param artifactId is the artifact id we are dealing with
	 * @param type is the type of editor we will be loading.
	 * @return editor of the type specified.
	 */
	createEditor: function (productId, artifactId, type) {

		toolkitPleaseWait(true);
		var editor = null;
		this.destroyCurrentEditor();

		if (type === 'dynamicListTemplate') {
			editor = new DynamicListTemplateEditor(productId, artifactId, type);
		} else if (type === 'view') {
			editor = new ViewWizard(productId, artifactId, type);
		} else if (type === 'optionList') {
			editor = new OptionListEditor(productId, artifactId);
		} else if (type === 'behavior') {
			editor = new TransactionDefinitionBehaviorEditor(productId,
					artifactId);
		} else if (type === 'pageLibrary' || type === 'tdf') {
			editor = new TDFEditor(productId, artifactId);
		} else if (type === 'arcRule') {
			editor = new ArcRuleWizard(productId, artifactId, {
				type : 'arcRule'
			});
		} else if (type === 'arcRuleRef') {
			editor = new ArcRuleWizard(productId, artifactId, {
				type : 'arcRuleRef'
			});
		} else if (type === 'xarcRule') {
			editor = new XARCRuleWizard(productId, artifactId);
		} else if (type === 'propertyFile') {
			editor = new PropertiesWizard(productId, artifactId);
		} else if ( type == 'workItemAssistant'){
			editor = new WorkItemAssistantEditor(productId, artifactId);
		}
		toolkitPleaseWait(false);
		return editor;
	},
	/**
	 * Loads the cover page that describes everything that is not an artifact
	 * @param type is the type of editor we will be loading.
	 * @param productId is the product id we are deaing with
	 * @param artifactId is the artifact id we are dealing with
	 * @return editor of the type specified.
	 */
	createCover: function (type, productId, artifactType) {
		if(ap.master && ap.master.hasUnsavedChanges && !window.confirm("There are unsaved changes. Are you sure you want to leave anyway?")) {
			return;
		}
		
		this.destroyCurrentEditor();
		var cover = null;
		cover = new CoversEditor(type, productId, artifactType);
		
		return cover;
	},

	/**
	 * Gives a confirm box when there is unsaved changes
	 * @return returns true if the unsaved changes are confirmed and able to be destroyed
	 */
	confirmUnsavedChanges: function() {
		if(ap.master && ap.master.hasUnsavedChanges && !window.confirm("There are unsaved changes. Are you sure you want to leave anyway?")) {
			if(this.lastMenuNode) {
				//turn it off for the last menu node
				dijit.focus(this.lastMenuNode.labelNode);
				//this.tree.focusNode(this.lastMenuNode);
			}
			return false;
		} else {
			return true;
		}
	},

	/**
	 * Destroys the current editor and all its events
	 */
	destroyCurrentEditor: function () {
		try {
			if(ap && ap.master){
				ap.master.destroy();
				ap.master = null;
			}
		}catch(e) {

		}
	}
});
