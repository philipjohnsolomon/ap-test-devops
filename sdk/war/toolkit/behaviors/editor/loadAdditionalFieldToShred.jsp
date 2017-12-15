<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="additionalFieldCount" value="${tk:getCount(toolkitData, path)}"/>

<div class="accordion_inner">
	<div id="${path}" class="fieldSet">
		<div>
			<table>
				<thead>
					<tr>
						<th>Name</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody class="additionalFieldToShredContainer" id="${param.artifactId}_additionalFieldToShredContainer">
					<c:if test="${(additionalFieldCount!='0')}">
						<c:forEach var="index" begin="1" step="1" end="${additionalFieldCount}">
							<jsp:setProperty property="currentIndex" name="toolkitData" value="${index - 1}"/>
							<jsp:include page="additionalFieldToShred.jsp" />
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>