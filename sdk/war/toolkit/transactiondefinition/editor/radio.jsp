<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>

<c:set var="requiredPath" value="${basePath}.@required"/>
<c:set var="labelPath" value="${basePath}.@label"/>

<c:set var="required" value="${tk:getFieldValue(toolkitData, requiredPath, 'false')}"/>
<c:set var="label" value="${tk:getFieldValue(toolkitData, labelPath, 'New Radio Field')}"/>

<div id="${basePath}" class="formRow palette_toggle needs_palette fieldElement">
	<label class="label" id="<${basePath}_labelElement" for="${basePath}_radio">
		<span id="${requiredPath}_displayText">
			<c:if test="${required == 'true'}">
				<c:out value="*"/>
			</c:if>		
		</span>
		<span id="${labelPath}_displayText">${label}</span>
	</label>
	<span class="options">
		Yes
		<input type="radio" class="radio" id="${basePath}_radio_yes" value="YES" disabled="disabled"></input>
		No
		<input type="radio" class="radio" id="${basePath}_radio_no" value="NO" disabled="disabled"></input>
	</span>
	<input type="hidden" id="${basePath}_type" value="radio"/>
	<tk:fieldHelper path="${basePath}"/>
</div>