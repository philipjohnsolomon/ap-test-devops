<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit"%>
<tk:dialogForm
	action="Toolkit?action=create&type=createProduct">
	
	<tk:dialogCreateFieldset
		path="createProduct"
		legend="Create Product"
		type=""
		errorMessage="Error creating correction.  Please check the logs to find the cause.">
		
		<input type="hidden" name="action" value="createProduct"/>
		<input type="hidden" id="createArtifact_product" name="createArtifact_product" value="new"/>
		
		<tk:input fieldValue="" defaultValue="" label="Product Title" path="createProduct_title" size="20" required="*" helptext="create_helptext|product_title"></tk:input>
		<tk:input fieldValue="" defaultValue="" label="Product ID" path="createProduct_type" size="20" required="*" helptext="create_helptext|product_type"></tk:input>
		<tk:input fieldValue="" defaultValue="" label="Path" path="createProduct_path" size="20" required="*" helptext="create_helptext|product_path"></tk:input>
		<tk:input fieldValue="" defaultValue="" label="Schema" path="createProduct_schema" size="20" required="*" helptext="create_helptext|product_schema"></tk:input>
		<tk:basicTextarea path="createProduct_description" 
			label="Description" 
			fieldValue=""  
			required="" 
			defaultValue="" 
			size="20">
		</tk:basicTextarea>	
	</tk:dialogCreateFieldset>
</tk:dialogForm>
