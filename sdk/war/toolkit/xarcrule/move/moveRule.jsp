<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="moveData" class="com.agencyport.toolkit.data.search.MoveDialogListData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="typePath" value="${param.path}.@type"/>
<c:set var="type" value="${tk:getFieldValue(toolkitData, typePath, '')}"/>
<c:set var="titlePath" value="${param.path}.@title"/>
<c:set var="titleValue" value="${tk:getFieldValue(toolkitData, titlePath, type)}"/>
<c:set var="orderPath" value="${param.path}.@order"/>
<c:set var="moveToPath" value="${param.path}.@movePath"/>
<c:set var="ruleLibrary" value="${tk:getFieldValue(toolkitData, '@name', '')}"/>

<tk:dialogForm
	action="Toolkit?action=handleMove&product=${param.product}&artifactId=${param.artifactId}">
	
	<p>Moving will save your work.  If you do not wish to save your work please close the window.</p>
	
	<input type="hidden" id="${ruleLibrary}" name="${ruleLibrary}" value=""/>
	
	<tk:dialogFieldset
		path="${param.path}"
		legend="Move: ${titleValue}"
		type="${type}"
		errorMessage="Error loading move dialog.  Please check the logs to find the cause.">
		
		<tk:select path="${orderPath}" label="Move">
			<option value="before">Before</option>
			<option value="after">After</option>
		</tk:select>
		
		<tk:select path="${moveToPath}" label="Rule">
			<c:out value="${moveData.ruleLibraryResults}" escapeXml="false"/>
		</tk:select>
		
	</tk:dialogFieldset>
</tk:dialogForm>