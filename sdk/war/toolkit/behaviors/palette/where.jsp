<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="index" value="${toolkitData.currentIndex}"/>
<c:set var="returnTypePath" value="${path}.@returnType"/>
<c:set var="preConditionPath" value="${path}.@name"/>
<c:set var="operatorPath" value="${path}.@operator"/>
<c:set var="testValuePath" value="${path}.@testValue"/>
<c:set var="deletePath" value="${path}.@delete"/>
<c:set var="deleteValue" value="${tk:getFieldValue(toolkitData, deletePath, '')}"/>
<c:set var="styleValue" value=""/>
<c:if test="${deleteValue eq 'true'}">
	<c:set var="styleValue" value="display:none"/>
</c:if>
<tr id="${path}_wrapperDiv" class="wherePaletteRow paletteRow" style="${styleValue}">
	<td class="wherePreconditionName">
		<select id="${returnTypePath}" name="${returnTypePath}" class="returnTypePath">
			<c:out value="${WHEREDATA.returnTypeListHTML}" escapeXml="false"/>
		</select>
	</td>
	<td class="wherePreconditionName">
		<input type="hidden" id="${path}.@delete" name="${path}.@delete" value="${deleteValue}"/>
		<input type="text" class="autocomplete preCondition required" value="${WHEREDATA.name}" id="${preConditionPath}" name="${preConditionPath}"/>
	</td>
	<td class="wherePreconditionTest">
		<select id="${operatorPath}" name="${operatorPath}" class="whereClause">
			<c:out value="${WHEREDATA.operatorListHTML}" escapeXml="false"/>
		</select>
	</td>
	<td class="wherePreconditionTest">
		<input type="text" class="whereClause" value="${WHEREDATA.testValue}" id="${testValuePath}" name="${testValuePath}"/>
	</td>
	<td class="wherePreconditionActions">
		<tkmenu:menuPill id="${path}_deletePill">
			<tkmenu:menuButton id="${path}_delete" title="Delete" text="Delete" classname="deleteRowAction"/>
		</tkmenu:menuPill>
	</td>
</tr>