<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="typePath" value="${path}.@type"/>
<c:set var="validationsPath" value="${path}.validation"/>
<c:set var="fieldType" value="${tk:getFieldValue(toolkitData, typePath, param.type)}"/>
<c:set var="validationsCount" value="${tk:getCount(toolkitData, validationsPath)}"/>

<table>
	<thead>
		<tr class="paletteRow">
			<th class="header_column">Type</th>
			<th class="header_column">Options</th>
			<th class="header_column header_actions">Actions</th>
		</tr>
	</thead>
	<tbody id="${validationsPath}_container" class="">
		<c:forEach var="index" begin="1" step="1" end="${validationsCount}">
				
			<jsp:setProperty name="toolkitData" property="basePath" value="${validationsPath}[${index-1}]"/>				
			<jsp:include page="validation.jsp" />
			
		</c:forEach>
		<jsp:setProperty name="toolkitData" property="basePath" value="${path}"/>	
	</tbody>
 </table>

