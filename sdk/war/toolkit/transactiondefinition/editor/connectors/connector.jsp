<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>

<c:set var="idPath" value="${basePath}.@id"/>
<c:set var="titlePath" value="${basePath}.@title"/>
<c:set var="typePath" value="${basePath}.@type"/>

<c:set var="id" value="${tk:getFieldValue(toolkitData, idPath, 'newID')}"/>
<c:set var="title" value="${tk:getFieldValue(toolkitData, titlePath, 'New Connector')}"/>
<c:set var="type" value="${tk:getFieldValue(toolkitData, typePath, param.type)}"/>
<tr id="${basePath}" class="palette_toggle needs_palette connector ">
	<td>
		<input type="hidden" id="${basePath}_type" value="${param.type}"/>
		<span title="${id}" class="dataEntry" id="${basePath}.@id_label">${id}</span>
	</td>
	<td>
		<span title="${title}" class="dataEntry" id="${basePath}.@title_label">${title}</span> 
	</td>
	<td>
		<span title="${type}" class="dataEntry" id="${basePath}.@type_label">${type}</span> 
	</td>
</tr>