<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit"%>

<tk:dialogForm
	action="Toolkit?action=create&type=copyProduct&product=${param.product}">

	<tk:dialogCreateFieldset
		path="copyProduct"
		legend="Copy Product"
		type="copyProduct"
		errorMessage="Error creating correction.  Please check the logs to find the cause.">	
		
			<tk:input path="copyProduct_title" 
				label="Product Title" 
				fieldValue=""  
				required="*" 
				defaultValue="" 
				size="20"
				helptext="create_helptext|product_title">
			</tk:input>
			
			<tk:input path="copyProduct_ID" 
				label="Product ID" 
				fieldValue=""  
				required="*" 
				defaultValue="" 
				size="20"
				helptext="create_helptext|product_path">
			</tk:input>
			
			<tk:basicTextarea path="copyProduct_description" 
				label="Description" 
				fieldValue=""  
				required="" 
				defaultValue="" 
				size="20">
			</tk:basicTextarea>				
	</tk:dialogCreateFieldset>
</tk:dialogForm>
