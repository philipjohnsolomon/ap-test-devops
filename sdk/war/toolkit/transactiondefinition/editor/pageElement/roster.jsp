<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>

<div class="standardForm">
	<table class="roster_editor">
		<thead>
			<tr>
				<th>Joins</th>
				<th>Columns</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="join_info_container_td">
					<div>
						<table>
						<tr  id="${param.path}.joinInfo_container">
							
								<td class="hidden"><input type="hidden" class="_childClassName" value="joinInfo"/></td>
								
								<c:set var="joinInfoPath" value="${param.path}.joinInfo"/>
								<c:set var="joinInfoCount" value="${tk:getCount(toolkitData, joinInfoPath)}"/>
								<c:if test="${joinInfoCount != 0}">
									<c:forEach var="index" begin="0" step="1" end="${joinInfoCount - 1}">
										<c:set var="childPath" value="${joinInfoPath}[${index}]"/>
										<jsp:setProperty name="toolkitData" property="basePath" value="${childPath}"/>
										<jsp:include page="../joinInfo.jsp"/>
									</c:forEach>
								</c:if>
								<jsp:setProperty name="toolkitData" property="basePath" value="${basePath}"/>
							</tr>
						</table>
					</div>
				</td>
				<td class="column_container_td">
					<div>
						<%
						// the class name of child JSP snippets
						%>
						<table>
							<tr id="${param.path}.fieldElement_container">

								<td class="hidden"><input type="hidden" class="_childClassName" value="fieldElement"/></td>

								<c:set var="fieldElementPath" value="${param.path}.fieldElement"/>
								<c:set var="fieldElementCount" value="${tk:getCount(toolkitData, fieldElementPath)}"/>

								<c:forEach var="index" begin="0" step="1" end="${fieldElementCount}">
									<c:set var="typeIndexedPath" value="${fieldElementPath}[${index}].@type"/>
									<c:set var="type" value="${tk:getFieldValue(toolkitData, typeIndexedPath, '')}"/>

									<c:if test="${type == 'hidden'}">
										<c:set var="type" value="${typeValue}Roster"/>
									</c:if>

									<c:if test="${not empty type}">
										<c:set var="jspPage" value="../../editor/${type}.jsp"/>
										<c:set var="fieldElementIndexedPath" value="${fieldElementPath}[${index}]"/>
										<jsp:setProperty name="toolkitData" property="basePath" value="${fieldElementIndexedPath}"/>
										<jsp:include page="${jspPage}"/>
									</c:if>
								</c:forEach>
								<jsp:setProperty name="toolkitData" property="basePath" value="${basePath}"/>
							</tr>
						</table>
					</div>
				</td>
				<c:set var="childPath" value="${param.path}.action"/>
				<jsp:include page="../action.jsp">
					<jsp:param name="path" value="${childPath}"/>
				</jsp:include>
			</tr>
		</tbody>
	</table>
</div>