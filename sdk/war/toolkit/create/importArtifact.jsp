<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="resourceTitle" value="${tk:getResourceTypeTitle(param.type)}"/>
<c:set var="fileValidation" value="xml"/>

<c:if test="${param.type == 'pdf'}">	
	<c:set var="fileValidation" value="pdfFile"/>
</c:if>

<tk:dialogForm
	action="Toolkit?action=import&type=importArtifact"
	encodingType="multipart/form-data">
	
	<tk:dialogCreateFieldset
		path="createProduct"
		legend="Import ${reaourceTitle}"
		type=""
		errorMessage="Error creating correction.  Please check the logs to find the cause.">	
		
		<input type="hidden" id="importArtifact_artifact" name="importArtifact_product" value="${param.product}"/>
		<input type="hidden" id="importArtifact_type" name="importArtifact_type" value="${param.type}"/>
			
		<tk:file path="importArtifact_file" 
			label="File" 
			fileType="${fileValidation}" 
			required="*">
		</tk:file>	
		<tk:input path="importArtifact_title" 
			label="Title" 
			fieldValue=""  
			required="*" 
			defaultValue="" 
			size="20">
		</tk:input>					
	</tk:dialogCreateFieldset>
</tk:dialogForm>