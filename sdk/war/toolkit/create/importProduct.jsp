<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit"%>

<tk:dialogForm
	action="Toolkit?action=import&type=importProduct"
	encodingType="multipart/form-data">

	<tk:dialogCreateFieldset
		path="importProduct"
		legend="Import Product"
		type=""
		errorMessage="Error creating correction.  Please check the logs to find the cause.">	
		
		<tk:file path="file" 
			label="File to Upload" 
			required="*" 
			fileType="zip">
		</tk:file>		
	</tk:dialogCreateFieldset>
</tk:dialogForm>
