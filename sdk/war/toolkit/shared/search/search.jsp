<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<tk:dialogForm
	action="Toolkit?action=search&product=${param.product}&artifactId=${param.artifactId}">
	
	<tk:searchDialogFieldset
		path="searchPath"
		legend="Search"
		errorMessage="Error creating correction.  Please check the logs to find the cause.">	
		
		<div class="formRow">
			<span>
				Title
			</span>
			<span>
				<input type="text" class="combo_event" value="" id="searchField" name="searchField"/>	
				<input type="hidden" name="searchKey" id="searchKey" value="" />
			</span>
		</div>
		
	</tk:searchDialogFieldset>
</tk:dialogForm>
