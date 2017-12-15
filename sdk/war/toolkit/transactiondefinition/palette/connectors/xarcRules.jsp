<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="xarcListData" class="com.agencyport.toolkit.data.search.OptionListData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="ruleIdPath" value="${path}.@ruleId"/>
<c:set var="ruleId" value="${tk:getFieldValue(toolkitData, ruleIdPath, '')}"/>
<c:set var="ruleLibraryId" value="${path}.@ruleLibraryId"/>
<c:set var="ruleLibrary" value="${tk:getFieldValue(toolkitData, ruleLibraryId, '')}"/>
<c:set var="evenOddClass" value="${tk:getEvenOddClass(toolkitData.currentIndex)}"/>
<c:set var="deletePath" value="${path}.@delete"/>
<c:set var="deleteValue" value="${tk:getFieldValue(toolkitData, deletePath, '')}"/>
<c:set var="styleValue" value=""/>
<c:if test="${deleteValue eq 'true'}">
	<c:set var="styleValue" value="display:none"/>
</c:if>

<tr class="xarcRules paletteRow ${evenOddClass}" id="${path}" style="${styleValue}">

	<td class="xarcRulesId">
		<tk:input path="${idPath}"
			label="ID"
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'newID')}"
			required=""
			defaultValue=""
			className="idCharacters"
			size="20">
		</tk:input>
	</td>
	<td class="xarcRulesRuleLibraryId">
		<select id="${ruleLibraryId}" name="${ruleLibraryId}" class="change_event refreshXarcRulesList">
			<c:out value="${xarcListData.sources[toolkitData.currentIndex]}" escapeXml="false"/>
		</select>
	</td>
	<td class="xarcRulesRuleId">
		<select id="${ruleIdPath}" name="${ruleIdPath}">
			<c:out value="${xarcListData.targets[toolkitData.currentIndex]}" escapeXml="false"/>
		</select>
	</td>
	<td class="xarcRulesDelete">
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="${deleteValue}" />
		<tkmenu:menuPill id="${path}_deletePill">
			<tkmenu:menuButton id="${path}_delete" title="Delete" text="Delete" classname="deleteAction"/>
		</tkmenu:menuPill>
	</td>
</tr>