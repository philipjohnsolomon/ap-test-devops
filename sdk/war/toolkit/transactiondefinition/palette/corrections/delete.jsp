<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

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
	</tk:dialogFieldset>
</tk:dialogForm>
