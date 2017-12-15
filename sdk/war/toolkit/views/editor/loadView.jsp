<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="fieldSetPath" value="${toolkitData.basePath}.fieldSet" />
<c:set var="fieldSetCount" value="${tk:getCount(toolkitData, fieldSetPath)}"/>

<div class="accordion_inner">
	<div id="${toolkitData.basePath}.fieldSet_container">
	
		<c:forEach var="fieldIndex" begin="1" step="1" end="${fieldSetCount}">	
			<jsp:setProperty property="basePath" name="toolkitData" value="${fieldSetPath}[${fieldIndex-1}]"/>	
			<jsp:include page="fieldSet.jsp"/>	
		</c:forEach>
	
	</div>
</div>
