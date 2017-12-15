<%@page import="com.agencyport.domXML.APDataCollection"%>
<%
	String type = request.getParameter("type");
	String path = request.getParameter("path");
	String jspPage = type + ".jsp";
%>
<jsp:include page="<%=jspPage%>" >
	<jsp:param name="path" value="<%=path%>" />	
</jsp:include>
