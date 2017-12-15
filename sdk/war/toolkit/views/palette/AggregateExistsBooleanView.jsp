<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="trueReturnValuePath" value="${path}.@trueReturnValue"/>
<c:set var="falseReturnValuePath" value="${path}.@falseReturnValue"/>

   	<tk:input path="${trueReturnValuePath}" 
			label="If true return" 
			fieldValue="${tk:getFieldValue(toolkitData,trueReturnValuePath,'')}" 
			required="" 
			defaultValue="" 
			size="20" 
			className="trueReturnValue_editor" 
			helptext="view_helptext|iftruereturn">
	</tk:input>	

   	<tk:input path="${falseReturnValuePath}" 
			label="If false return" 
			fieldValue="${tk:getFieldValue(toolkitData,falseReturnValuePath,'')}" 
			required="" 
			defaultValue="" 
			size="20" 
			className="falseReturnValue_editor" 
			helptext="view_helptext|iffalsereturn">
	</tk:input>	
