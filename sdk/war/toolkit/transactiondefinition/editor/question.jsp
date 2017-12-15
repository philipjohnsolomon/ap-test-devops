<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>
<c:set var="requiredPath" value="${basePath}.@required"/>
<c:set var="labelPath" value="${basePath}.@label"/>
<c:set var="questionNumberPath" value="${basePath}.@questionNumber"/>

<c:set var="required" value="${tk:getFieldValue(toolkitData, requiredPath, 'false')}"/>
<c:set var="label" value="${tk:getFieldValue(toolkitData, labelPath, 'New Question Field')}"/>
<c:set var="questionNumber" value="${tk:getFieldValue(toolkitData, questionNumberPath, '')}"/>

<tr id="${basePath}" class="palette_toggle needs_palette fieldElement">
	<td>
		<input type="hidden" id="${basePath}_type" value="question"/>
		<span id="${requiredPath}_displayText">
			<span class="requiredField">
				<c:if test="${required == 'true'}">
					<c:out value="*"/>
				</c:if>
			</span>
		</span>
	</td>
	<td>${questionNumber}</td>
	<td>
		<span id="${basePath}.@title_displayText">${label}</span>
	</td>
	<td>
		<span>
			<input type="radio" value="YES" name="" id="${basePath}_question_yes" disabled="disabled"/>
		</span>
	</td>
	<td>
		<span>
			<input type="radio" value="NO" name="" id="${basePath}_question_no" disabled="disabled"/>
		</span>
		<input type="hidden" id="${param.path}_type" value="question"/>
	</td>
	<td id="${basePath}_fieldHelpers_td" class="fieldHelpers">
		<tk:fieldHelper path="${basePath}"/>
	</td>
</tr>