<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="sourcePath" value="${path}.@source"/>

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
			
		<tk:select label="Source" 
			path="${sourcePath}"
			helptext="correction_helptext|source">
			${tk:getOptionsHTML(toolkitData,'correctionSource',sourcePath,'')}
		</tk:select>
	</tk:dialogFieldset>
</tk:dialogForm>
