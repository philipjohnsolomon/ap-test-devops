<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>

<div class="standardForm">
	<div id="${param.path}.fieldElement_container">
		<%// the class name of child JSP snippets %>
		<input type="hidden" class="_childClassName" value="fieldElement"/>
		<c:set var="fieldElementPath" value="${param.path}.fieldElement"/>

		<c:set var="fieldCount" value="${tk:getCount(toolkitData, fieldElementPath)}"/>
		<c:if test="${fieldCount != 0}">
			<c:forEach var="index" begin="0" step="1" end="${fieldCount - 1}">

				<c:set var="typePath" value="${fieldElementPath}[${index}].@type"/>
				<c:set var="typeValue" value="${tk:getFieldValue(toolkitData, typePath, '')}"/>
				<c:set var="jspPage" value="../../editor/${typeValue}.jsp"/>
				<c:set var="fieldElementIndexedPath" value="${fieldElementPath}[${index}]"/>

				<jsp:setProperty name="toolkitData" property="basePath" value="${fieldElementIndexedPath}"/>

				<c:if test="${not empty typeValue}">
					<jsp:include page="${jspPage}">
						<jsp:param name="page" value="${fieldElementIndexedPath}"/>
						<jsp:param name="type" value="${typeValue}"/>
					</jsp:include>
				</c:if>
			</c:forEach>
		</c:if>

		<% /* FIXME: exiting the loop and setting basePath back to original value. */ %>
		<jsp:setProperty name="toolkitData" property="basePath" value="${basePath}"/>
	</div>
</div>