<%@taglib prefix="tk" uri="http://www.agencyportal.com/toolkit"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="defaultListValue" value=""/>
<c:set var="transactionTypes" value="${tk:getOptionListHTML('transactionTypes', defaultListValue,'')}"/>

<fieldset id="create_meta_data" class="standardForm fieldSet">
	<legend>Required Info</legend>
	<div class="standardForm">
		<tk:input path="createArtifact_id" 
			label="Transaction ID" 
			fieldValue=""  
			required="*" 
			defaultValue="" 
			size="20"
			className="idCharacters"
			helptext="create_helptext|transaction_path">
		</tk:input>	
		<tk:input path="createArtifact_target" 
			label="Schema" 
			fieldValue=""  
			required="*" 
			defaultValue="" 
			size="20"
			helptext="create_helptext|transaction_schema">
		</tk:input>
		<tk:select label="Type of Transaction" 
			required="*"
			path="transaction_type">
			${transactionTypes}
		</tk:select>
	</div>
</fieldset>
