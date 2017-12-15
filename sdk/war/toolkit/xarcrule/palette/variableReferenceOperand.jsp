<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="variableScopePath" value="${param.path}.@scope"/>
<c:set var="variableScope" value="${tk:getFieldValue(toolkitData, variableScopePath, '')}"/>
<c:set var="variableRefValue" value="${tk:getFieldValue(toolkitData, param.path, '')}"/>
<c:set var="classes" value="${param.className}"/>

<c:set var="VARIABLEOPERAND" value="${OPERAND}" />
<c:if test="${fn:contains(param.path,'expressionOperand')}">
	<c:set var="VARIABLEOPERAND" value="${OPERAND.expression.operands[toolkitData.currentIndex]}" />
</c:if>

<c:if test="${(not empty param.required) && (param.required=='*')}">
	<c:set var="classes" value="${param.className} required"/>
</c:if>

<c:set var="help" value="${tk:getOptionsListValue('xarc_helptext', 'variable')}"></c:set>

<div id="${param.path}_formRow" class="formRow" style="${param.hidden}">
	<label class="label" id="${param.path}_labelElement" for="${param.path}">
		<span id="${param.path}_required">${param.required}</span>
		<span id="${param.path}_labelText">
			<tk:helpText helptext="${helptext}" helpDescription="${help}">
					${param.label}
			</tk:helpText>
		</span>
	</label>
	<span>
		<select id="${param.path}" class="${classes} variableReference_event">
			${VARIABLEOPERAND.variableReferenceOptionList}
		</select>
	</span>
		<input id="${variableScopePath}" name="${variableScopePath}" class="resetValue" type="hidden" value="${variableScope}" />
		<input id="${param.path}.@content" name="${param.path}"  class="resetValue" type="hidden" value="${variableRefValue}" />
</div>