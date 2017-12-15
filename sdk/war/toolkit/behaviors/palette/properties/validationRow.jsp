<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="typePath" value="${path}.@type"/>
<c:set var="typeValue" value="${tk:getFieldValue(toolkitData,typePath,'xmlreader')}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="idValue" value="${tk:getFieldValue(toolkitData,idPath,'')}"/>
<c:set var="messagePath" value="${path}.@message"/>
<c:set var="messageValue" value="${tk:getFieldValue(toolkitData,messagePath,'')}"/>
<c:set var="negatePath" value="${path}.@negate"/>
<c:set var="negateValue" value="${tk:getFieldValue(toolkitData,negatePath,'')}"/>
<c:set var="contentPath" value="${path}.@content"/>
<c:set var="pathValue" value="${tk:getFieldValue(toolkitData,path,'')}"/>

<tk:select path="${typePath}" label="Validation Type" elementName="${typePath}" required="*">
	<c:out value="${tk:getOptionsHTML(toolkitData, 'behaviorValidation', typePath, '')}" escapeXml="false"/>
</tk:select>

<tk:input path="${idPath}" label="ID" fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}" 
	elementName="${idPath}" required="*" defaultValue="" size="20">
</tk:input>

<tk:input path="${messagePath}" label="Message" fieldValue="${tk:getFieldValue(toolkitData,messagePath,'')}" 
	elementName="${messagePath}" required="*" defaultValue="" size="20">
</tk:input>

<tk:input path="${contentPath}" label="Value" fieldValue="${tk:getFieldValue(toolkitData,contentPath,'')}" 
	elementName="${contentPath}" required="*" defaultValue="" size="20">
</tk:input>

<tk:input path="${negatePath}" label="Negate" fieldValue="${tk:getFieldValue(toolkitData,negatePath,'')}" 
	elementName="${negatePath}" required="*" defaultValue="" size="20">
</tk:input>