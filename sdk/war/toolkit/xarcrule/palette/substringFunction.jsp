<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="functionPath" value="${param.path}.@function"/>
<c:set var="function" value="${tk:getFieldValue(toolkitData, functionPath, '')}"/>
<c:set var="startPos" value="${tk:getStringStartEndPosition(function, 'start')}" />
<c:set var="endPos" value="${tk:getStringStartEndPosition(function, 'end')}" />
	<div id="${param.path}.fn:substring_formRow" class="operand" style="${param.hidden}">
		<tk:input path="${param.path}.substr_start"
			elementName="${param.path}.substr_start"   
			label="Start Position" 
			fieldValue="${startPos}"  
			required="*" 
			defaultValue="" 
			size="40"
			className="required numeric resetValue substringselector" 
			helptext="xarc_helptext|subStringStartPosition">
		</tk:input>
		<tk:input path="${param.path}.substr_end"
			elementName="${param.path}.substr_end"  
			label="End Position" 
			fieldValue="${endPos}"  
			required="*" 
			defaultValue="" 
			size="40"
			className="required numeric resetValue substringselector" 
			helptext="xarc_helptext|subStringLength">
		</tk:input>
	</div>