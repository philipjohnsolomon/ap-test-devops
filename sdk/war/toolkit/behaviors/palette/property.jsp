<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="propertyPath" value="${toolkitData.basePath}"/>
<c:set var="namePath" value="${propertyPath}.@name"/>
<c:set var="deletePath" value="${propertyPath}.@delete"/>
<c:set var="deleteValue" value="${tk:getFieldValue(toolkitData, deletePath, '')}"/>
<c:set var="styleValue" value=""/>
<c:if test="${deleteValue eq 'true'}">
	<c:set var="styleValue" value="display:none"/>
</c:if>

<c:if test="${not empty PROPERTY_NAME}">
	<c:set var="nameValue" value="${PROPERTY_NAME}"/>
</c:if>

<c:if test="${empty PROPERTY_NAME}">
	<c:set var="nameValue" value="${tk:getFieldValue(toolkitData,namePath,'')}"/>
</c:if>

<tr id="${propertyPath}_wrapperDiv" class="propertyPaletteRow paletteRow <c:if test="${toolkitData.currentIndex %2 != 0}">odd</c:if>" style="${styleValue}">
	<td class="propName">
		<span>
			<input type="hidden" id="${propertyPath}.@delete" name="${propertyPath}.@delete" value="${deleteValue}" class="deleteProperty"/>
			${nameValue}
		</span>
	</td>
	<td class="propActions">
		<tkmenu:menuPill id="${propertyPath}_editPill">
			<tkmenu:menuButton id="${propertyPath}_editProperty" title="Edit" text="Edit" classname="editAction"/>
		</tkmenu:menuPill>
	</td>
	<td class="propActions">
		<tkmenu:menuPill id="${propertyPath}_deletePill">
			<tkmenu:menuButton id="${propertyPath}_delete" title="Delete" text="Delete" classname="deleteRowAction"/>
		</tkmenu:menuPill>
	</td>
</tr>
