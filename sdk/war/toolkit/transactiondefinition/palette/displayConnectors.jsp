<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="standardCollationPath" value="${path}.@standardCollation"/>
<c:set var="enableValidationsPath" value="${path}.@enableValidations"/>

<div id="${path}_palette" style="display:none" class="palette">
	
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}" styleValue="">
	
		<tk:select label="Apply Standard Collation At Last Connector" 
			path="${standardCollationPath}">
			${tk:getOptionsHTML(toolkitData,'booleanTrue',standardCollationPath,'')}
		</tk:select>		
	
		<tk:select label="Enable Built in Field Validations" 
			path="${enableValidationsPath}">
			${tk:getOptionsHTML(toolkitData,'enableValidationsConnectors',enableValidationsPath,'')}
		</tk:select>
		
	</tk:tabContent>
</div>