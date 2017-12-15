<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="sourcePath" value="${path}.@source"/>
<c:set var="customRequired" value="false" scope="request"/>

<jsp:include page="baseCorrection.jsp" >
	<jsp:param name="path" value="${path}"></jsp:param>
</jsp:include>

<tk:select path="${sourcePath}" 
	label="Source" 
	elementName="${sourcePath}" 
	required="*"
	helptext="correction_helptext|source">
	<c:out value="${tk:getOptionsHTML(toolkitData, 'correctionSource', sourcePath, '')}" escapeXml="false"/>
</tk:select>