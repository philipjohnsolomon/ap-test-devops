<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>

<c:set var="requiredPath" value="${basePath}.@required"/>
<c:set var="labelPath" value="${basePath}.@label"/>

<c:set var="required" value="${tk:getFieldValue(toolkitData, requiredPath, 'false')}"/>
<c:set var="label" value="${tk:getFieldValue(toolkitData, labelPath, 'New Selectlist Field')}"/>

<div id="${basePath}" class="formRow palette_toggle needs_palette fieldElement">
	<label class="label" id="${basePath}_labelElement" for="${basePath}_select">
		<span id="${requiredPath}_displayText" >
			<c:if test="${required == 'true'}">
				<c:out value="*"/>
			</c:if>
		</span>
		<span id="${labelPath}_displayText">${label}</span>
 	</label>
	<span>
		<select id="${basePath}_select" class="select_list_event editorOptionListLoad"/>
 	</span>
 	<input type="hidden" id="${basePath}_type" value="selectlist"/>
 	<tk:fieldHelper path="${basePath}"></tk:fieldHelper>
</div>