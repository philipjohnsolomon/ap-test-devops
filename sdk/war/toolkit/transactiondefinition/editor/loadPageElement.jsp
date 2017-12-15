<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="jspPath" value="pageElement/${param.type}.jsp"/>

<jsp:include page="${jspPath}">
	<jsp:param name="product" value="${param.product}"/>
	<jsp:param name="artifactId" value="${param.artifactId}"/>
	<jsp:param name="path" value="${param.path}"/>
</jsp:include>
