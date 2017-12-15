<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="validationTypePath" value="${path}.@type"/>
<c:set var="validationTypeValue" value="${tk:getFieldValue(toolkitData, validationTypePath, param.type)}"/>
<c:set var="displayValue" value="${tk:getOptionListDisplayText('behaviorValidation',validationTypeValue,'')}"/>
<c:set var="deletePath" value="${path}.@delete"/>
<c:set var="deleteValue" value="${tk:getFieldValue(toolkitData, deletePath, '')}"/>
<c:set var="styleValue" value=""/>
<c:if test="${deleteValue eq 'true'}">
	<c:set var="styleValue" value="display:none"/>
</c:if>

<tr id="${path}_wrapperDiv" class="formRow paletteRow validation" style="${styleValue}">
	<td class="validation_cell">

		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="${deleteValue}"/>
		<input type="hidden" name="${validationTypePath}" id="${validationTypePath}" value="${validationTypeValue}"/>
		${displayValue}
	</td>
	<td class="validation_option_event" id="${path}_option">
		<tkmenu:menuPill id="${path}_viewPill">
			<tkmenu:menuButton id="${path}_editValidation" title="View" text="View" classname="editAction"/>
		</tkmenu:menuPill>
	</td>
	<td class="action">
		<tkmenu:menuPill id="${path}_deletePill">
			<tkmenu:menuButton id="${path}_delete" title="Delete" text="Delete" classname="deleteRowAction"/>
		</tkmenu:menuPill>
	</td>
</tr>