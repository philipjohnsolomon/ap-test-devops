<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="oLRTPath" value="${path}.@optionListReferenceTag"/>
<c:set var="customRequired" value="true" scope="request"/>

<jsp:include page="baseCorrection.jsp" >
	<jsp:param name="path" value="${path}"></jsp:param>
</jsp:include>

<tk:input path="${oLRTPath}" 
	label="Option List for Field" 
	fieldValue="${tk:getFieldValue(toolkitData,oLRTPath,'')}" 
	elementName="${oLRTPath}" 
	required="*" 
	defaultValue="${oLRTPath}" 
	size="40" 
	helptext="correction_helptext|optionlistforfield">
</tk:input>