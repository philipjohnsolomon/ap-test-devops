<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="valuePath" value="${path}.@value"/>

<div id="${path}_palette" class="palette">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"/>
		<tk:tab tabName="Triggering_Connectors" focusOnLoad="false" path="${path}" tabDisplayName="Triggering Connectors"/>
	</tk:tabs>
	
	<tk:tabContent tabName="Options" path="${path}">			
		<jsp:include page="baseInstructionAttributes.jsp" />
		<tk:textarea path="${valuePath}" 
			label="Value" 
			fieldValue="${tk:getFieldValue(toolkitData,valuePath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${valuePath}"
			className="idCharacters" 
			helptext="fieldElement_helptext|groupid">
		</tk:textarea>					
	</tk:tabContent>
	
	<tk:tabContent tabName="Triggering_Connectors" path="${path}" styleValue="display: none">
		<jsp:include page="whenPalette.jsp" />
	</tk:tabContent>
</div>