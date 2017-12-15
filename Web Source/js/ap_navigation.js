/** 
 * @fileoverview This file contains support for the AgencyPort menu infrastructure.
 * @author Michael Albert malbert@agencyport.com
 * @version 0.3
 */
/**
 * 	Constructs a new Menu object.
 * 	@constructor
 * 	@class The Menu class provides support for the left navigation menu.
 *	@param title is the menu title
 * 	@return A new Menu instance
 */
function Menu(title) {
	/**
	 *	The <code>title</code> field contains the menu title for this menu.
	 */
	this.title = title;
	/**
	 *	The <code>entries</code> field is an array of Entry instances.
	 */
	this.entries = new Array();

	this.isUnloading = false;

	function purge(d) {
		try {
			d.menuEntry = null;
		} catch (e) {}
		/*		
		try {
			alert(d.nodeName);
		}
		catch (e){}
*/
		var a = d.attributes,
			i, l, n;
		if (a) {
			l = a.length;
			for (i = 0; i < l; i += 1) {
				n = a[i].name;
				if (typeof d[n] === 'function') {
					d[n] = null;
				}
			}
		}
		a = d.childNodes;
		if (a) {
			l = a.length;
			for (i = 0; i < l; i += 1) {
				purge(d.childNodes[i]);
			}
		}
	}

	this.shutDown = function () {
		if (ap.debugShutdown)
			alert('in navigation menu shutdown');
		//null out pointers on the menu entries
		for (var ix = 0; ix < ap.menu.entries.length; ix++) {
			var menuEntry = ap.menu.entries[ix];
			menuEntry.anchor = null;
			var domListItem = document.getElementById(menuEntry.name + "_menuLink");
			purge(domListItem);
		}
		//null out the menu attached to the list
		document.getElementById('submissionNavigationMenu').menu = null;
	}

	/**
	 *	Finds a menu entry by its id.
	 *	@param id is the id of the menu entry.
	 *	@return the menu entry for the id passed else false if not found
	 *	@type Entry
	 */
	this.getEntryById = function (id) {
		for (var i = 0; i < this.entries.length; i++)
			if (this.entries[i].id == id)
				return this.entries[i];

		return false;
	}
	/**
	 *	Appends a new menu entry to the current menu.
	 *	@param id is the id of the menu entry.
	 *	@param parentId is the id of the parent menu entry if the menu entry is nested.
	 *	@param title is the visible text to show to the user.
	 *	@param url is the url to invoke when the user selects this menu entry.
	 *	@param status is the status of the menu entry.
	 *	@param styleClass is the CSS style to apply to this menu entry.
	 *	@param slowLoader is whether or not the page for this menu item is a 'slow loader' or not.
	 * 	@param isAvailable is a boolean flag reflecting whether or not this menu entry should have a URL link.
	 * 	@param isSelected is a boolean flag reflecting whether or not this menu entry is the currently active page.
	 * 	@param isProblem is a boolean flag reflecting whether or not this menu entry has a problem.
	 */
	this.addEntry = function (id, parentId, name, title, url, status, styleClass, slowLoader, isAvailable, isSelected, isProblem) {
		//this is a root menu item
		var entry = new Entry(id, name, title, url, status, styleClass, menu, slowLoader, isAvailable, isSelected, isProblem);
		if (parentId == 0)
			this.entries.push(entry);
		//this is a child item
		else {
			for (var i = 0; i < this.entries.length; i++) {
				if (parentId == this.entries[i].id) {
					this.entries[i].addChild(entry);
				}
			}
		}
	}

	/**
	 *	Builds the menu HTML div markup for the menu.
	 *	@return the menu HTML div markup for the menu.
	 *	@type String
	 */
	this.getMarkup = function () {
		var markup = document.createElement('div');
		markup.menu = this;
		markup.setAttribute('id', 'submissionNavigationMenu');
		markup.setAttribute('class', 'left-sidebar submission-navigation-menu animated fadeIn');
		//var h3 = document.createElement('h3');
		//h3.appendChild(document.createTextNode(this.title));
		//markup.appendChild(h3);
		var div = document.createElement('ul');
		div.setAttribute('class', 'list-group');
		for (var i = 0; i < this.entries.length; i++)
			div.appendChild(this.entries[i].markup());

		markup.appendChild(div);
		return markup;
	}

	/**
	 *	Returns the current menu entry.
	 *	@return the current menu entry.
	 *	@type Entry
	 */
	this.getCurrentEntry = function () {
		for (var i = 0; i < this.entries.length; i++)
			if (this.entries[i].styleClass == "active")
				return this.entries[i];
	}

	/**
	 *	Returns the menu entry following the current entry.
	 *	@return the menu entry following the current entry.
	 *	@type Entry
	 */
	this.getNextEntry = function () {
		for (var i = 0; i < this.entries.length; i++)
			if (this.entries[i].styleClass == "active" && i != this.entries.length)
				return this.entries[i + 1];

		return null;
	}

	/**
	 *	Returns the menu entry preceeding the current entry.
	 *	@return the menu entry preceeding the current entry.
	 *	@type Entry
	 */
	this.getPreviousEntry = function () {
		for (var i = 0; i < this.entries.length; i++)
			if (this.entries[i].styleClass == "active" && i != 0)
				return this.entries[i - 1];

		return null;
	}

	/**
	 * 	Constructs a new Entry object.
	 * 	@constructor
	 * 	@class The Entry class supports a menu line item.
	 *   @param id is the id of the menu entry.
	 *	@param title is the visible text to show to the user.
	 *	@param url is the url to invoke when the user selects this menu entry.
	 *	@param status is the status of the menu entry.
	 *	@param styleClass is the CSS style to apply to this menu entry.
	 *	@param slowLoader is whether or not the page for this menu item is a 'slow loader' or not.
	 * 	@param isAvailable is a boolean flag reflecting whether or not this menu entry should have a URL link.
	 * 	@param isSelected is a boolean flag reflecting whether or not this menu entry is the currently active page.
	 * 	@param isProblem is a boolean flag reflecting whether or not this menu entry has a problem.
	 */
	function Entry(id, name, title, url, status, styleClass, menu, slowLoader, isAvailable, isSelected, isProblem) {
		this.id = id;
		this.name = name;
		this.pageId = name + "_menuLink";
		this.title = title;
		this.url = url;
		this.status = status;
		this.styleClass = styleClass;
		this.menu = menu;
		this.slowLoader = slowLoader;
		this.children = new Array();
		this.clickEvents = new Array();
		this.isAvailable = isAvailable;
		this.isSelected = isSelected;
		this.isProblem = isProblem;

		this.addChild = function (entry) {
			this.children.push(entry);
		}

		var me = this;

		this.addClickEvent = function (event) {
			if (typeof event == 'function') {

				this.clickEvents.push(event);
				return true;
			}
			return false;
		}

		this.removeClickEvent = function (event) {
			for (var i = 0; i < this.clickEvents.length; i++) {
				if (this.clickEvents[i] == event) {
					this.clickEvents[i] == null;
					this.clickEvents.flatten();
					return true;
				}
			}
			return false;
		}

		this.executeClickEvents = function () {
			//catches a repeat click of the navigation menu to prevent orphaned requests
			if (me.menu.isUnloading)
				return false;
			//iterate through the clickEvents for this menu entry. If any return false, stop processing and return.	
			for (var i = 0; i < me.clickEvents.length; i++)
				if (!me.clickEvents[i](me))
					return false;

			me.menu.isUnloading = true;

			if (me.slowLoader)
				ap.pleaseWaitLB(true);

			window.location.href = me.url;
		}

		this.toggle = function (evt) {
			if (me.subMenuStatus == 'visible') {
				me.ul.style.display = 'none';
				me.subMenuStatus = 'hidden';
			} else {
				me.ul.style.display = '';
				me.subMenuStatus = 'visible';
			}
		}

		this.markup = function () {
			var markup = document.createElement('li');
			markup.menuEntry = this;
			markup.id = this.pageId;
			$(markup).addClass(styleClass);
			$(markup).addClass("list-group-item");
			var p = document.createElement('p');

			if (this.children.length > 0) {
				this.status = 'visible';
				var toggle = document.createElement('a');
				$(toggle).addClass('openToggle');
				toggle.href = 'javascript:void(0)';
				var span = document.createElement('span');
				span.appendChild(document.createTextNode('toggle'));
				ap.registerEvent(toggle, 'click', this.toggle)
				toggle.appendChild(span);
				p.appendChild(toggle);
			}

			var a = document.createElement('a');
			if (this.isAvailable) {
				ap.registerEvent(a, 'click', this.executeClickEvents);
				a.setAttribute('href', '#');
			}
			a.setAttribute('title', ap.htmlDecode(this.title));
			a.menuEntry = this;
			this.anchor = a;

			var i = document.createElement('i');
			i.setAttribute('class', 'fa fa-chevron-right pull-right hidden-xs hidden-sm');

			markup.appendChild(a).appendChild(i);
			markup.appendChild(a).appendChild(document.createTextNode(ap.htmlDecode(this.title)));

			if (this.children.length > 0) {
				var ul = document.createElement('ul');
				ul.setAttribute('class', 'nav nav-list affix');
				var childIsSelected = false;
				var childIsAvailable = false
				for (var i = 0; i < this.children.length; i++) {
					ul.appendChild(this.children[i].markup());
					if (this.children[i].styleClass == 'active') childIsSelected = true;
					if (this.children[i].styleClass == 'available') childIsAvailable = true;
				}
				this.ul = ul;
				if (childIsSelected || childIsAvailable)
					this.subMenuStatus = 'visible';
				else {
					this.subMenuStatus = 'hidden';
					ul.style.display = 'none';
				}
				markup.appendChild(ul);
			}

			return markup;
		}
	}
	ap.registerEvent(window, 'unload', this.shutDown);

}
ap.Menu = Menu;