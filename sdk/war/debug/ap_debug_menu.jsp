<%@ page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%
JSPHelper jspHelper = JSPHelper.get(request);
IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
%>
<html class="menu">
	<head>
	<title><%= coreRB.getString("head.Title.AgencyPortal") %> Console Menu</title>
	<style type="text/css" title="Debug Theming">
		@import "ap_debug.css";	
	</style>	
	<script type="text/javascript">
		var page = parent.page;
		var transaction = parent.transaction;
		var user = parent.user;
		var debugConsole = parent.debugConsole;
	</script>
	</head>
	<body>			
		<h1><%= coreRB.getString("head.Title.AgencyPortal") %> Console</h1>
		<script type="text/javascript">
			document.write(debugConsole.makeMenu());
			document.close();
		</script>
	</body>
</html>
<!--end debug\ap_debug_menu.jsp -->