<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="additionalPath" value="${toolkitData.basePath}[${toolkitData.currentIndex}]"/>
<c:set var="additionalFieldPath" value="${additionalPath}.@name"/>
<c:set var="additionalFieldName" value="${tk:getFieldValue(toolkitData,additionalFieldPath,'')}"/>
<c:set var="evenOddClass" value="${tk:getEvenOddClass(toolkitData.currentIndex)}"/>

<tr id="${additionalPath}_wrapperDiv" class="${evenOddClass}">
	<td>
		<input type="hidden" name="${additionalPath}.@delete" id="${additionalPath}.@delete" value=""></input>
		<input type="hidden" id="${additionalPath}_type" value="additionalFieldToShred"/>
		<input type="text" name="${additionalFieldPath}" class="autocomplete additionalFieldToShred" id="${additionalFieldPath}" value="${additionalFieldName}"/>
	</td>
	<td>
		<tkmenu:menuPill id="${additionalPath}_fieldPill">
			<tkmenu:menuButton id="${additionalPath}_delete" title="Delete this Field" text="Delete" classname="solo deleteRowAction"/>
		</tkmenu:menuPill>
	</td>
</tr>