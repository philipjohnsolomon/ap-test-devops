<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="evenOddClass" value="${tk:getEvenOddClass(toolkitData.currentIndex)}"/>
<c:set var="customConditionPath" value="${toolkitData.basePath}.javaclass"/>
<c:set var="javaclassName" value="${tk:getFieldValue(toolkitData, customConditionPath, 'Select Custom Class')}"/>

<tr id="${toolkitData.basePath}" class="${evenOddClass} conditionTr">
	<td>
		<div class="input_container">
			<span>
				<input type="text" id="${toolkitData.basePath}.@order" name="${toolkitData.basePath}.@order" size="2" maxlength="2" value="${toolkitData.currentIndex}" class="order numeric"/>
				<input type="hidden" id="${toolkitData.basePath}_type" value="customCondition"></input>	
			</span>
		</div>
	</td>
	<td id="${customConditionPath}" colspan="3" class="palette_toggle">
		<span id="${customConditionPath}.@content_displayText" class="displayText">${javaclassName}</span>
		<span>
			<input type="hidden" id="${customConditionPath}.@name" value="Condition" />
			<input type="hidden" id="${customConditionPath}_type" value="customCondition" />
		</span>
	</td>
</tr>