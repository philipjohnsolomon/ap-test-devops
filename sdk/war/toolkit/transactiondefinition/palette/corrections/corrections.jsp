<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="correctionsPath" value="${path}.correction"/>
<c:set var="correctionCount" value="${tk:getCount(toolkitData, correctionsPath)}"/>

<div class="selectlists scrollTable">
	<table>
		<thead>
			<tr class="paletteRow">
				<th class="header_column">Type</th>
				<th class="header_column">Options</th>
				<th class="header_column">Delete</th>
			</tr>
		</thead>
		<tbody id="${correctionsPath}_container">
			<c:forEach var="index" begin="1" step="1" end="${correctionCount}">	
				<jsp:setProperty name="toolkitData" property="basePath" value="${correctionsPath}[${index-1}]"/>	
				<jsp:include page="correction.jsp"/>		
			</c:forEach>
			<jsp:setProperty name="toolkitData" property="basePath" value="${path}"/>	
		</tbody>
	</table>
</div>		
	  					
	
 
