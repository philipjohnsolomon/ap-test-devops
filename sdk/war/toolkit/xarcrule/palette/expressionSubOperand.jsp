<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<c:set var="EXPRESSIONOPERAND" value="${OPERAND.expression.operands[toolkitData.currentIndex]}"/>


<fieldset id="${EXPRESSIONOPERAND.operandPath}_options_palette" class="standardForm expression_palette_tab" style="display: none;">
	<div class="basicAttributes" id="operandbasicAttributes">

		<tk:select path="${EXPRESSIONOPERAND.operandPath}.@fieldType" label="Type" required="*" helptext="xarc_helptext|type" className="change_event show_options">
			<c:out value="${tk:getOptionListHTML('xarcExpressionFieldTypes',EXPRESSIONOPERAND.operandType,'')}" escapeXml="false"/>
		</tk:select>

		<c:set var="hidden" value="${tk:getCompareValues(EXPRESSIONOPERAND.operandType, 'field', '','display: none;' )}" />
		<jsp:include page="../../xarcrule/palette/fieldCrossReference.jsp" >
			<jsp:param name="path" value="${EXPRESSIONOPERAND.operandPath}.field"></jsp:param>
			<jsp:param name="hidden" value="${hidden}"></jsp:param>
			<jsp:param name="className" value="required change_event resetValue"></jsp:param>
		</jsp:include>

		<c:set var="hidden" value="${tk:getCompareValues(EXPRESSIONOPERAND.operandType, 'constant', '','display: none;' )}" />
		<c:set var="leftOperandConstantPath" value="${EXPRESSIONOPERAND.operandPath}.constant" />
		<tk:input path="${leftOperandConstantPath}"
			label="Value"
			fieldValue="${tk:getFieldValue(toolkitData,leftOperandConstantPath,'')}"
			required="*"
			defaultValue=""
			size="40"
			hidden="${hidden}"
			className="operand change_event accordion_update resetValue"
			helptext="xarc_helptext|value">
		</tk:input>

		<c:set var="hidden" value="${tk:getCompareValues(EXPRESSIONOPERAND.operandType, 'variableReference', '','display: none;' )}" />

		<jsp:include page="../palette/variableReferenceOperand.jsp" >
			<jsp:param name="label" value="Variable" ></jsp:param>
   			<jsp:param name="required" value="*"></jsp:param>
   			<jsp:param name="path" value="${EXPRESSIONOPERAND.operandPath}.variableReference"></jsp:param>
   			<jsp:param name="name" value="${EXPRESSIONOPERAND.operandPath}.variableReference"></jsp:param>
   			<jsp:param name="className" value="operand change_event accordion_update resetValue"></jsp:param>
   			<jsp:param name="defaultValue" value=""></jsp:param>
   			<jsp:param name="hidden" value="${hidden}"></jsp:param>
		</jsp:include>

		<c:set var="hidden" value="${tk:getCompareValues(EXPRESSIONOPERAND.operandType, 'xpath', '','display: none;' )}" />
		<c:set var="leftOperandXpathPath" value="${EXPRESSIONOPERAND.operandPath}.xpath" />
		
		<tk:input path="${leftOperandXpathPath}"
			label="Xpath"
			fieldValue="${tk:getFieldValue(toolkitData,leftOperandXpathPath,'')}"
			required="*"
			defaultValue=""
			size="40"
			hidden="${hidden}"
			className="operand change_event accordion_update resetValue"
			helptext="xarc_helptext|xpath">
		</tk:input>

		<c:set var="hidden" value="${tk:getCompareValues(EXPRESSIONOPERAND.operandType, 'date', '','display: none;' )}" />
		<c:set var="leftOperandDatePath" value="${EXPRESSIONOPERAND.operandPath}.date" />

		<c:choose>
  			<c:when test="${toolkitData.currentIndex == 0}" >  			
				<tk:input path="${leftOperandDatePath}"
					label="Date"
					fieldValue="${tk:getFieldValue(toolkitData,leftOperandDatePath,'')}"
					required="*"
					defaultValue=""
					size="40"
					hidden="${hidden}"
					className="operand change_event accordion_update resetValue"
					helptext="xarc_helptext|date">
				</tk:input>
			</c:when>
			<c:otherwise>
				<c:set var="dateValue" value="${tk:getFieldValue(toolkitData,leftOperandDatePath,'')}" />
				<c:set var="yearPos" value= "${fn:indexOf(dateValue,'Y')}"/>
				<c:set var="monthPos" value= "${fn:indexOf(dateValue,'M')}"/>
				<c:set var="dayPos" value= "${fn:indexOf(dateValue,'D')}"/>
			
				<div id="${leftOperandDatePath}_formRow" class="formRow" style="${hidden}">
					<input type="hidden" name="${leftOperandDatePath}" id="${leftOperandDatePath}" value="${tk:getFieldValue(toolkitData,leftOperandDatePath,'')}" class="operand resetValue" />
						<table id="${leftOperandDatePath}_table">
							<thead>
								<tr class="paletteRow">
									<td>* Add</td>
									<td>Years</td>
									<td>Months</td>
									<td>Days</td>
								</tr>
							</thead>
							<tbody id="${leftOperandDatePath}_tbody">
								<tr id="" class="paletteRow">
									<td>&nbsp;</td>
									<td>
										<span> 
											<input type="text" id="${leftOperandDatePath}_years" class="operand dateAdd change_event resetValue" size="3" value="${fn:substring(dateValue,1,yearPos)}" />
										</span>
									</td>
									<td>
										<span>
											<input type="text" id="${leftOperandDatePath}_months" class="operand dateAdd change_event resetValue" size="3" value="${fn:substring(dateValue,yearPos+1,monthPos)}" /> 
										</span>
									</td>
									<td>
										<span> 
											<input type="text" id="${leftOperandDatePath}_days" class="operand dateAdd change_event resetValue" size="3" value="${fn:substring(dateValue,monthPos+1,dayPos)}" /> 
										</span>
									</td>
								</tr>
							</tbody>
						</table>
				</div>
			</c:otherwise>
		</c:choose>

		<c:set var="hidden" value="${tk:getCompareValues(EXPRESSIONOPERAND.operandType, 'sql', '','display: none;')}" />
		<jsp:include page="../../xarcrule/palette/sqlOperand.jsp" >
			<jsp:param name="path" value="${EXPRESSIONOPERAND.operandPath}.sql"></jsp:param>
			<jsp:param name="hidden" value="${hidden}"></jsp:param>
			<jsp:param name="className" value="required resetValue"></jsp:param>
		</jsp:include>
	</div>
</fieldset>
