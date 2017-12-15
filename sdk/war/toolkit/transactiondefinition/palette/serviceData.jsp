<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="legendPath" value="${path}.@legend"/>

<div id="${path}_palette" class="palette">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Impacted By" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="serviceData"/>
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		
		<tk:textarea path="${path}.@title" 
			label="Legend" 
			fieldValue="${tk:getFieldValue(toolkitData,legendPath,'New serviceData')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${legendPath}"
			className="title_editor change_event accordion_update" 
			helptext="pageElement_helptext|legend">
		</tk:textarea>	

		<tk:textarea path="${idPath}" 
			label="ID" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${idPath}"
			className="idCharacters" 
			helptext="pageElement_helptext|id">
		</tk:textarea>	
	</tk:tabContent>
	
	<tk:tabContent tabName="Impacted By" path="${path}" styleValue="display: none;">
		<jsp:include page="behaviorCrossRef.jsp" >
			<jsp:param name="entity" value="Page Element"></jsp:param>
		</jsp:include>
	</tk:tabContent>

</div>