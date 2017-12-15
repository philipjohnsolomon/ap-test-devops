<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="listData" class="com.agencyport.toolkit.data.search.OptionListData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="typePath" value="${path}.@reader"/>
<c:set var="sourcePath" value="${path}.@source"/>
<c:set var="targetPath" value="${path}.@target"/>
<c:set var="listType" value="${listData.types[toolkitData.currentIndex]}"/>
<c:set var="deletePath" value="${path}.@delete"/>
<c:set var="deleteValue" value="${tk:getFieldValue(toolkitData, deletePath, '')}"/>
<c:set var="styleValue" value=""/>
<c:if test="${deleteValue eq 'true'}">
	<c:set var="styleValue" value="display:none"/>
</c:if>

<tr id="${path}" class="formRow paletteRow" style="${styleValue}">
	<td>
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="${deleteValue}"></input>
		${listType}
	</td>

	<c:if test="${listType == 'custom'}">
		<td>
			<input type="text" class="required" name="${sourcePath}" id="${sourcePath}" size="20" value="${listData.sources[toolkitData.currentIndex]}"/>
		</td>
		<td>
			<input type="text" class="required" name="${targetPath}" id="${targetPath}" size="20" value="${listData.targets[toolkitData.currentIndex]}"/>
		</td>
	</c:if>

	<c:if test="${listType != 'custom'}">
		<td>
			<select name="${sourcePath}" id="${sourcePath}" class="change_event optionListRefresh">
				<c:out value="${listData.sources[toolkitData.currentIndex]}" escapeXml="false"/>
			</select>
		</td>
		<td >
			<select name="${targetPath}" id="${targetPath}" class="option_target_event">
				<c:out value="${listData.targets[toolkitData.currentIndex]}" escapeXml="false"/>
			</select>
		</td>
	</c:if>
	<td class="action">
		<tkmenu:menuPill id="${path}_deletePill">
			<tkmenu:menuButton id="${path}_delete" title="Delete" text="Delete" classname="deleteAction"/>
		</tkmenu:menuPill>
	</td>
</tr>