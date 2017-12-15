<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="basePath" value="${toolkitData.basePath}"/>

<div id="${basePath}_deleteField_container" class="deleteField_toggle">	
	<input type="hidden" name="${basePath}.@delete" id="${basePath}.@delete" value="" />
	<input type="hidden" name="${basePath}.@type" id="${basePath}.@type" value="id" />	
	
	<tk:textarea label="Delete Field ID" 
		required="" 
		path="${basePath}" 
		className=""
		defaultValue="" 
		elementName="${basePath}"
		fieldValue="${tk:getFieldValue(toolkitData, basePath, '')}"
		size="60">
	</tk:textarea>
</div>
