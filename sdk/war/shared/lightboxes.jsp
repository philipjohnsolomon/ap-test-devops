<%@ page import="com.agencyport.jsp.LightboxJSPProvider"%>
<%
LightboxJSPProvider provider = new LightboxJSPProvider();
String[] jspList = provider.getJSPList();
for ( int ix = 0; ix < jspList.length; ix++ ) {
	String jspFile = jspList[ix]; 
%>
<jsp:include page="<%=jspFile%>" flush="true" />
<% } %>
