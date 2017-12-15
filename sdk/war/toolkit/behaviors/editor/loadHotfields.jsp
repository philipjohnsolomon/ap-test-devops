<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="listPath" value="${toolkitData.basePath}"/>
<c:set var="fieldPath" value="${toolkitData.basePath}.field" />
<c:set var="hotFieldPath" value="hotField" />

<div class="accordion_inner">
	<div id="${listPath}_hotfieldContent" class="palette_toggle">
		<div>
			<table>
				<thead>
					<tr>
						<th>Transaction</th>
						<th>Page</th>
						<th>Section</th>
						<th>Field</th>
					</tr>
				</thead>
				<tbody class="hotfieldContainer sortable_container" id="${param.artifactId}_hotfieldContainer">
					<c:forEach var="index" begin="1" step="1" end="${tk:getCount(toolkitData, hotFieldPath)}">
						<jsp:setProperty property="currentIndex" name="toolkitData" value="${index-1}"/>
						<jsp:setProperty property="basePath" name="toolkitData" value="hotField[${index-1}]"/>
						<c:set var="HOTFIELDKEY" value="${HOTFIELDKEYS[index-1]}" scope="request"/>
						<jsp:include page="hotfield.jsp" />
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>