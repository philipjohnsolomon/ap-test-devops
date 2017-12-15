<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<fieldset id="create_meta_data" class="standardForm">
	<div class="standardForm">
		<tk:input path="createArtifact_id" 
			label="Assistant ID" 
			fieldValue=""  
			required="*" 
			defaultValue="" 
			size="20"
			className="idCharacters"
			helptext="workitemAssistant_helptext|id">
		</tk:input>	
	</div>
</fieldset>
