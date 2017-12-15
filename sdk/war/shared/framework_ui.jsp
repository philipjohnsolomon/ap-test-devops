<!--BEGIN framework_ui.JSP -->

<%@ page import="com.agencyport.jsp.*" %>
<%
	JSPProvider jspProvider = new WorkItemMenuJSPProvider();
	String[] jspList = jspProvider.getJSPList();
	for ( int ix = 0; ix < jspList.length; ix++ ) {
	%>
		<jsp:include page="<%=jspList[ix]%>" flush="true" />
	<%}%>
	<jsp:include page="../shared/lightboxes.jsp" flush="true" />

<!--END FRAMEWORK UI JSP -->	