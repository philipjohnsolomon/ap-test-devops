<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="titlePath" value="${path}.@title"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="descriptionPath" value="${path}.@description"/>
<c:set var="suppressMessageDisplayPath" value="${path}.@suppressMessageDisplay"/>
<c:set var="classNamePath" value="${path}.@className"/>
<c:set var="supportsPrevalidationPath" value="${path}.@supportsPrevalidation"/>
<c:set var="messageClassFilter" value="${path}.@messageClassFilter"/>
<c:set var="scopePath" value="${path}.@scope"/>
<c:set var="customParametersPath" value="${path}.customParameters"/>
<c:set var="customParametersIdPath" value="${customParametersPath}.@id"/>	
<c:set var="isDisplaySide" value="${fn:contains(path, 'display')}"/>

<div id="${path}_palette" class="palette">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<c:if test="${!isDisplaySide}">
			<tk:tab tabName="Triggering_Actions" focusOnLoad="false" path="${path}" tabDisplayName="Triggering Actions"></tk:tab>
		</c:if>
		<tk:tab tabName="Parameters" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />	
		<tk:input path="${titlePath}" 
			label="Title" 
			fieldValue="${tk:getFieldValue(toolkitData,titlePath,'New Connector')}"  
			required="*" 
			defaultValue="New Connector" 
			size="40"
			elementName="${titlePath}"
			className="change_event connectorTitleRefresh" 
			helptext="connector_helptext|title">
		</tk:input>				
		<tk:input path="${idPath}" 
			label="ID" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'newID')}"  
			required="*" 
			defaultValue="newID" 
			size="40"
			elementName="${idPath}"
			className="idCharacters" 
			helptext="connector_helptext|connectorid">
		</tk:input>				
		<tk:textarea path="${descriptionPath}" 
			label="Description" 
			fieldValue="${tk:getFieldValue(toolkitData,descriptionPath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${descriptionPath}"
			helptext="connector_helptext|description">
		</tk:textarea>			
		<tk:select label="Suppress Message Display" 
			path="${suppressMessageDisplayPath}" 
			helptext="connector_helptext|suppressmessagedisplay">
			${tk:getOptionsHTML(toolkitData,'booleanFalse',suppressMessageDisplayPath,'')}
		</tk:select>			
		<tk:input path="${classNamePath}" 
			label="Class Name" 
			fieldValue="${tk:getFieldValue(toolkitData,classNamePath,'')}"  
			required="*" 
			defaultValue="com.your.custom.connector.path" 
			size="40"
			helptext="connector_helptext|connectorid">
		</tk:input>				
		<tk:select label="Run Connector on Prevalidate" 
			path="${supportsPrevalidationPath}" 
			helptext="connector_helptext|runconnectoronprevalidate">
			${tk:getOptionsHTML(toolkitData,'booleanFalse',supportsPrevalidationPath,'')}
		</tk:select>
		<tk:select label="Scope" 
			path="${scopePath}" 
			helptext="connector_helptext|connectorscope">
			${tk:getOptionsHTML(toolkitData,'scope',scopePath,'')}
		</tk:select>			
		<tk:input path="${messageClassFilter}" 
			label="Message Class Filter" 
			fieldValue="${tk:getFieldValue(toolkitData,messageClassFilter,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${messageClassFilter}">
		</tk:input>
	</tk:tabContent>
	
	<c:if test="${!isDisplaySide}">
		<tk:tabContent tabName="Triggering_Actions" path="${path}" styleValue="display: none">
			<jsp:include page="executeWhenPalette.jsp" />
		</tk:tabContent>
	</c:if>
	
	<tk:tabContent tabName="Parameters" path="${path}" styleValue="display: none">			
		<tk:input path="${customParametersIdPath}" 
			label="ID" 
			fieldValue="${tk:getFieldValue(toolkitData,customParametersIdPath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			className="idCharacters">
		</tk:input>
		<tk:textarea path="${customParametersPath}" 
			label="Custom Parameters" 
			fieldValue="${tk:getFieldValue(toolkitData,customParametersPath,'')}"
			required="" 
			defaultValue="" 
			size="40">
		</tk:textarea>			
	</tk:tabContent>
</div>