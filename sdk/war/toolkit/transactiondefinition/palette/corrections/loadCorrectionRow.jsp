<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="correctionPage" value="${param.type}.jsp"/>

<tr id="${path}_optionRow" >
	<td id="${path}_optionCell" colspan = "3">
		<jsp:include page="${correctionPage}" >
			<jsp:param name="path" value="${path}" />	
		</jsp:include>
	</td>
</tr>
