<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="titlePath" value="${path}.@title"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="descriptionPath" value="${path}.@description"/>
<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
<tk:input path="${titlePath}"
	label="Title"
	fieldValue="${tk:getFieldValue(toolkitData,titlePath,'New Instruction')}"
	required="*"
	defaultValue="New Instruction"
	className="change_event connectorTitleRefresh"
	size="40">
</tk:input>

<tk:input path="${idPath}"
	label="ID"
	fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"
	required="*"
	defaultValue=""
	className="change_event connectorTitleRefresh idCharacters"
	size="40">
</tk:input>

<tk:textarea path="${descriptionPath}"
	label="Description"
	fieldValue="${tk:getFieldValue(toolkitData,descriptionPath,'')}"
	required=""
	defaultValue=""
	size="40"
	elementName="${descriptionPath}"
	className="idCharacters"
	helptext="fieldElement_helptext|defaultvaluefirstrosterentry">
</tk:textarea>