<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="moveData" class="com.agencyport.toolkit.data.search.MoveDialogListData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="typePath" value="${param.path}.@type"/>
<c:set var="type" value="${tk:getFieldValue(toolkitData, typePath, '')}"/>
<c:set var="titlePath" value="${param.path}.@label"/>
<c:set var="titleValue" value="${tk:getFieldValue(toolkitData, titlePath, type)}"/>
<c:set var="orderPath" value="${param.path}.@order"/>
<c:set var="moveToPath" value="${param.path}.@movePath"/>
<c:set var="idPath" value="${param.path}.@id"/>
<c:set var="sectionId" value="${tk:getFieldValue(toolkitData, idPath, '')}"/>

<tk:dialogForm
	action="Toolkit?action=handleMove&product=${param.product}&artifactId=${param.artifactId}">
	
	<p>Moving will save your work.  If you do not wish to save your work please close the window.</p>
	
	<input type="hidden" id="${sectionId}" name="${sectionId}" value=""/>
	
	<tk:dialogFieldset
		path="${param.path}"
		legend="Move: ${titleValue}"
		type="${type}"
		errorMessage="Error loading move dialog.  Please check the logs to find the cause.">
		
		<tk:select path="${orderPath}" label="Move">
			<option value="before">Before</option>
			<option value="after">After</option>
		</tk:select>
		
		<tk:select path="${moveToPath}" label="Sections">
			<c:out value="${moveData.workItemAssistantResults}" escapeXml="false"/>
		</tk:select>
		
	</tk:dialogFieldset>
</tk:dialogForm>