<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="index" value="${toolkitData.currentIndex}"/>
<c:set var="hotFieldPath" value="${toolkitData.basePath}"/>
<c:set var="hotFieldKey" value="${hotFieldPath}.@key"/>

<tr id="${hotFieldPath}" class="palette_toggle needs_palette hotField <c:if test="${toolkitData.currentIndex %2 != 0}">odd</c:if>">
	<td>
		<input type="hidden" id="${hotFieldPath}_type" value="hotfield"/>
		<span title="Transaction" class="dataEntry" id="${hotFieldPath}.@transaction_displayText">
			<c:out value="${HOTFIELDKEY.transactionId}"/>
		</span>
	</td>
	<td>
		<span title="Page" class="dataEntry" id="${hotFieldPath}.@page_displayText">
			<c:out value="${HOTFIELDKEY.pageId}"/>
		</span>
	</td>
	<td>
		<span title="Section" class="dataEntry" id="${hotFieldPath}.@pageElement_displayText">
			<c:out value="${HOTFIELDKEY.pageElementId}"/>
		</span>
	</td>
	<td>
		<span title="Field" class="dataEntry" id="${hotFieldPath}.@fieldElement_displayText">
			<c:out value="${HOTFIELDKEY.fieldElementId}"/>
		</span>
	</td>
</tr>