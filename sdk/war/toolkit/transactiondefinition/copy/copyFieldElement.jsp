<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="copyData" class="com.agencyport.toolkit.data.search.MoveDialogListData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="typePath" value="${param.path}.@type"/>
<c:set var="type" value="${tk:getFieldValue(toolkitData, typePath, '')}"/>
<c:set var="sourceLabelPath" value="${param.path}.@label"/>
<c:set var="labelValue" value="${tk:getFieldValue(toolkitData, sourceLabelPath, '')}"/>
<c:set var="sourceIdPath" value="${param.path}.@id"/>
<c:set var="idValue" value="${tk:getFieldValue(toolkitData, sourceIdPath, '')}"/>

<c:set var="orderPath" value="${param.path}.@order"/>
<c:set var="moveToPath" value="${param.path}.@movePath"/>

<tk:dialogForm
	
	action="Toolkit?action=handleCopyField&product=${param.product}&artifactId=${param.artifactId}">
	
	<p>Copying will save your work. If you do not wish to save your work please close the window.</p>
	
	<tk:dialogFieldset
		path="${toolkitData.basePath}"
		legend="Copy: ${labelValue}"
		type="${type}"
		errorMessage="Error loading copy dialog.  Please check the logs to find the cause.">
		
		<input type="hidden" id="sourcePath" name="sourcePath" value="${param.path}"/> 
		<input type="hidden" id="${orderPath}" name="${orderPath}" value="after"/> 
		<input type="hidden" id="${moveToPath}" name="${moveToPath}" value="${param.path}"/>
		
		<tk:input path="fieldLabel" 
			label="Label" 
			fieldValue="${labelValue}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="fieldLabel"
			className="" 
			helptext="copyField_helptext|label">
		</tk:input>
		
		<tk:input path="fieldId" 
			label="Saves To" 
			fieldValue="${idValue}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="fieldId"
			className="idCharacters" 
			helptext="copyField_helptext|savesTo">
		</tk:input>
		
		<tk:input path="fieldUniqueId" 
			label="Unique ID" 
			fieldValue=""  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="fieldUniqueId"
			className="idCharacters" 
			helptext="copyField_helptext|uniqueId">
		</tk:input>	
	</tk:dialogFieldset>
</tk:dialogForm>