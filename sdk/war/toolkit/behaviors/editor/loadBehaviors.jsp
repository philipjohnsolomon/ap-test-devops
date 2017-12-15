<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="listPath" value="${toolkitData.basePath}"/>
<c:set var="fieldPath" value="${toolkitData.basePath}.field" />
<c:set var="behaviorPath" value="behavior" />

<div class="accordion_inner">
	<div id="${listPath}_behaviorContent" class="palette_toggle">
		<div>
			<table>
				<thead>
					<tr>
						<th>Type</th>
						<th>Title</th>
					</tr>
				</thead>
				<tbody class="behaviorContainer" id="${param.artifactId}_behaviorContainer">
					<c:forEach var="index" begin="1" step="1" end="${tk:getCount(toolkitData, behaviorPath)}">
						<jsp:setProperty property="currentIndex" name="toolkitData" value="${index - 1}"/>
						<jsp:include page="behavior.jsp" >
							<jsp:param name="basePath" value="${behaviorPath}"/>
						</jsp:include>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>