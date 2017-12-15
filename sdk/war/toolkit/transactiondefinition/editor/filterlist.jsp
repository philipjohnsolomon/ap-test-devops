<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>

<c:set var="requiredPath" value="${basePath}.@required"/>
<c:set var="labelPath" value="${basePath}.@label"/>
<c:set var="sizePath" value="${basePath}.@size"/>

<c:set var="required" value="${tk:getFieldValue(toolkitData, requiredPath, 'false')}"/>
<c:set var="label" value="${tk:getFieldValue(toolkitData, labelPath, 'New Filterlist Field')}"/>
<c:set var="size" value="${tk:getFieldValue(toolkitData, sizePath, '20')}"/>

<div id="${basePath}" class="formRow palette_toggle needs_palette fieldElement select_list_event">
	<input type="hidden" id="${basePath}_type" value="filterlist"/>
    <label id="${basePath}_labelElement" for="${basePath}_filterlist">
		<span id="${requiredPath}_displayText">
			<span class="requiredField">
				<c:if test="${required == 'true'}">
					<c:out value="*"/>
				</c:if>
			</span>
		</span>
		<span id="${basePath}_label">${label}</span>
	</label>
	
	<div class="filterlist">
		<span>
			<select class="filterlist" size="${size}" id="${basePath}_select" tabindex="2">
				<%//<option value="">Select One</option>%>
			</select>
		</span>
		<div class="filterControls">Find: <input type="text" id="${basePath}_filterlist_Find" class="filterInput" disabled="disabled"></input></div>	
	</div>
	<tk:fieldHelper path="${basePath}"/>
</div>