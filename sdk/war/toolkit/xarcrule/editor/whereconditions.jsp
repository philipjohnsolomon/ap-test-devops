<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="evenOddClass" value="${tk:getEvenOddClass(toolkitData.currentIndex)}"/>
<c:set var="conditionPath" value="${param.path}[${toolkitData.currentIndex}]" />
<c:set var="conditionPathClass" value="${conditionPath}.javaclass" />
<c:set var="conditionType" value="condition" />

<c:if test="${not empty param.type}">
	<c:set var="conditionType" value="${param.type}" />
</c:if>

<c:if test="${empty param.type}">
	<c:set var="conditionCounter" value="${tk:getCount(toolkitData,conditionPathClass )}" />
	<c:if test="${conditionCounter > 0}">
		<c:set var="conditionType" value="custom" />
	</c:if>
</c:if>

<c:if test="${conditionType =='custom'}">
	<jsp:setProperty name="toolkitData" property="basePath" value="${conditionPath}"/>
	<jsp:include page="../../xarcrule/editor/customCondition.jsp" />
</c:if>

<c:if test="${conditionType !='custom'}">

	<c:set var="operandPath" value="${conditionPath}.operator.operand" />
	<c:set var="operatorPath" value="${conditionPath}.operator.@type" />
	<c:set var="negatePath" value="${conditionPath}.@negate" />

	<c:set var="operator" value="${tk:getFieldValue(toolkitData, operatorPath, '')}"/>
	<c:set var="negate" value="${tk:getFieldValue(toolkitData, negatePath, '')}"/>
	<c:set var="operatorValue" value="${operator}" />

	<c:if test="${negate =='true'}">
		<c:set var="operatorValue" value="${negate}|${operator}" />
	</c:if>

	<c:set var="operator" value="${tk:getOptionListDisplayText('xarcOperators',operatorValue, operator)}" />

	<c:set var="leftOperandFieldPath" value="${operandPath}[0].field" />
	<c:set var="leftOperandVariablePath" value="${operandPath}[0].variableReference" />
	<c:set var="leftOperandXpathPath" value="${operandPath}[0].xpath" />
	<c:set var="leftOperandExpressionPath" value="${operandPath}[0].expression" />
	<c:set var="leftOperandSqlPath" value="${operandPath}[0].sql" />
	<c:set var="leftOperandDatePath" value="${operandPath}[0].date" />
	<c:set var="leftOperandConstantPath" value="${operandPath}[0].constant" />
	<c:set var="leftOperandType" value="constant" />
	<c:set var="leftOperandValue" value="(Select Field)" />

	<c:choose>
  		<c:when test="${tk:getCount(toolkitData,leftOperandFieldPath ) > 0}" >
   			<c:set var="leftOperandType" value="field"/>
   			<c:set var="fieldKeyPath" value="${leftOperandFieldPath}.@fieldKey"/>
   			<c:set var="compoundKey" value="${tk:getFieldValue(toolkitData, fieldKeyPath, '')}"/>

			<c:if test="${not empty compoundKey}">
				<c:set var="leftOperandValue" value="${tk:getFieldSelectlistText(toolkitData, param.product, param.artifactId, compoundKey)}"/>
				<c:if test="${empty leftOperandValue}">
					<c:set var="leftOperandValue" value="${tk:getFieldValue(toolkitData, leftOperandFieldPath, '')}" />
				</c:if>
			</c:if>
  		</c:when>
  		<c:when test="${tk:getCount(toolkitData,leftOperandVariablePath ) > 0}" >
  			<c:set var="leftOperandType" value="variableReference" />
			<c:set var="varRefValue" value="${tk:getFieldValue(toolkitData, leftOperandVariablePath, '')}"/>
			<c:set var="varRefScopePath" value="${leftOperandVariablePath}.@scope" />
			<c:set var="varRefScope" value="${tk:getFieldValue(toolkitData, varRefScopePath, '')}" />
			<c:set var="varSelectedValue" value="${varRefScope}|${varRefValue}" />
			<c:set var="leftOperandValue" value="${varRefValue}"/>
  		</c:when>
  		<c:when test="${tk:getCount(toolkitData,leftOperandXpathPath ) > 0}" >
  			<c:set var="leftOperandType" value="xpath" />
			<c:set var="leftOperandValue" value="${tk:getFieldValue(toolkitData, leftOperandXpathPath, leftOperandValue)}" />
  		</c:when>
  		<c:when test="${tk:getCount(toolkitData,leftOperandExpressionPath ) > 0}" >
   			<c:set var="leftOperandType" value="expression" />
			<c:set var="leftOperandValue" value="Expression" />
  		</c:when>
  		<c:when test="${tk:getCount(toolkitData,leftOperandSqlPath ) > 0}" >
  			<c:set var="leftOperandType" value="sql" />
			<c:set var="leftOperandValue" value="${tk:getFieldValue(toolkitData, leftOperandSqlPath, leftOperandValue)}" />
  		</c:when>
  		<c:when test="${tk:getCount(toolkitData,leftOperandDatePath ) > 0}" >
   			<c:set var="leftOperandType" value="date" />
			<c:set var="leftOperandValue" value="${tk:getFieldValue(toolkitData, leftOperandDatePath, leftOperandValue)}" />
  		</c:when>
  		<c:otherwise>
  			<c:set var="leftOperandType" value="constant" />
			<c:set var="leftOperandValue" value="${tk:getFieldValue(toolkitData, leftOperandConstantPath, leftOperandValue)}" />
  		</c:otherwise>
	</c:choose>

	<c:set var="rightOperandFieldPath" value="${operandPath}[1].field" />
	<c:set var="rightOperandVariablePath" value="${operandPath}[1].variableReference" />
	<c:set var="rightOperandXpathPath" value="${operandPath}[1].xpath" />
	<c:set var="rightOperandExpressionPath" value="${operandPath}[1].expression" />
	<c:set var="rightOperandSqlPath" value="${operandPath}[1].sql" />
	<c:set var="rightOperandDatePath" value="${operandPath}[1].date" />
	<c:set var="rightOperandConstantPath" value="${operandPath}[1].constant" />
	<c:set var="rightOperandType" value="${leftOperandType}" />
	<c:set var="rightOperandValue" value="(Select Field)" />

	<c:choose>
  		<c:when test="${tk:getCount(toolkitData,rightOperandFieldPath ) > 0}" >
   			<c:set var="rightOperandType" value="field"/>
   			<c:set var="rightOperandPath" value="${rightOperandFieldPath}"/>
   			<c:set var="fieldKeyPath" value="${rightOperandPath}.@fieldKey"/>
   			<c:set var="compoundKey" value="${tk:getFieldValue(toolkitData, fieldKeyPath, '')}"/>
			<c:if test="${not empty compoundKey }">
				<c:set var="rightOperandValue" value="${tk:getFieldSelectlistText(toolkitData, param.product, param.artifactId, compoundKey)}"/>
				<c:if test="${empty  rightOperandValue }">
					<c:set var="rightOperandValue" value="${tk:getFieldValue(toolkitData, rightOperandPath, '')}" />
				</c:if>
			</c:if>
  		</c:when>
  		<c:when test="${tk:getCount(toolkitData,rightOperandVariablePath ) > 0}" >
  			<c:set var="rightOperandType" value="variableReference" />
			<c:set var="varRefValue" value="${tk:getFieldValue(toolkitData, rightOperandVariablePath, '')}"/>
			<c:set var="varRefScopePath" value="${rightOperandVariablePath}.@scope" />
			<c:set var="varRefScope" value="${tk:getFieldValue(toolkitData, varRefScopePath, '')}" />
			<c:set var="varSelectedValue" value="${varRefScope}|${varRefValue}" />
			<c:set var="rightOperandValue" value="${varRefValue}"/>
  		</c:when>
  		<c:when test="${tk:getCount(toolkitData,rightOperandXpathPath ) > 0}" >
  			<c:set var="rightOperandType" value="xpath" />
			<c:set var="rightOperandValue" value="${tk:getFieldValue(toolkitData, rightOperandXpathPath, rightOperandValue)}" />
  		</c:when>
  		<c:when test="${tk:getCount(toolkitData,rightOperandExpressionPath ) > 0}" >
   			<c:set var="rightOperandType" value="expression" />
			<c:set var="rightOperandValue" value="Expression" />
  		</c:when>
  		<c:when test="${tk:getCount(toolkitData,rightOperandSqlPath ) > 0}" >
  			<c:set var="rightOperandType" value="sql" />
			<c:set var="rightOperandValue" value="${tk:getFieldValue(toolkitData, rightOperandSqlPath, rightOperandValue)}" />
  		</c:when>
  		<c:when test="${tk:getCount(toolkitData,rightOperandDatePath ) > 0}" >
   			<c:set var="rightOperandType" value="date" />
			<c:set var="rightOperandValue" value="${tk:getFieldValue(toolkitData, rightOperandDatePath, rightOperandValue)}" />
  		</c:when>
  		<c:otherwise>
  			<c:set var="rightOperandType" value="constant" />
			<c:set var="rightOperandValue" value="${tk:getFieldValue(toolkitData, rightOperandConstantPath, rightOperandValue)}" />
  		</c:otherwise>
	</c:choose>

	<tr id="${conditionPath}" class="${evenOddClass} conditionTr">
		<td>
			<div class="input_container">
				<span>
					<input type="text" id="${conditionPath}.@order" name="${conditionPath}.@order" size="2" maxlength="2" value="${toolkitData.currentIndex}" class="order numeric"/>
					<input type="hidden" id="${conditionPath}_type" value="condition"></input>	
				</span>
			</div>
		</td>
		<td id="${operandPath}[0]" class="palette_toggle needs_palette">
			<span>
				<span id="${operandPath}[0]_displayText" class="displayText underline">${leftOperandValue}</span>
				<span>
					<input type="hidden" id="${conditionPath}.@delete" name="${conditionPath}.@delete" value="false" />
					<input type="hidden" id="${operandPath}[0]_type" value="operand" />
					<input type="hidden" id="${operandPath}[0].@delete" name="${operandPath}[0].@delete" value="false" />
				</span>
			</span>
		</td>
		<td id="${conditionPath}.operator" class="palette_toggle needs_palette">
			<span >
				<span id="${operatorPath}_displayText" class="displayText underline">
					<c:if test="${empty operator}">
						"exists"
					</c:if>
					<c:if test="${not empty operator}">
						${operator}
					</c:if>
				</span>
				<span>
					<input type="hidden" id="${conditionPath}.operator.@name" value="Condition" />
					<input type="hidden" id="${conditionPath}.operator_type" value="operator" />
				</span>
			</span>
		</td>

		<c:if test="${empty operatorValue || operatorValue=='true|'}">
			<c:set var="isExistsOperator" value="true" />
			<c:set var="hiddenStyle" value="display: none" />
		</c:if>
		<c:if test="${not empty operatorValue && operatorValue!='true|'}">
			<c:set var="isExistsOperator" value="false" />
			<c:set var="hiddenStyle" value="" />
		</c:if>

		<td id="${operandPath}[1]" class="palette_toggle needs_palette" style="${hiddenStyle}">
			<span>
				<span id="${operandPath}[1]_displayText" class="displayText underline">${rightOperandValue}</span>
				<span>
					<input type="hidden" id="${operandPath}[1]_type" value="operand" />
					<input type="hidden" id="${operandPath}[1].@delete" name="${operandPath}[1].@delete" value="${isExistsOperator}" />
				</span>
			</span>
		</td>
	</tr>
</c:if>