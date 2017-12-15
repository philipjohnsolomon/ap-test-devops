<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>
<div class="standardForm">
	<table class="questionnaire">
		<thead>
			<tr>
				<th><div class="hidden">Required</div></th>
				<th><div class="hidden">Question #</div></th>
				<th><div class="hidden">Question</div></th>
				<th>Yes</th>
				<th>No</th>
				<th><div class="hidden">Help</div></th>
			</tr>
		</thead>
		<tbody id="${basePath}.fieldElement_container">
			<%// the class name of child JSP snippets %>
			<tr class="hidden">
				<th class="hidden">
					<%// the class name of child JSP snippets %>
					<input type="hidden" class="_childClassName" value="fieldElement"/>
				</th>
			</tr>

			<c:set var="fieldElementPath" value="${basePath}.fieldElement"/>
			<c:set var="fieldCount" value="${tk:getCount(toolkitData, fieldElementPath)}"/>
			<c:if test="${fieldCount != 0}">
				<c:forEach var="index" begin="0" step="1" end="${fieldCount - 1}">

					<c:set var="typePath" value="${fieldElementPath}[${index}].@type"/>
					<c:set var="typeValue" value="${tk:getFieldValue(toolkitData, typePath, '')}"/>
					<c:set var="jspPage" value="../../editor/${typeValue}.jsp"/>
					<c:set var="fieldElementIndexedPath" value="${fieldElementPath}[${index}]"/>
					<c:set var="fieldSetType" value="questionnaire"/>

					<jsp:setProperty name="toolkitData" property="basePath" value="${fieldElementIndexedPath}"/>

					<c:if test="${not empty typeValue}">
						<jsp:include page="${jspPage}"/>
					</c:if>
				</c:forEach>
			</c:if>

			<% /* FIXME: exiting the loop and setting basePath back to original value.  do we need to do this? */ %>
			<jsp:setProperty name="toolkitData" property="basePath" value="${basePath}"/>
		</tbody>
	</table>
</div>