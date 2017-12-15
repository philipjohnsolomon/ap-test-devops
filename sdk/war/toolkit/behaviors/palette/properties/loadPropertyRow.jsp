<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="typePath" value="${path}.@name"/>
<c:set var="typeValue" value="${tk:getFieldValue(toolkitData,typePath,'')}"/>
<tk:dialogForm action="Toolkit?action=saveProperty&product=${param.product}&artifactId=${param.artifactId}">

	<tk:dialogFieldset
		path="${path}"
		legend="Alter Options"
		type=""
		errorMessage="Error creating alter.  Please check the logs to find the cause.">	
		
		<div id="${path}_${typeValue}_propertyContent" class="formRow">
			<input type="hidden" id="${typePath}" name="${typePath}" value="${typeValue}" />
			<label for="${path}_labelText">
				<span id="TypeLabel_labelText">Property ${typeValue}</span>
			</label>
		</div>		
		<jsp:include page="${propertyJSP}" />
		
	</tk:dialogFieldset>
</tk:dialogForm>