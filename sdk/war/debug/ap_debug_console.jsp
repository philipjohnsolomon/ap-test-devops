<html>
	<head>
	<title>AgencyPortal Console</title>
	<script type="text/javascript">
		var page = opener.ap.page;
		var transaction = opener.ap.transaction;
		var user = opener.ap.user;
		var debugConsole = opener.ap.debugConsole;
	</script>
	</head>
	
	<frameset border="0" framespacing="0" rows="45,*">
		<frame src="ap_debug_menu.jsp" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" name="menu" id="menu">
		<frame src="<%=request.getParameter("defaultPanelUrl")%>" frameborder="0" marginwidth="0" marginheight="0" name="content" id="content">
	</frameset>
</html>