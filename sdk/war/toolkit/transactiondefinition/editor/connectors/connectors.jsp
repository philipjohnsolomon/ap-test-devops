<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="connectorPath" value="${param.path}.connector"/>
<c:set var="instructionPath" value="${param.path}.instruction"/>

<table>
	<thead>
		<tr>
			<th colspan="3" class="super_header">Connectors</th>
		</tr>
		<tr>
			<th>ID</th>
			<th>Title</th>
			<th>Type</th>
		</tr>
	</thead>
	<tbody class="connectorContainer " id="${param.path}.connector_container">
		<c:set var="connectorCount" value="${tk:getCount(toolkitData, connectorPath)}"/>
		<c:if test="${connectorCount != 0}">
			<c:forEach var="index" begin="0" step="1" end="${connectorCount - 1}">
				<c:set var="connectorIndexedPath" value="${connectorPath}[${index}]"/>
				<c:set var="connectorTypePath" value="${connectorIndexedPath}.@type"/>
				<c:set var="connectorType" value="${tk:getFieldValue(toolkitData, connectorTypePath, '')}"/>
				<c:set var="jspPage" value="connector.jsp"/>
				<jsp:setProperty name="toolkitData" property="basePath" value="${connectorIndexedPath}"/>
				<jsp:include page="${jspPage}">
					<jsp:param name="index" value="${index}"/>
					<jsp:param name="type" value="${connectorType}"/>
				</jsp:include>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<br>
<table>
	<thead>
		<tr>
			<th colspan="3" class="super_header">Instructions</th>
		</tr>
		<tr>
			<th>ID</th>
			<th>Title</th>
			<th>Type</th>
		</tr>
	</thead>
	<tbody class="instructionContainer " id="${param.path}.instruction_container">
		<c:set var="instructionCount" value="${tk:getCount(toolkitData, instructionPath)}"/>
		<c:if test="${instructionCount != 0}">
			<c:forEach var="index" begin="0" step="1" end="${instructionCount - 1}">
				<c:set var="instructionIndexedPath" value="${instructionPath}[${index}]"/>
				<c:set var="instructionTypePath" value="${instructionIndexedPath}.@type"/>
				<c:set var="instructionType" value="${tk:getFieldValue(toolkitData, instructionTypePath, '')}"/>
				<jsp:setProperty name="toolkitData" property="basePath" value="${instructionIndexedPath}"/>
				<c:set var="jspPage" value="instruction.jsp"/>
				<jsp:include page="${jspPage}">
					<jsp:param name="index" value="${index}"/>
					<jsp:param name="path" value="${instructionIndexedPath}"/>
				</jsp:include>
			</c:forEach>
		</c:if>
	</tbody>
</table>