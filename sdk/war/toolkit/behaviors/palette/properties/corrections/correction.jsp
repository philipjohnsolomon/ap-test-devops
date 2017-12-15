<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="correctionPath" value="${path}.correction"/>
<c:set var="typePath" value="${correctionPath}.@type"/>
<c:set var="correctionType" value="${tk:getFieldValue(toolkitData,typePath,'useSubstitute')}"/>
<c:set var="correctionPage" value="/toolkit/behaviors/palette/properties/corrections/${correctionType}.jsp"/>
<c:set var="removePath" value="${correctionPath}.@remove"/>
<c:set var="namePath" value="${path}.@name"/>

<tk:dialogForm
	action="Toolkit?action=addCorrection&product=${param.product}&artifactId=${param.artifactId}">
	
	<tk:dialogFieldset
		path="${path}"
		legend="Correction Options"
		type=""
		errorMessage="Error creating correction.  Please check the logs to find the cause.">	
		
		<input type="hidden" id="${namePath}" name="${namePath}" value="correction"/>	
		<tk:select path="${typePath}" label="Correction Type" required="*" className="change_event alter_correction">
			<c:out value="${tk:getOptionsHTML(toolkitData, 'correctionTypes', typePath, '')}" escapeXml="false"/>
		</tk:select>
		
		<div id="${correctionPath}_content" class="correction_content">
			<jsp:setProperty property="basePath" name="toolkitData" value="${correctionPath}"/>
			<jsp:include page="${correctionPage}" >
				<jsp:param name="path" value="${correctionPath}" />	
			</jsp:include>
		</div>
		
		<tk:select path="${removePath}" label="Remove" elementName="${removePath}" required="*" className="">
			<c:out value="${tk:getOptionsHTML(toolkitData, 'noYes', removePath, '')}" escapeXml="false"/>
		</tk:select>
	</tk:dialogFieldset>
</tk:dialogForm>
