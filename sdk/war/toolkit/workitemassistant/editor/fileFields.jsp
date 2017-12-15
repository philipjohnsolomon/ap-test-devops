<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="optionPathIndex" value="${param.path}[${toolkitData.currentIndex}]"/>
<c:set var="optionPathValue" value="${optionPathIndex}"/>
<c:set var="fileSourcePath" value="${optionPathIndex}.@source" />
<c:set var="fileTargetPath" value="${optionPathIndex}.@target" />
<c:set var="currentOption" value="${tk:getFieldValue(toolkitData, fileSourcePath, '')}" />
<c:set var="currentTarget" value="${tk:getFieldValue(toolkitData, fileTargetPath, '')}" />
<tr id="${optionPathIndex}_wrapperDiv" class="templateField <c:if test="${toolkitData.currentIndex %2 != 0}">odd</c:if>">

	<input type="hidden" name="${optionPathIndex}.@delete" id="${optionPathIndex}.@delete" value="false"></input>

	<td>
		<select name="${fileSourcePath}" id="${fileSourcePath}" class="required change_event select_list_change workitem_assistant_file_attachment_type">
			<c:out value="${tk:getCodeListOptionsHTML(toolkitData, currentOption)}" escapeXml="false"/>
		</select>
	</td>
	<td>
		<select name="${fileTargetPath}" id="${fileTargetPath}" class="required change_event select_list_change workitem_assistant_file_attachment_type">
			<c:out value="${tk:getCodeListOptionsTargetHTML(toolkitData, currentOption, currentTarget)}" escapeXml="false"/>
		</select>
	</td>
	<td>
		<tkmenu:menuPill id="${optionPathIndex}_fieldPill">
			<tkmenu:menuButton id="${optionPathIndex}_wrapperDiv_delete" title="Delete this Field" text="Delete" classname="solo deleteRowAction"/>
		</tkmenu:menuPill>
	</td>
</tr>