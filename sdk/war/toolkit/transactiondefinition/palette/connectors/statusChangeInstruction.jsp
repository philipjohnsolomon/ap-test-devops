<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="newStatusPath" value="${path}.@value"/>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Triggering_Connectors" focusOnLoad="false" path="${path}" tabDisplayName="Triggering Connectors"></tk:tab>
	</tk:tabs>
	
	<tk:tabContent tabName="Options" path="${path}">
	
		<jsp:include page="baseInstructionAttributes.jsp" />
			
		<tk:input path="${newStatusPath}" 
			label="New Status" 
			fieldValue="${tk:getFieldValue(toolkitData,newStatusPath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${newStatusPath}">
		</tk:input>	
	</tk:tabContent>
	
	<tk:tabContent tabName="Triggering_Connectors" path="${path}" styleValue="display: none">
		<jsp:include page="whenPalette.jsp" />
	</tk:tabContent>
</div>