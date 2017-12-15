<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<fieldset id="create_meta_data" class="standardForm">
	<legend>Required Info</legend>
	<div class="standardForm">
		<tk:input path="createArtifact_name" 
			label="Rule Library ID" 
			fieldValue=""  
			required="*" 
			defaultValue="" 
			size="20">
		</tk:input>	
	</div>
</fieldset>
