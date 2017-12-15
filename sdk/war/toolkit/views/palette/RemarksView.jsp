<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="indexPath" value="${path}.@index"/>
<c:set var="apTypePath" value="${path}.@apType"/>

	<tk:input path="${indexPath}" 
			label="Index" 
			fieldValue="${tk:getFieldValue(toolkitData,indexPath,'')}" 
			required="" 
			defaultValue="" 
			size="20" 
			className="index_editor numeric" 
			helptext="view_helptext|index">
	</tk:input>

	<tk:textarea path="${apTypePath}" 
			label="AP Type" 
			fieldValue="${tk:getFieldValue(toolkitData,apTypePath,'')}"  
			required="" 
			defaultValue="path" 
			size="40"
			className="apType_editor" 
			helptext="view_helptext|aptype">
	</tk:textarea>	