<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="titlePath" value="${path}.@title"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="descriptionPath" value="${path}.@description"/>
<c:set var="userActionPath" value="${path}.@userAction"/>
<c:set var="evenOddClass" value="${tk:getEvenOddClass(toolkitData.currentIndex)}"/>
<c:set var="fieldValue" value="${tk:getFieldValue(toolkitData,idPath,'newID')}"/>
<c:set var="deletePath" value="${path}.@delete"/>
<c:set var="deleteValue" value="${tk:getFieldValue(toolkitData, deletePath, '')}"/>
<c:set var="styleValue" value=""/>
<c:if test="${deleteValue eq 'true'}">
	<c:set var="styleValue" value="display:none"/>
</c:if>

<tr class="formRow paletteRow executeWhen " id="${path}_wrapperDiv" style="${styleValue}">
	<td>
		<span>
			<input type="hidden" id="${path}.@delete" name="${path}.@delete" value="${deleteValue}"/>
			<input type="text" title="${fieldValue}" name="${idPath}" id="${idPath}" size="20" value="${fieldValue}" class=""/>
		</span>
	</td>
	<td>
		<span>
			<input type="text" size="20" class="autocomplete required" value="${tk:getFieldValue(toolkitData,userActionPath,'')}" id="${userActionPath}" name="${userActionPath}"/>
		</span>
	</td>
	<td class="executeWhenDelete">
		<tkmenu:menuPill id="${path}_deletePill">
			<tkmenu:menuButton id="${path}_delete" title="Delete" text="Delete" classname="deleteRowAction"/>
		</tkmenu:menuPill>
	</td>
</tr>