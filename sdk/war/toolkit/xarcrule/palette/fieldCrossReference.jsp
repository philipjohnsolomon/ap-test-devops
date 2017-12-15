<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="path" value="${param.path}"/>
<c:set var="transactionFieldName" value="${path}.@transactionKey"/>
<c:set var="pageFieldName" value="${path}.@pageKey"/>
<c:set var="pageElementFieldName" value="${path}.@pageElementKey"/>
<c:set var="fieldElementFieldName" value="${path}.@fieldKey"/>

<c:set var="PAGEENTITYDATA" value="${OPERAND.pageEntityData}" />
<c:if test="${fn:contains(path,'expressionOperand')}">
	<c:set var="PAGEENTITYDATA" value="${OPERAND.expression.operands[toolkitData.currentIndex].pageEntityData}" />
</c:if>


<div id="${param.path}_formRow" class="operand" style="${param.hidden}">
	<tk:select path="${transactionFieldName}" label="Transaction" required="*" helptext="xarc_helptext|transactionText" className="${param.className} pageEntityList_event ">
		<c:out value="${PAGEENTITYDATA.transactions}" escapeXml="false"/>
	</tk:select>

	<tk:select path="${pageFieldName}" label="Page" required="*" helptext="xarc_helptext|pageText" className="${param.className} pageEntityList_event ">
		<c:out value="${PAGEENTITYDATA.pages}" escapeXml="false"/>
	</tk:select>

	<tk:select path="${pageElementFieldName}" label="FieldSet" required="*" helptext="xarc_helptext|fieldsetText" className="${param.className} pageEntityList_event ">
		<c:out value="${PAGEENTITYDATA.pageElements}" escapeXml="false"/>
	</tk:select>

	<tk:select path="${fieldElementFieldName}" elementName="" label="Field" required="*" helptext="xarc_helptext|fieldText" className="${param.className} pageEntityList_event accordion_update ">
		<c:out value="${PAGEENTITYDATA.fieldElements}" escapeXml="false"/>
	</tk:select>
	<span>
		<input type="hidden" id="${fieldElementFieldName}.@content" class="resetValue" name="${fieldElementFieldName}" value="${tk:getFieldValue(toolkitData,fieldElementFieldName,'')}" />
		<input type="hidden" id="${param.path}" class="resetValue" name="${param.path}" value="${tk:getFieldValue(toolkitData,param.path,'')}" />
	</span>
</div>
