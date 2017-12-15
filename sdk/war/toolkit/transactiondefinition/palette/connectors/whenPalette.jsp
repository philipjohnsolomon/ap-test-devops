<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="endIndex" value="${fn:indexOf(path, '.instruction')}" />
<c:set var="connectorsPath" value="${fn:substring(path, 0, endIndex)}" />
<c:set var="connectorsCountPath" value="${connectorsPath}.connector" />
<c:set var="connectorsCount" value="${tk:getCount(toolkitData,connectorsCountPath)}" />

<div id="${path}_tableContainer" class="selectlists scrollTable when">
	<table>
		<thead>
			<tr id="whenPaletteRow paletteRow">
				<th></th>
				<th>ID</th>
				<th>Title</th>
				<th>Type</th>
			</tr>
		</thead>
		<tbody>							
			<c:forEach var="index" begin="1" step="1" end="${connectorsCount}">
			
				<c:set var="connectorPath" value="${connectorsCountPath}[${index-1}]"/>
				<c:set var="connectorIdPath" value="${connectorPath}.@id"/>	
				<c:set var="connectorTitlePath" value="${connectorPath}.@title"/>	
				<c:set var="connectorTypePath" value="${connectorPath}.@type"/>
				<c:set var="connectorIdValue" value="${tk:getFieldValue(toolkitData,connectorIdPath,'')}"/>
				<c:set var="connectorTitleValue" value="${tk:getFieldValue(toolkitData,connectorTitlePath,connectorTitlePath)}"/>	
				<c:set var="connectorTypeValue" value="${tk:getFieldValue(toolkitData,connectorTypePath,connectorTypePath)}"/>	
				<c:set var="checked" value="false"/>
					
				<c:if test="${fn:contains(whenConnectors,connectorIdValue)}">
					<c:set var="checked" value="true"/>
				</c:if>	
				<c:set var="checkedType" value="${tk:getCompareValues(checked, 'true', 'checked','')}" />
				<c:set var="checkedValue" value="${tk:getCompareValues(checked, 'true', 'false','true')}" />
				
			 	<tr id="whenPaletteRow paletteRow">
					<td id="${connectorPath}_selectCell" class="checkBoxCell">
						<input class="checkbox change_event validateCheckBoxGroup" type="checkbox" ${checkedType} id="${path}.when[@connector='${connectorIdValue}'].@connector" name="" value="${connectorIdValue}"/>
						<input class="hidden" type="hidden" id="${path}.when[@connector='${connectorIdValue}'].@delete" name="${path}.when[@connector='${connectorIdValue}'].@delete" value="${checkedValue}"/>
					</td>
					<td id="${connectorPath}_idCell">
						<span id="${connectorPath}_id">${connectorIdValue}</span>
					</td>
					<td id="${connectorPath}_titleCell">
						<span id="${connectorPath}_title">${connectorTitleValue}</span>
					</td>
					<td id="${connectorPath}_typeCell">
						<span id="${connectorPath}_type">${connectorTypeValue}</span>
					</td>
				<tr>
			</c:forEach>
		</tbody>		
	</table>		
</div>