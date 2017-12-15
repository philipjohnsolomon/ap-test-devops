<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="jspPage" value="/toolkit/defaultPalette.jsp"/>
<c:if test="${param.type == 'behavior'}">
	<c:set var="jspPage" value="../palette/behavior.jsp"/>
</c:if>
<c:if test="${param.type == 'hotfield'}">
	<c:set var="jspPage" value="../palette/hotfield.jsp"/>
</c:if>
<jsp:include page="${jspPage}" >
	<jsp:param name="path" value="${param.path}" />	
</jsp:include>
