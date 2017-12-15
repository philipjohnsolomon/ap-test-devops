<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="messagePath" value="${path}.@message"/>
<c:set var="negatePath" value="${path}.@negate"/>
<c:set var="negateValue" value="${tk:getFieldValue(toolkitData,negatePath,'')}"/>
<c:set var="contentPath" value="${path}.@content"/>
<c:set var="helptextPath" value="validation_helptext|${TYPE}"/>

<tk:dialogForm
	action="Toolkit?action=addValidation&product=${param.product}&artifactId=${param.artifactId}">
	
	<tk:dialogFieldset
		path="${path}"
		legend="Validation Options"
		type="${TYPE}"
		errorMessage="Error creating validation.  Please check the logs to find the cause.">
		
		<tk:input path="${idPath}" 
			label="ID" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'newID')}"  
			required="*" 
			defaultValue="" 
			size="40"
			className="idCharacters" 
			helptext="validation_helptext|id">
		</tk:input>
		<tk:input path="${contentPath}" 
			label="Value" 
			fieldValue="${tk:getFieldValue(toolkitData,path,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${path}"
			helptext="${helptextPath}">
		</tk:input>	
		<tk:select label="Negate Expression" 
			path="${negatePath}" 
			helptext="validation_helptext|negateexpression">
			${tk:getOptionListHTML('noYes',negateValue,'')}
		</tk:select>
		<tk:textarea path="${messagePath}" 
			label="Message" 
			fieldValue="${tk:getFieldValue(toolkitData,messagePath,'')}"  
			required="" 
			defaultValue="" 
			size="60"
			className="title_editor" 
			helptext="validation_helptext|message">
		</tk:textarea>	
	</tk:dialogFieldset>
</tk:dialogForm>