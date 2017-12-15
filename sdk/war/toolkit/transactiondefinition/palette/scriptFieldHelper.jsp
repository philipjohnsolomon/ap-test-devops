<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="sourcePath" value="${path}.@src"/>
<c:set var="iconPath" value="${path}.@icon"/>
<c:set var="functionPath" value="${path}.@function"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>

<div id="${path}_palette" class="palette">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="script" />
		
		<tk:input path="${sourcePath}" 
			label="Path to Source" 
			fieldValue="${tk:getFieldValue(toolkitData,sourcePath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${sourcePath}"
			helptext="fieldHelper_helptext|pathtosource">
		</tk:input>			
		<tk:input path="${iconPath}" 
			label="Icon" 
			fieldValue="${tk:getFieldValue(toolkitData,iconPath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${iconPath}"
			helptext="fieldHelper_helptext|icon">
		</tk:input>	
		<tk:input path="${functionPath}" 
			label="Function" 
			fieldValue="${tk:getFieldValue(toolkitData,functionPath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${functionPath}"
			helptext="fieldHelper_helptext|funtion">
		</tk:input>	
	</tk:tabContent>
	<tk:tabContent tabName="Advanced" path="${path}" styleValue="display: none">
		<tk:input path="${styleClassPath}" 
			label="Style Class" 
			fieldValue="${tk:getFieldValue(toolkitData,styleClassPath,'')}"  
			required="" 
			defaultValue="" 
			size="40">
		</tk:input>				
	</tk:tabContent>	
</div>