<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>
<c:set var="encodePath" value="${path}.@encode"/>
<c:set var="widthPath" value="${path}.@width"/>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="balloon" />

		<tk:textarea path="${path}.@content"
			label="Balloon Text"
			fieldValue="${tk:getFieldValue(toolkitData,path,'')}"
			required="*"
			defaultValue="Please Enter Balloon Field Helper Text"
			size="40"
			elementName="${path}"
			helptext="fieldHelper_helptext|balloontext">
		</tk:textarea>
		<tk:input path="${widthPath}"
			label="Message Box Width"
			fieldValue="${tk:getFieldValue(toolkitData,widthPath,'')}"
			required=""
			defaultValue=""
			size="10">
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
		<tk:select label="Encode Text" 
			path="${encodePath}" 
			helptext="fieldElement_helptext|encodetext">
			${tk:getOptionsHTML(toolkitData,'booleanTrue',encodePath,'')}
		</tk:select>	
	</tk:tabContent>
</div>