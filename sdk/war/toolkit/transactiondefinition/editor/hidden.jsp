<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>

<c:set var="idPath" value="${basePath}.@id"/>
<c:set var="id" value="${tk:getFieldValue(toolkitData, idPath, 'Saves To Path')}"/>

<div id="${basePath}" class="hiddenField palette_toggle needs_palette fieldElement">
	<input type="hidden" id="${basePath}_type" value="hidden"/>
	<p id="${idPath}_displayText">
		<span id="${basePath}_required"></span>
		${id}
	</p>
</div>