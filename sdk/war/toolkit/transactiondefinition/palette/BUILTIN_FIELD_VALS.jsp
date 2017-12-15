<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="titlePath" value="${path}.@title"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="suppressMessageDisplayPath" value="${path}.@suppressMessageDisplay"/>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Triggering Connectors" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>
	
	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="BUILTIN_FIELD_VALS"/>
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />

		<tk:input path="${titlePath}" 
			label="Title" 
			fieldValue="${tk:getFieldValue(toolkitData,titlePath,'')}"  
			required="*" 
			defaultValue="New Connector" 
			size="40"
			elementName="${titlePath}"
			className="title_editor">
		</tk:input>				
		<tk:input path="${idPath}" 
			label="ID" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"  
			required="*" 
			defaultValue="newID" 
			size="40"
			elementName="${idPath}">
		</tk:input>				
		<tk:select label="Suppress Message Display" 
			path="${suppressMessageDisplayPath}">
			${tk:getOptionsHTML(toolkitData,'booleanFalse',suppressMessageDisplayPath,'')}
		</tk:select>			
	</tk:tabContent>	
	
	<tk:tabContent tabName="Triggering Actions" path="${path}" styleValue="display: none">
			<jsp:include page="connectors/executeWhenPalette.jsp" />
	</tk:tabContent>
</div>