<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="moveData" class="com.agencyport.toolkit.data.search.MoveDialogListData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="typePath" value="${param.path}.@type"/>
<c:set var="type" value="${tk:getFieldValue(toolkitData, typePath, '')}"/>
<c:set var="labelPath" value="${param.path}.@label"/>
<c:set var="labelValue" value="${tk:getFieldValue(toolkitData, labelPath, type)}"/>
<c:set var="orderPath" value="${param.path}.@order"/>
<c:set var="moveToPath" value="${param.path}.@movePath"/>

<tk:dialogForm
	action="Toolkit?action=handleMove&product=${param.product}&artifactId=${param.artifactId}">
	
	<p>Moving will save your work.  If you do not wish to save your work please close the window.</p>
	
	<tk:dialogFieldset
		path="${param.path}"
		legend="Move: ${labelValue}"
		type="${type}"
		errorMessage="Error loading move dialog.  Please check the logs to find the cause.">
		
		<tk:select path="${orderPath}" label="Move">
			<option value="before">Before</option>
			<option value="after">After</option>
		</tk:select>
		
		<tk:select path="${moveToPath}_page" label="Page" elementName="" className="change_event moveDialogRefresh">
			<c:out value="${moveData.pageResults}" escapeXml="false"/>
		</tk:select>
		
		<tk:select path="${moveToPath}_pageElement" label="Section" elementName="" className="change_event moveDialogRefresh page_refresh_target">
			<c:out value="${moveData.pageElementResults}" escapeXml="false"/>
		</tk:select>
		
		<tk:select path="${moveToPath}" label="Field" className="pageElement_refresh_target">
			<c:out value="${moveData.fieldElementResults}" escapeXml="false"/>
		</tk:select>
		
	</tk:dialogFieldset>
</tk:dialogForm>