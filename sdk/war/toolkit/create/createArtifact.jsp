<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="resourceTitle" value="${tk:getResourceTypeTitle(param.type)}"/>
<c:set var="label" value="Create ${resourceTitle}"/>
<c:set var="titleLabel" value="Transaction Title"/>
<c:set var="fileIDHelpText" value="fieldElement_helptext|id"/>
<c:set var="titleHelpText" value="fieldElement_helptext|transactiontitle"/>
<c:if test="${param.type =='workItemAssistant'}">
	<c:set var="titleLabel" value="Assistant Title"/>
	<c:set var="fileIDHelpText" value="workitemAssistant_helptext|fileid"/>
	<c:set var="titleHelpText" value="workitemAssistant_helptext|title"/>
</c:if>
<tk:dialogForm
	action="Toolkit?action=create&type=createArtifact">
	
	<tk:dialogCreateFieldset
		path="createArtifact"
		legend="${label}"
		type=""
		errorMessage="Error creating correction.  Please check the logs to find the cause.">	
			<input type="hidden" id="createArtifact_product" name="createArtifact_product" value="${param.product}"/>
			<input type="hidden" id="createArtifact_type" name="createArtifact_type" value="${param.type}"/>
			
			<tk:input path="createArtifact_fileName" 
					label="File ID" 
					fieldValue=""  
					required="*" 
					defaultValue="" 
					size="20" 
					className="" 
					helptext="${fileIDHelpText}">
			</tk:input>	

			<tk:input path="createArtifact_title" 
					label="${titleLabel}"
					fieldValue=""  
					required="*" 
					defaultValue="" 
					size="20"
					helptext="${titleHelpText}">
			</tk:input>

			<tk:basicTextarea path="createArtifact_description" 
					label="Description" 
					fieldValue=""  
					required="" 
					defaultValue="" 
					size="20">
			</tk:basicTextarea>				

		<c:if test="${param.type == 'tdf' || param.type == 'pageLibrary' || param.type == 'xarcRule' || param.type=='workItemAssistant'}">	
			<c:set var="includeJsp" value="${param.type}.jsp"/>
			<jsp:include page="${includeJsp}" />
		</c:if>
	
	</tk:dialogCreateFieldset>
</tk:dialogForm>