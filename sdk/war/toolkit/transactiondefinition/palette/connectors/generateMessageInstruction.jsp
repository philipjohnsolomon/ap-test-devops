<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="messagePath" value="${path}.@value"/>
<c:set var="severityPath" value="${path}.@severity"/>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Triggering_Connectors" focusOnLoad="false" path="${path}" tabDisplayName="Triggering Connectors"></tk:tab>
	</tk:tabs>
	
	<tk:tabContent tabName="Options" path="${path}">
		<jsp:include page="baseInstructionAttributes.jsp" />
		
		<tk:textarea path="${messagePath}" 
			label="Message Text" 
			fieldValue="${tk:getFieldValue(toolkitData,messagePath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${messagePath}">
		</tk:textarea>									
		<tk:select label="Message Severity" 
			path="${severityPath}">
			${tk:getOptionsHTML(toolkitData,'severityInstruction',severityPath,'')}
		</tk:select>			
	</tk:tabContent>
	
	<tk:tabContent tabName="Triggering_Connectors" path="${path}" styleValue="display: none">
			<jsp:include page="whenPalette.jsp" />
	</tk:tabContent>	
</div>