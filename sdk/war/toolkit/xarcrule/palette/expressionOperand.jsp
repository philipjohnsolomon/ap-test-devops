<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

	<fieldset  id="${OPERAND.operandPath}_expression_palette" class="standardForm">
		<table>
			<thead>
				<tr>
					<th>Operand</th>
					<th>Operator</th>
					<th>Operand</th>
				</tr>
			</thead>
			<tbody id="${OPERAND.operandPath}_conditionContainer" class="sortable_container">
			<tr>
			<td id="${OPERAND.expression.firstOperand.operandPath}" class="expression_palette_toggle needs_palette">
				<span>
					<span id="${OPERAND.expression.firstOperand.operandPath}_displayText" class="displayText underline">${OPERAND.expression.firstOperand.operandValue}</span>
				</span>	
			</td>
			<td id="${OPERAND.expression.path}" class="expression_palette_toggle needs_palette">
				<span >
					<span id="${OPERAND.expression.path}.@type_displayText" class="displayText underline">
						${tk:getOptionListDisplayText('xarcExpressionOperators',OPERAND.expression.operator,OPERAND.expression.operator)}
					</span>
				</span>	
			</td>
			<td id="${OPERAND.expression.secondOperand.operandPath}" class="expression_palette_toggle needs_palette">
				<span>
					<span id="${OPERAND.expression.secondOperand.operandPath}_displayText" class="displayText underline">${OPERAND.expression.secondOperand.operandDisplayText}</span>
				</span>		
			</td>
		</tr>
		</tbody>
		</table>
		<div id="${OPERAND.expression.path}_subPaletteContainer" class="subPaletteContainer">
			<jsp:setProperty property="currentIndex" name="toolkitData" value="0"/>	
			<jsp:include page="../../xarcrule/palette/expressionSubOperand.jsp" >
   				<jsp:param name="operand" value="first"></jsp:param>
			</jsp:include>
			<jsp:setProperty property="currentIndex" name="toolkitData" value="1"/>
			<jsp:include page="../../xarcrule/palette/expressionSubOperand.jsp" >
   				<jsp:param name="operand" value="second"></jsp:param>
			</jsp:include>

			<fieldset id="${OPERAND.expression.path}_options_palette" class="standardForm expression_palette_tab" style="display: none;">
					<c:set var="operatorPath" value="${OPERAND.expression.path}.@type"/>
					<c:set var="operatorValue" value="${tk:getFieldValue(toolkitData,operatorPath,'')}"/>
					
					<tk:select path="${operatorPath}" label="Type" required="*" helptext="xarc_helptext|type" className="change_event accordion_update">
						<c:out value="${tk:getOptionListHTML('xarcExpressionOperators',operatorValue,'')}" escapeXml="false"/>
					</tk:select>
			</fieldset>	
		</div>		
	</fieldset>	 