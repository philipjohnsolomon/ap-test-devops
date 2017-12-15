<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>
<c:set var="labelPath" value="${basePath}.@label"/>

<td id="${basePath}" class="column palette_toggle needs_palette fieldElement">
	<input type="hidden" id="${basePath}_type" value="column"/>
	<p id="${basePath}.@title_displayText">
		<span id="${basePath}_span"></span>
		<c:out value="${tk:getFieldValue(toolkitData, labelPath, 'New Column')}" escapeXml="false"/>
	</p>
</td>