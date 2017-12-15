try {if (ap){}}
catch (e) {ap = {}}
	
function AgencyPortalDebugConsole() {
	this.title = "AgencyPortal Debug Console";
	this.width = "800";
	this.height = "600";
	this.scrollbars = "yes";
	this.consoleRoot = "debug/ap_debug_console.jsp";
	this.panels = new Array();
	this.defaultPanel = null;
	
	this.addPanel = function(id, url, title, text) {
		var panel = new AgencyPortalDebugPanel(id, url, title, text);
		this.panels.push(panel);
	}
	
	this.getPanelById = function(id) {
		for (var i = 0; i < this.panels.length; i++)
			if (this.panels[i].id == id) return this.panels[i];
	}
	
	this.setDefaultPanel = function(id) {
		try {this.defaultPanel = this.getPanelById(id);}
		catch(e) {}
	}
	
	this.open = function(){
		if (this.defaultPanel == null) this.defaultPanel = this.panels[0];
		var url = this.consoleRoot + '?defaultPanelUrl=' + escape(this.defaultPanel.url);
		var title = this.title.replace(/ /g,"_");
		var width = 'width='+this.width;
		var height = 'height='+this.height;
		var scrollbars = 'scrollbars='+this.scrollbars
		var console = window.open(url, title, width, height, scrollbars);
	}
	
	this.makeMenu = function() {
		var html = '<div class="navigation"><select onchange="parent.content.location = this.value">'
				
		for (var ix = 0; ix < this.panels.length; ix++) {
			var selected = "";
			if (this.panels[ix] == this.defaultPanel) selected = ' selected="selected" ';
			html += '<option value="'+this.panels[ix].url+'" '+ selected +' >'+this.panels[ix].text+'</option>';
		}
		html += '</select></div>'
		return(html);
	}
}
ap.AgencyPortalDebugConsole = AgencyPortalDebugConsole;

function AgencyPortalDebugPanel(id,url,title,text) {
	this.id = id;
	this.url = url;
	this.title = title;
	this.text = text;	
}
ap.AgencyPortalDebugPanel = AgencyPortalDebugPanel;

function Introspector(object) {
	this.value = "";
	var typeOf = "";

	this.printProperties = function() {
		var html = "";
		html += "<h4>Properties</h4><table class='about'><thead><tr><th>property</th><th>type</th><th>value</th></tr></thead><tbody>";
		for (var i in object) {
			try {typeOf = typeof (eval("object." + i));}
			catch (e) {typeOf = "notFound";}
			try {value = eval("object." + i.toString());}
			catch (e) {}
			try {if (typeOf == "object" && value.toString().indexOf("function") == 0) typeOf = "function"; }
			catch (e) {}
			if (typeOf == "function") continue;
			if (value === undefined) value = "undefined";
			if (value == "" && typeOf == "string") value = "<span style=\'font-style: italic\'>empty</span>";
			html += "<tr><td>." + i + "</td>";
			html += "<td>" + typeOf + "</td>";
			html += "<td>" + value + "</td>";
			html += "</tr>";
		}
		html += "</tbody></table>";
		return(html);
	}

	this.printMethods = function() {
		var html = "";
		html += "<h4>Methods</h4><ul>";
		for (var i in object) {
			try {typeOf = typeof (eval("object." + i));}
			catch (e) {typeOf = "notFound";}
			try {value = eval("object." + i.toString());}
			catch (e) {}
			try {if (typeOf == "object" && value.toString().indexOf("function") == 0) typeOf = "function"; }
			catch (e) {}
			if (typeOf != "function") continue;			
			html+="<li>." + i + "()</li>";
		}
		html+="</ul>";
		return(html);
	}
	
	this.printAll = function() {
		var html = "<div class='object_summary'>";
		html+=this.printProperties();
		html+=this.printMethods();
		html+="</div>";
		return html;
	}
}
ap.Introspector = Introspector;