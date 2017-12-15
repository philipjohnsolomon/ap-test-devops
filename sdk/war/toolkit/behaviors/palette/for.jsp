<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="index" value="${toolkitData.currentIndex}"/>
<c:set var="transactionFieldName" value="${path}.@transaction"/>
<c:set var="pageFieldName" value="${path}.@page"/>
<c:set var="pageElementFieldName" value="${path}.@pageElement"/>
<c:set var="fieldElementFieldName" value="${path}.@fieldElement"/>
<c:set var="deletePath" value="${path}.@delete"/>
<c:set var="deleteValue" value="${tk:getFieldValue(toolkitData, deletePath, '')}"/>
<c:set var="styleValue" value=""/>
<c:if test="${deleteValue eq 'true'}">
	<c:set var="styleValue" value="display:none"/>
</c:if>
<tr class="forPaletteRow paletteRow load_event <c:if test="${param.index %2 != 0}">odd</c:if>" id="${path}_wrapperDiv" style="${styleValue}">

	<td class="inversion">
		<span>
			<input type="hidden" id="${path}.@delete" name="${path}.@delete" value="${deleteValue}" class="forDeleteField"/>
			<select id="${transactionFieldName}_inversion" name="${transactionFieldName}_inversion" class="pageEntityList_event change_event inversion">
				<c:out value="${PAGEENTITYDATA.transactionInversion}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="forKey">
 		<span>
			<select id="${transactionFieldName}" name="${transactionFieldName}" class="pageEntityList_event change_event">
				<c:out value="${PAGEENTITYDATA.transactions}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="inversion">
		<span>
			<select id="${pageFieldName}_inversion" name="${pageFieldName}_inversion" class="pageEntityList_event inversion change_event">
				<c:out value="${PAGEENTITYDATA.pageInversion}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="forKey">
 		<span>
			<select id="${pageFieldName}" name="${pageFieldName}" class="pageEntityList_event change_event" />
				<c:out value="${PAGEENTITYDATA.pages}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="inversion">
		<span>
			<select id="${pageElementFieldName}_inversion" name="${pageElementFieldName}_inversion" class="pageEntityList_event inversion change_event">
				<c:out value="${PAGEENTITYDATA.pageElementInversion}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="forKey">
 		<span>
			<select id="${pageElementFieldName}" name="${pageElementFieldName}" class="pageEntityList_event change_event"/>
				<c:out value="${PAGEENTITYDATA.pageElements}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="inversion">
		<span>
			<select id="${fieldElementFieldName}_inversion" name="${fieldElementFieldName}_inversion" class="pageEntityList_event inversion change_event">
				<c:out value="${PAGEENTITYDATA.fieldElementInversion}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
 	<td class="forKey">
 		<span>
			<select id="${fieldElementFieldName}" name="${fieldElementFieldName}" class=""/>
				<c:out value="${PAGEENTITYDATA.fieldElements}" escapeXml="false"/>
			</select>
 		</span>
 	</td>
	<td class="forActions">
		<tkmenu:menuPill id="${path}_deletePill">
			<tkmenu:menuButton id="${path}_delete" title="Delete" text="Delete" classname="deleteRowAction forDelete"/>
		</tkmenu:menuPill>
	</td>
</tr>