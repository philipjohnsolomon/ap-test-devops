<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="variablePath" value="${param.path}[${toolkitData.currentIndex}]" />
<c:set var="variableNamePath" value="${variablePath}.@name" />
<c:set var="variableName" value="${tk:getFieldValue(toolkitData, variableNamePath, 'Unnamed')}"/>
<c:set var="scopePath" value="${variablePath}.@scope" />
<c:set var="variableScope" value="${tk:getFieldValue(toolkitData, scopePath, 'Local')}"/>

<c:if test="${variableScope!='Local'}">
	<c:set var="variableScope" value="${tk:getOptionListDisplayText('xarcVariableScope',variableScope, '')}" />
</c:if>

<c:set var="evenOddClass" value="${tk:getEvenOddClass(toolkitData.currentIndex)}"/>

<tr id="${variablePath}" class="${evenOddClass} variable_tr palette_toggle needs_palette">
	<td>
		<div class="input_container">
			<span>
				<input type="text" id="${variablePath}.@order" name="${variablePath}.@order" size="2" maxlength="2" value="${toolkitData.currentIndex}" class="order numeric"/>
			</span>
		</div>
	</td>
	<td>
		<span>
			<input type="hidden" id="${variablePath}_type" value="variable" />
		</span>
		<span>
			<span id="${variableNamePath}_displayText" class="displayText">
				${variableName}
			</span>
		</span>
	</td>
	<td>
		<span>
			<span id="${variablePath}.@scope_displayText" class="displayText">${variableScope}</span>
		</span>
	</td>
</tr>