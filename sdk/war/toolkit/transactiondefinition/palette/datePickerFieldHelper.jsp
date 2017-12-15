<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="defaultMonth" value="${path}.@defaultMonth"/>
<c:set var="defaultYear" value="${path}.@defaultYear"/>
<c:set var="format" value="${path}.@format"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="datePicker" />
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />

		<tk:input path="${defaultMonth}" 
			label="Default Month" 
			fieldValue="${tk:getFieldValue(toolkitData,defaultMonth,'')}"  
			required="" 
			defaultValue="" 
			size="20"
			helptext="fieldHelper_helptext|defaultmonth">
		</tk:input>				
		<tk:input path="${defaultYear}" 
			label="Default Year" 
			fieldValue="${tk:getFieldValue(toolkitData,defaultYear,'')}"  
			required="" 
			defaultValue="" 
			size="20"
			helptext="fieldHelper_helptext|defaultyear">
		</tk:input>		
		<tk:input path="${format}" 
			label="Date Format" 
			fieldValue="${tk:getFieldValue(toolkitData,format,'')}"  
			required="" 
			defaultValue="YYYY-MM-DD" 
			size="20"
			helptext="fieldHelper_helptext|dateformat">
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