<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="fromPath" value="${path}.@fromPath"/>
<c:set var="fromIdPath" value="${path}.@fromId"/>
<c:set var="toPath" value="${path}.@toPath"/>
<c:set var="toIdPath" value="${path}.@toId"/>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />

		<tk:textarea path="${fromPath}" 
			label="From Path" 
			fieldValue="${tk:getFieldValue(toolkitData,fromPath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${fromPath}"
			helptext="fieldElement_helptext|frompath">
		</tk:textarea>

		<tk:textarea path="${fromIdPath}" 
			label="From Attribute Name" 
			fieldValue="${tk:getFieldValue(toolkitData,fromIdPath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${fromIdPath}"
			helptext="fieldElement_helptext|fromattributename">
		</tk:textarea>

		<tk:textarea path="${toPath}" 
			label="To Path" 
			fieldValue="${tk:getFieldValue(toolkitData,toPath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${toPath}"
			helptext="fieldElement_helptext|topath">
		</tk:textarea>

		<tk:textarea path="${toIdPath}" 
			label="To Attribute Name" 
			fieldValue="${tk:getFieldValue(toolkitData,toIdPath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${toIdPath}"
			helptext="fieldElement_helptext|toattributename">
		</tk:textarea>
	</tk:tabContent>
</div>