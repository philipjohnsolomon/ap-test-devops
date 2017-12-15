<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="behaviorPath" value="behavior[${toolkitData.currentIndex}]"/>
<c:set var="behaviorAction" value="${behaviorPath}.do.@action"/>
<c:set var="behaviorTitle" value="${behaviorPath}.@title"/>
<c:set var="pathId" value="${behaviorPath}.@id"/>
<c:set var="pathIdValue" value="${tk:getFieldValue(toolkitData, pathId, '')}"/>

<tr id="${behaviorPath}" class="palette_toggle behavior <c:if test="${toolkitData.currentIndex %2 != 0}">odd</c:if>">
	<td>
		<input type="hidden" id="${behaviorPath}_type" value="behavior"/>
		<span title="${tk:getFieldValue(toolkitData,behaviorAction,'include')}" class="dataEntry" id="${behaviorAction}_displayText">${tk:getFieldValue(toolkitData,behaviorAction,'include')}</span>
	</td>
	<td>
		<span title="${tk:getFieldValue(toolkitData,behaviorTitle,pathIdValue)}" class="dataEntry" id="${behaviorTitle}_displayText">${tk:getFieldValue(toolkitData,behaviorTitle,pathIdValue)}</span>
	</td>
</tr>