<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="hotFieldPath" value="${toolkitData.basePath}"/>
<c:set var="transactionFieldName" value="${hotFieldPath}.@transaction"/>
<c:set var="pageFieldName" value="${hotFieldPath}.@page"/>
<c:set var="pageElementFieldName" value="${hotFieldPath}.@pageElement"/>
<c:set var="fieldElementFieldName" value="${hotFieldPath}.@fieldElement"/>
<c:set var="deletePath" value="${hotFieldPath}.@delete"/>
<c:set var="deleteValue" value="${tk:getFieldValue(toolkitData, deletePath, '')}"/>
<c:set var="styleValue" value=""/>
<c:if test="${deleteValue eq 'true'}">
	<c:set var="styleValue" value="display:none"/>
</c:if>
<tr id="${hotFieldPath}_wrapperDiv" class="refreshListPaletteRow paletteRow <c:if test="${toolkitData.currentIndex % 2 != 0}">odd</c:if>" style="${styleValue}">
	<td class="inversion">
		<span>
			<input type="hidden" id="${hotFieldPath}.@delete" name="${hotFieldPath}.@delete" value="${deleteValue}"/>
			<select id="${transactionFieldName}_inversion" name="${transactionFieldName}_inversion" class="pageEntityList_event change_event inversion">
				<c:out value="${PAGEENTITYDATA.transactionInversion}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="refreshListKey">
 		<span>
			<select id="${transactionFieldName}" name="${transactionFieldName}" class="pageEntityList_event change_event required">
				<c:out value="${PAGEENTITYDATA.transactions}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="inversion">
		<span>
			<select id="${pageFieldName}_inversion" name="${pageFieldName}_inversion" class="pageEntityList_event change_event inversion">
				<c:out value="${PAGEENTITYDATA.pageInversion}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="refreshListKey">
 		<span>
			<select id="${pageFieldName}" name="${pageFieldName}" class="pageEntityList_event change_event required"/>
				<c:out value="${PAGEENTITYDATA.pages}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="inversion">
		<span>
			<select id="${pageElementFieldName}_inversion" name="${pageElementFieldName}_inversion" class="pageEntityList_event change_event inversion">
				<c:out value="${PAGEENTITYDATA.pageElementInversion}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="refreshListKey">
 		<span>
			<select id="${pageElementFieldName}" name="${pageElementFieldName}" class="pageEntityList_event change_event required"/>
				<c:out value="${PAGEENTITYDATA.pageElements}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="inversion">
		<span>
			<select id="${fieldElementFieldName}_inversion" name="${fieldElementFieldName}_inversion" class="refreshListKey inversion">
				<c:out value="${PAGEENTITYDATA.fieldElementInversion}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="refreshListKey">
 		<span>
			<select id="${fieldElementFieldName}" name="${fieldElementFieldName}" class="refreshListKey required"/>
				<c:out value="${PAGEENTITYDATA.fieldElements}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="selectionHint">
 		<span>
 			<select id="${hotFieldPath}.@selectionHint" name="${hotFieldPath}.@selectionHint">
 				<c:set var="selectionHintPath" value="${hotFieldPath}.@selection"/>
 				<c:set var="selectionHintPathValue" value="${tk:getFieldValue(toolkitData, selectionHintPath, '')}"/>
 				<c:out value="${tk:getOptionsHTML(toolkitData,'refreshListSelectionHint',selectionHintPathValue,'')}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
	<td class="refreshListActions">
		<tkmenu:menuPill id="${hotFieldPath}_deletePill">
			<tkmenu:menuButton id="${hotFieldPath}_delete" title="Delete" text="Delete" classname="deleteRowAction"/>
		</tkmenu:menuPill>
	</td>
</tr>