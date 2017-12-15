<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="oLRTPath" value="${path}.@optionListReferenceTag"/>
<c:set var="libertyPath" value="${path}.@liberty"/>		

<tk:dialogForm
	action="Toolkit?action=addValidation&product=${param.product}&artifactId=${param.artifactId}">
	
	<tk:dialogFieldset
		path="${path}"
		legend="Correction Options"
		type="${TYPE}"
		errorMessage="Error creating correction.  Please check the logs to find the cause.">
		
	<jsp:include page="baseCorrection.jsp" >
		<jsp:param name="customRequired" value="false"></jsp:param>
	</jsp:include>

	<tk:input path="${oLRTPath}" 
		label="Option List for Field" 
		fieldValue="${tk:getFieldValue(toolkitData,oLRTPath,'')}"  
		required="" 
		defaultValue="" 
		size="40"
		elementName="${oLRTPath}"
		helptext="correction_helptext|optionlistforfield">
	</tk:input>	
	<tk:select label="Liberty" 
		path="${libertyPath}"
		helptext="correction_helptext|liberty">
		${tk:getOptionsHTML(toolkitData,'correctionLiberty',libertyPath,'')}
	</tk:select>
	</tk:dialogFieldset>
</tk:dialogForm>