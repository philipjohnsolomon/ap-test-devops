<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.agencyport.servlets.base.IBaseConstants"%>
<%@ page import="com.agencyport.shared.ExceptionReport" %>

<%
	ExceptionReport exception = (ExceptionReport)request.getAttribute(IBaseConstants.ERROR_REPORT);
%>
<div id="roster_wrapper">
	<% if(null != exception) { %>
		<jsp:include page="error.jsp" />
	<%}else{ %>
		<div id="messageDiv">
			<jsp:include page="../shared/messageTemplate.jsp" flush="true" />
		</div>
		<c:if test="${empty updated}">
			<div class="roster-container">${locations}</div>
   			<jsp:include page="setupPage.jsp" />
   		</c:if>
   <%} %>
</div>

