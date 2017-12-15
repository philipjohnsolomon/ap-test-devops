<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<tk:basePalette path="${OPERAND.operandPath}">

	<c:set var="display" value="${tk:getCompareValues(OPERAND.operandType, 'expression', '','display: none;' )}" />

	<tk:tabs path="${OPERAND.operandPath}">
		<tk:tab tabName="Options" focusOnLoad="${!fn:contains(OPERAND.operandType,'expression')}" path="${OPERAND.operandPath}"></tk:tab>
		<tk:tab tabName="Expression" focusOnLoad="${fn:contains(OPERAND.operandType,'expression')}" styleValue="${display}" path="${OPERAND.operandPath}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${OPERAND.operandPath}"></tk:tab>
	</tk:tabs>

	<span>
		<input type="hidden" id="${OPERAND.operandPath}.expression.@delete" name="${OPERAND.operandPath}.expression.@delete" value="${OPERAND.operandType != 'expression'}" />
		<input type="hidden" id="${OPERAND.operandPath}.@delete" name="${OPERAND.operandPath}.@delete" value="false" />
	</span>
	<c:set var="hidden" value="${tk:getCompareValues(OPERAND.operandType, 'expression', 'display: none;','' )}" />
	<c:set var="focusTabClass" value="${tk:getCompareValues(OPERAND.operandType, 'expression', '','focusTab' )}" />
	<tk:tabContent tabName="Options" path="${OPERAND.operandPath}" className="focusTabClass" styleValue="${hidden}">

			<tk:select path="${OPERAND.operandPath}.@fieldType" label="Type" required="*" helptext="xarc_helptext|type" className="change_event show_options">
				<c:out value="${tk:getOptionListHTML('xarcFieldTypes',OPERAND.operandType,'')}" escapeXml="false"/>
			</tk:select>

			<c:set var="hidden" value="${tk:getCompareValues(OPERAND.operandType, 'field', '','display: none;' )}" />
			<jsp:include page="../../xarcrule/palette/fieldCrossReference.jsp" >
				<jsp:param name="path" value="${OPERAND.operandPath}.field"></jsp:param>
				<jsp:param name="hidden" value="${hidden}"></jsp:param>
				<jsp:param name="className" value="required resetValue change_event"></jsp:param>
			</jsp:include>

			<c:set var="hidden" value="${tk:getCompareValues(OPERAND.operandType, 'constant', '','display: none;' )}" />
			<c:set var="constantPath" value="${OPERAND.operandPath}.constant"/>
			<tk:input path="${constantPath}"
				label="Value"
				fieldValue="${tk:getFieldValue(toolkitData,constantPath,'')}"
				required="*"
				defaultValue=""
				size="40"
				hidden="${hidden}"
				className="operand resetValue change_event accordion_update"
				helptext="xarc_helptext|value">
			</tk:input>

			<c:set var="hidden" value="${tk:getCompareValues(OPERAND.operandType, 'variableReference', '','display: none;' )}" />
			<jsp:include page="../palette/variableReferenceOperand.jsp" >
				<jsp:param name="label" value="Variable" ></jsp:param>
	   			<jsp:param name="required" value="*"></jsp:param>
	   			<jsp:param name="path" value="${OPERAND.operandPath}.variableReference"></jsp:param>
	   			<jsp:param name="className" value="operand variable_editor resetValue change_event accordion_update"></jsp:param>
	   			<jsp:param name="hidden" value="${hidden}"></jsp:param>
			</jsp:include>

			<c:set var="hidden" value="${tk:getCompareValues(OPERAND.operandType, 'xpath', '','display: none;' )}" />
			<c:set var="xpathPath" value="${OPERAND.operandPath}.xpath"/>
			<tk:textarea path="${xpathPath}"
				label="Xpath"
				fieldValue="${tk:getFieldValue(toolkitData,xpathPath,'')}"
				required="*"
				defaultValue="${defaultInLineText}"
				size="40"
				hidden="${hidden}"
				className="operand resetValue change_event accordion_update"
				helptext="xarc_helptext|xpath">
			</tk:textarea>

			<c:set var="hidden" value="${tk:getCompareValues(OPERAND.operandType, 'date', '','display: none;' )}" />
			<c:set var="datePath" value="${OPERAND.operandPath}.date"/>
			<tk:input path="${datePath}"
				label="Date"
				fieldValue="${tk:getFieldValue(toolkitData,datePath,'')}"
				required="*"
				defaultValue=""
				size="40"
				hidden="${hidden}"
				className="operand change_event accordion_update resetValue"
				helptext="xarc_helptext|date">
<!--  
				<div id="${datePath}_fieldHelperCalendarDiv" class="dateHelper">
					<a onclick="ap.master.showCalendar('${datePath}');" href="javascript:void(0);" class="fieldHelperCalendar " id="${datePath}_fieldHelperCalendar" tabindex="16"></a>
				</div>
-->				
			</tk:input>

			<c:set var="hidden" value="${tk:getCompareValues(OPERAND.operandType, 'sql', '','display: none;' )}" />
			<jsp:include page="../../xarcrule/palette/sqlOperand.jsp" >
				<jsp:param name="path" value="${OPERAND.operandPath}.sql"></jsp:param>
				<jsp:param name="hidden" value="${hidden}"></jsp:param>
				<jsp:param name="className" value="required resetValue change_event accordion_update"></jsp:param>
			</jsp:include>
	</tk:tabContent>

	<c:set var="hidden" value="${tk:getCompareValues(OPERAND.operandType, 'expression', '','display: none;' )}" />
	<c:set var="focusTabClass" value="${tk:getCompareValues(OPERAND.operandType, 'expression', 'focusTab','' )}" />
	<tk:tabContent tabName="Expression" path="${OPERAND.operandPath}" className="focusTabClass" styleValue="${hidden}">
		<jsp:include page="../palette/expressionOperand.jsp" >
   			<jsp:param name="path" value="${OPERAND.operandPath}.expression"></jsp:param>
			<jsp:param name="className" value="operand"></jsp:param>
		</jsp:include>
	</tk:tabContent>

 	<tk:tabContent tabName="Advanced" path="${OPERAND.operandPath}" styleValue="display: none">
		<jsp:include page="../palette/functions.jsp" >
			<jsp:param name="path" value="${OPERAND.operandPath}"></jsp:param>
		</jsp:include>
	</tk:tabContent>
</tk:basePalette>