<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="currentSource" value="${toolkitData.optionSource}" />

<c:out value="${tk:getCodeListOptionsTargetHTML(toolkitData, currentSource, '')}" escapeXml="false"/>
	