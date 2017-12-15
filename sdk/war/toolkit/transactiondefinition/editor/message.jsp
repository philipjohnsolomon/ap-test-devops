<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="messagePath" value="${toolkitData.basePath}"/>
<div id="${messagePath}" class="palette_toggle needs_palette message fieldElement">
	<input type="hidden" id="${messagePath}_type" value="message"/>
	<p id="${messagePath}.@content_displayText">${tk:getFieldValue(toolkitData, messagePath, '')}</p>
</div>