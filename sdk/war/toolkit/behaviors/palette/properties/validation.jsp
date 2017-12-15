<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="validationsPath" value="${path}.validation"/>
<c:set var="validationsValue" value="${tk:getFieldValue(toolkitData,validationsPath,'')}"/>
<c:set var="idPath" value="${validationsPath}.@id"/>
<c:set var="idValue" value="${tk:getFieldValue(toolkitData,idPath,'')}"/>
<c:set var="messagePath" value="${validationsPath}.@message"/>
<c:set var="messageValue" value="${tk:getFieldValue(toolkitData,messagePath,'')}"/>
<c:set var="negatePath" value="${validationsPath}.@negate"/>
<c:set var="negateValue" value="${tk:getFieldValue(toolkitData,negatePath,'')}"/>
<c:set var="contentPath" value="${validationsPath}.@content"/>
<c:set var="removePath" value="${validationsPath}.@remove"/>
<c:set var="typePath" value="${validationsPath}.@type"/>
<c:set var="namePath" value="${path}.@name"/>

<tk:dialogForm
	action="Toolkit?action=addValidation&product=${param.product}&artifactId=${param.artifactId}">
	
	<tk:dialogFieldset
		path="${path}"
		legend="Validation Options"
		type=""
		errorMessage="Error creating validation.  Please check the logs to find the cause.">	
		<input type="hidden" id="${namePath}" name="${namePath}" value="validation"/>
		
		<tk:select path="${typePath}" label="Validation Type" elementName="${typePath}" required="*">
			<c:out value="${tk:getOptionsHTML(toolkitData, 'behaviorValidation', typePath, '')}" escapeXml="false"/>
		</tk:select>
		
		<tk:input path="${idPath}" label="ID" fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}" 
			elementName="${idPath}" required="*" defaultValue="${idValue}" size="20">
		</tk:input>
		
		<tk:input path="${messagePath}" label="Message" fieldValue="${tk:getFieldValue(toolkitData,messagePath,'')}" 
			elementName="${messagePath}" required="" defaultValue="${messageValue}" size="20">
		</tk:input>
		
		<tk:input path="${validationsPath}" label="Value" fieldValue="${tk:getFieldValue(toolkitData,validationsPath,'')}" 
			elementName="${validationsPath}" required="" defaultValue="${validationsValue}" size="20">
		</tk:input>
		
		<tk:select label="Negate" 
			path="${negatePath}">
			${tk:getOptionsHTML(toolkitData,'booleanFalse',negatePath,'')}
		</tk:select>	
		
		<tk:select path="${removePath}" label="Remove" elementName="${removePath}" required="">
			<c:out value="${tk:getOptionsHTML(toolkitData, 'noYes', removePath, '')}" escapeXml="false"/>
		</tk:select>	
	</tk:dialogFieldset>
</tk:dialogForm>