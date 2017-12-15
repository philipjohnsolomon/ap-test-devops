<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="optionPathIndex" value="${param.path}[${toolkitData.currentIndex}]"/>
<c:set var="optionPathValue" value="${optionPathIndex}.@value"/>
<tr id="${optionPathIndex}_wrapperDiv" class="templateField <c:if test="${toolkitData.currentIndex %2 != 0}">odd</c:if>">
	<td>
		<input type="hidden" name="${optionPathIndex}.@delete" id="${optionPathIndex}.@delete" value="false"></input>
		<input type="text" name="${optionPathIndex}.@order" id="${optionPathIndex}.@order" size="2" maxLength="2" value="${toolkitData.currentIndex}" class="order numeric"></input>
	</td>
	<td>
		<input type="text" name="${optionPathValue}" id="${optionPathValue}" value="${tk:getFieldValue(toolkitData, optionPathValue, '')}" class="field"></input>
	</td>
	<td>
		<input type="text" name="${optionPathIndex}" id="${optionPathIndex}" value="${tk:getFieldValue(toolkitData, optionPathIndex, '')}" class="field"></input>
	</td>
	<td>
		<tkmenu:menuPill id="${optionPathIndex}_fieldPill">
			<tkmenu:menuButton id="${optionPathIndex}_wrapperDiv_delete" title="Delete this Field" text="Delete" classname="solo deleteRowAction"/>
		</tkmenu:menuPill>
	</td>
</tr>