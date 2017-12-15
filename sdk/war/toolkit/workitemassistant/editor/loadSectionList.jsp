<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="listPath" value="${toolkitData.basePath}"/>
<c:set var="rolePath" value="${toolkitData.basePath}.role" />
<c:set var="filePath" value="${toolkitData.basePath}.codeListRef" />
<c:set var="typePath" value="${listPath}.@type"/>
<c:set var="fileTypeValue" value="${tk:getFieldValue(toolkitData, typePath,'')}"/>

 <div class="accordion_inner">
		<tk:tabs path="${listPath}">
			<tk:tab tabName="Roles" focusOnLoad="true" path="${rolePath}"></tk:tab>
		  	<c:if test="${fileTypeValue == 'fileAttachment'}">
				<tk:tab tabName="Document Type" focusOnLoad="false" path="${filePath}"></tk:tab>
		 	</c:if>
		</tk:tabs>
		<tk:tabContent tabName="Roles" path="${rolePath}">
			<div id="${listPath}_content_roles" class="">
			   <div class="rule_sub_container_actions">
					<jsp:include page="../menu/addSectionEntry.jsp">	
						<jsp:param name="path" value="${rolePath}"></jsp:param>
						<jsp:param name="label" value="New Role"></jsp:param>
						<jsp:param name="action" value="addRole"></jsp:param>
					</jsp:include>
				</div>		
				<div id="${listPath}_roles">
					<table>
						<thead>
							<tr>
								<th>Role Names</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody id="${rolePath}_fields_container" >
							<c:forEach var="fieldIndex" begin="1" step="1" end="${tk:getCount(toolkitData, rolePath)}">
								<tk:setBeanContext index="${fieldIndex-1}" path="${rolePath}"/>								
								<jsp:include page="roleFields.jsp">
				 					<jsp:param name="path" value="${rolePath}"></jsp:param>
								</jsp:include>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</tk:tabContent>
		<c:if test="${fileTypeValue == 'fileAttachment'}">
			<tk:tabContent tabName="Document Type" path="${filePath}" styleValue="display:none;">
				<div id="${listPath}_content_filetype" class="">
				    <div class="rule_sub_container_actions">
						<jsp:include page="../menu/addSectionEntry.jsp">	
							<jsp:param name="path" value="${filePath}"></jsp:param>
							<jsp:param name="label" value="New Value"></jsp:param>
							<jsp:param name="action" value="addFileType"></jsp:param>
						</jsp:include>
					</div>		
					<div id="${listPath}_filetypes">
						<table>
							<thead>
								<tr>
									<th>Collection</th>
									<th>List</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody id="${filePath}_fields_container" >
								<c:forEach var="fieldIndex" begin="1" step="1" end="${tk:getCount(toolkitData, filePath)}">
									<jsp:setProperty property="currentIndex" name="toolkitData" value="${fieldIndex - 1}"/>
									<jsp:include page="fileFields.jsp">
				 						<jsp:param name="path" value="${filePath}"></jsp:param>
									</jsp:include>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</tk:tabContent>
	</c:if>
</div>

