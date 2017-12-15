<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="formatMaskPath" value="${path}.formatMask"/>
<c:set var="typePath" value="${formatMaskPath}.@type"/>
<c:set var="removePath" value="${formatMaskPath}.@remove"/>
<c:set var="typeValue" value="${tk:getFieldValue(toolkitData,typePath,'none')}"/>
<c:set var="styleValue" value="display:none"/>

<c:if test="${fn:contains(typeValue,'custom')}">
	<c:set var="styleValue" value="display:block" />
</c:if>

<tk:select path="${typePath}" label="Source" required="*" className="change_event select_list_change">
	<c:out value="${tk:getOptionsHTML(toolkitData, 'formatMaskTypes', typePath, '')}" escapeXml="false"/>
</tk:select>

<tk:select path="${removePath}" label="Remove" required="*" className="">
	<c:out value="${tk:getOptionsHTML(toolkitData, 'noYes', removePath, '')}" escapeXml="false"/>
</tk:select>

<tk:input path="${formatMaskPath}" label="Custom Format" hidden="${styleValue}" fieldValue="${tk:getFieldValue(toolkitData,formatMaskPath,'')}" required="*" defaultValue="" size="40">
</tk:input>