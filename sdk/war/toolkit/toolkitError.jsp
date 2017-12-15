<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
 <div id="alert" class="critical">
 	<h4 class="critical">Error</h4>
	<c:forEach var="message" items="${toolkitData.messages}" >
		<p><c:out value="${message}"/></p>
	</c:forEach>
 </div>
