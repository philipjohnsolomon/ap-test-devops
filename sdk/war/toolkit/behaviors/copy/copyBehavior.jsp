<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="copyData" class="com.agencyport.toolkit.data.search.MoveDialogListData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="sourceTitlePath" value="${param.path}.@title"/>
<c:set var="titleValue" value="${tk:getFieldValue(toolkitData, sourceTitlePath, '')}"/>

<tk:dialogForm
	action="Toolkit?action=handleCopyBehavior&product=${param.product}&artifactId=${param.artifactId}">
	
	<p>Copying will save your work. If you do not wish to save your work please close the window.</p>
	
	<tk:dialogFieldset
		path="${toolkitData.basePath}"
		legend="Copy: ${titleValue}"
		type="behavior"
		errorMessage="Error loading copy dialog. Please check the logs to find the cause.">
		
		<input type="hidden" id="sourcePath" name="sourcePath" value="${param.path}"/> 
		<input type="hidden" id="targetPath" name="targetPath" value="${toolkitData.basePath}"/> 
		
		<tk:input path="title" 
			label="Title" 
			fieldValue="${titleValue}"  
			required="*" 
			defaultValue="" 
			size="50"
			elementName="title"
			className="" 
			helptext="behavior_helptext|title">
		</tk:input>

	</tk:dialogFieldset>
</tk:dialogForm>