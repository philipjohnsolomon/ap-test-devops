<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<c:set var="negatePath" value="${toolkitData.basePath}.@negate"/>
<c:set var="negate" value="${tk:getFieldValue(toolkitData, negatePath, '')}"/>
<c:set var="conditionPath" value="${toolkitData.basePath}.operator.@type"/>

<c:set var="operator" value="${tk:getFieldValue(toolkitData, conditionPath, '')}"/>

<tk:basePalette path="${param.path}">
	<input type="hidden" class="path" value="${conditionPath}" />

	<tk:tabs path="${conditionPath}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${conditionPath}_operator"></tk:tab>
	</tk:tabs>

	<c:if test="${negate}">
		<c:set var="operator" value="${negate}|${operator}"/>
	</c:if>

	<tk:tabContent tabName="Options" path="${conditionPath}">
			<tk:select path="${conditionPath}"
				label="Operator"
				elementName=""
				required="*"
				helptext="xarc_helptext|operator"
				className="operator operator_editor change_event accordion_update">
				<c:out value="${tk:getOptionListHTML('xarcOperators', operator, '')}" escapeXml="false"/>
			</tk:select>
			<input id="${conditionPath}.@content" name="${conditionPath}"  type="hidden" value="${operator}" />
			<input id="${conditionPath}.@negate" name="${negatePath}"  type="hidden" value="${negate}" />
	</tk:tabContent>
</tk:basePalette>
