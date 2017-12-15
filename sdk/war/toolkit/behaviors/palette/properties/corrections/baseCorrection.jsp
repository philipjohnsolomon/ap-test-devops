<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="conditionPath" value="${path}.@condition"/>
<c:set var="messagePath" value="${path}.@message"/>
<c:set var="classNamePath" value="${path}.@className"/>

<c:set var="customValue" value="*"/>
<c:if test="${param.customRequired != true}">
	<c:set var="customValue" value=""/>
</c:if>

<tk:input path="${idPath}" 
	label="ID" 
	fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}" 
	elementName="${idPath}" 
	required="*" 
	defaultValue="" 
	size="40" 
	className="idCharacters"
	helptext="correction_helptext|id">
</tk:input>

<tk:select path="${conditionPath}" 
	label="Condition" 
	elementName="${conditionPath}" 
	required="*" 
	helptext="correction_helptext|condition">
	<c:out value="${tk:getOptionsHTML(toolkitData, 'correctionCondition', conditionPath, '')}" escapeXml="false"/>
</tk:select>

<tk:input path="${messagePath}" 
	label="Message" 
	fieldValue="${tk:getFieldValue(toolkitData,messagePath,'')}" 
	elementName="${messagePath}" 
	required="*" 
	defaultValue="" 
	size="40"
	helptext="correction_helptext|message">
</tk:input>

<tk:input path="${classNamePath}" 
	label="Class Name" 
	fieldValue="${tk:getFieldValue(toolkitData,classNamePath,'')}" 
	elementName="${classNamePath}" 
	required="${customValue}" 
	defaultValue="" 
	size="40"
	helptext="correction_helptext|message">
</tk:input>