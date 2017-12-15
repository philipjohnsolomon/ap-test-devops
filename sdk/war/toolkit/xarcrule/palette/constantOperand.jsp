<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="constantPath" value="${param.path}.constant"/>

	<fieldset id="${param.path}_constant_palette" class="standardForm palette_tab">
		<input type="hidden" id="${param.path}.field" name="${param.path}.field" value="" />
		<input type="hidden" id="${param.path}.variableReference" name="${param.path}.variableReference" value="" />
		<input type="hidden" id="${param.path}.expression" name="${param.path}.expression" value="" />
		<input type="hidden" id="${param.path}.xpath" name="${param.path}.xpath" value="" />
		
		<div class="constantOperand" id="${param.path}_constant_entry">
			<tk:input path="${constantPath}" 
				label="Operand" 
				fieldValue="${tk:getFieldValue(toolkitData,constantPath,'New Operand')}"  
				required="*" 
				defaultValue="" 
				size="40"
				elementName="${constantPath}"
				class="resetValue">
			</tk:input>	
		</div>
		<jsp:include page="../palette/functions.jsp" >	
			<jsp:param name="required" value=""></jsp:param>
		</jsp:include>		
	</fieldset>