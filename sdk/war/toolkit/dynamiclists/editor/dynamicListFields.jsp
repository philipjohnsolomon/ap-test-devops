<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="fieldPath" value="${param.path}[${toolkitData.currentIndex}]"/>
<c:set var="fieldValue" value="${tk:getFieldValue(toolkitData,fieldPath,'')}"/>
<c:set var="fieldTypePath" value="${fieldPath}.@type"/>
<c:set var="fieldTypeValue" value="${tk:getFieldValue(toolkitData,fieldTypePath,'')}"/>

<tr id="${fieldPath}_wrapperDiv" class="templateField <c:if test="${param.index %2 == 0}">even</c:if>" >
	<td>
		<input type="hidden" name="${fieldPath}.@delete" id="${fieldPath}.@delete" value=""></input>
		<select name="${fieldTypePath}" id="${fieldTypePath}" class="required change_event select_list_change">
			<c:out value="${tk:getOptionsHTML(toolkitData,'dynamicListFieldType',fieldTypePath,'')}" escapeXml="false"/>
		</select>
	</td>
	<td>
		<input type="text" name="${fieldPath}" id="${fieldPath}" value="${fieldValue}" class="autocomplete field"></input>
	</td>
	<td>
		<tkmenu:menuPill id="${fieldPath}_fieldPill">
			<tkmenu:menuButton id="${fieldPath}_wrapperDiv_delete" title="Delete this Field" text="Delete" classname="solo deleteRowAction"/>
		</tkmenu:menuPill>
	</td>
</tr>

<!-- Need to add function that would compare 2 string and return 'selected' or blank -->