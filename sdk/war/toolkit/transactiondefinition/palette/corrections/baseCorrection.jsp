<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="conditionPath" value="${path}.@condition"/>
<c:set var="messagePath" value="${path}.@message"/>
<c:set var="classNamePath" value="${path}.@className"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="requiredValue" value=""/>

<c:if test="${param.customRequired == 'true'}">
	<c:set var="requiredValue" value="*"/>
</c:if>
		
<tk:input path="${idPath}" 
	label="ID" 
	fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"  
	required="*" 
	defaultValue="" 
	size="40"
	elementName="${idPath}"
	className="idCharacters" 
	helptext="correction_helptext|id">
</tk:input>
		
<tk:select label="Condition" 
	path="${conditionPath}"
	helptext="correction_helptext|condition">
	${tk:getOptionsHTML(toolkitData,'correctionCondition',conditionPath,'')}
</tk:select>
		
<tk:input path="${messagePath}" 
	label="Message" 
	fieldValue="${tk:getFieldValue(toolkitData,messagePath,'')}"  
	required="" 
	defaultValue="" 
	size="40"
	elementName="${messagePath}" 
	helptext="correction_helptext|message">
</tk:input>
		
<tk:input path="${classNamePath}" 
	label="Class Name" 
	fieldValue="${tk:getFieldValue(toolkitData,classNamePath,'')}"  
	required="${requiredValue}" 
	defaultValue="" 
	size="40"
	elementName="${classNamePath}" 
	helptext="correction_helptext|message">
</tk:input>
