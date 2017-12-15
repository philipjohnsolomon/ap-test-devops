<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<div class="alterPropertyDetails">
	<tk:select path="${path}" label="New Value" required="*">
		<c:out value="${tk:getOptionsHTML(toolkitData, 'boolean', path, '')}" escapeXml="false"/>
	</tk:select>
</div>