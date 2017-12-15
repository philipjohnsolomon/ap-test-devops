<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="typePath" value="${path}.@type"/>
<c:set var="type" value="${tk:getFieldValue(toolkitData,typePath,'')}"/>
<c:set var="jspPage" value="${tk:getOptionsListValue('validationMenuJSP', type)}"/>
<c:set var="validationPath" value="${path}.validation"/>

<c:if test="${type != 'file'}">
	
	<tkmenu:menuDropDown title="Add Validation" text="Add Validation" id="${path}_addValidationActions">
		<tkmenu:menuOption id="${validationPath}_addValidation-custom" title="Add Custom Validation" text="Custom" classname="addNew"/>
		<tkmenu:menuOption id="${validationPath}_addValidation-required" title="Add Required Validation" text="Required" classname="addNew"/>

		<jsp:include page="${jspPage}" >
			<jsp:param name="validationPath" value="${validationPath}" />	
		</jsp:include>
	
	</tkmenu:menuDropDown>
</c:if>