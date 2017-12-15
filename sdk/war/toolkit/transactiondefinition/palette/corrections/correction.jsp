<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="typePath" value="${path}.@type"/>
<c:set var="typeValue" value="${tk:getFieldValue(toolkitData, typePath, param.type)}"/>
<c:set var="displayValue" value="${tk:getOptionListDisplayText('correctionTypes',typeValue,'')}"/>
<c:set var="deletePath" value="${path}.@delete"/>
<c:set var="deleteValue" value="${tk:getFieldValue(toolkitData, deletePath, '')}"/>
<c:set var="styleValue" value=""/>
<c:if test="${deleteValue eq 'true'}">
	<c:set var="styleValue" value="display:none"/>
</c:if>

<tr class="formRow paletteRow correction" id="${path}_wrapperDiv" style="${styleValue}">
	<td class="correctionCell">

		<input type="hidden" id="${path}.@delete" name="${path}.@delete" value="${deleteValue}"/>
		<input type="hidden" id="${path}.@type"  name="${path}.@type" value="${typeValue}"/>
		${displayValue}
	</td>
	<td class="correctionOption" id="${path}>_option">
		<tkmenu:menuPill id="${path}_viewPill">
			<tkmenu:menuButton id="${path}_editCorrection" title="View" text="View" classname="editAction"/>
		</tkmenu:menuPill>
	</td>
	<td class="action">
		<tkmenu:menuPill id="${path}_deletePill">
			<tkmenu:menuButton id="${path}_delete" title="Delete" text="Delete" classname="deleteRowAction"/>
		</tkmenu:menuPill>
	</td>
</tr>