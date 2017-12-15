<!-- site\submission_navigation_manu.jsp-->
<%@ page import="java.util.List,
				com.agencyport.menu.Decoder,
				com.agencyport.menu.IMenuConstants,
				com.agencyport.menu.Menu,
				com.agencyport.menu.MenuEntry,
				com.agencyport.jsp.JSPHelper,
				com.agencyport.product.ProductDefinitionsManager"%>
<%
JSPHelper jspHelper = JSPHelper.get(request);		
Menu menu = (Menu) request.getAttribute(IMenuConstants.MENU);
List<MenuEntry> entries = menu.getMenuEntries();
String menuTitle = menu.getMenuTitle();
int count = entries.size();

String versionNumber = ProductDefinitionsManager.getCurrentlyRunningVersion().toString();

MenuEntry menuEntry;
int menuEntryJSIndex;
%>

<script type="text/javascript">
	var menu = new Menu('<%=menuTitle%>');
	ap.menu = menu;
	<%
	for (int ix = 0; ix < count; ix++) {
		menuEntry = (MenuEntry) entries.get(ix); 
		menuEntryJSIndex = ix + 1;
		%>
		menu.addEntry(<%=menuEntryJSIndex%>,
			<%=menuEntry.getParentId()%>,
			'<%=menuEntry.getName()%>',
			'<%=JSPHelper.prepareForHTML(menuEntry.getDisplayName())%>',
			'<%=menuEntry.getUrl()%>',
			'<%=menuEntry.getStatus()%>',
			'<%=Decoder.decodeStatusForCSS(menuEntry.getStatus())%>', 
			<%=menuEntry.isSlowLoader()%>,
			<%=menuEntry.isAvailable()%>,
			<%=menuEntry.isSelected()%>,
			<%=menuEntry.isProblematic()%>);
		<%
	}
	%>
	jQuery('#lower').append(menu.getMarkup());
</script>


