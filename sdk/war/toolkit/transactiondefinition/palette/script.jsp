<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="srcPath" value="${path}.@src"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>

<div id="${path}_palette" class="palette">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@contentType" id="${path}.@contentType" value="text/javascript"/>
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="script"/>

		<tk:input path="${idPath}"
			label="ID"
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"
			required=""
			defaultValue=""
			size="40"
			className="idCharacters"
			helptext="fieldElement_helptext|id">
		</tk:input>

		<tk:input path="${srcPath}"
			label="Script Path"
			fieldValue="${tk:getFieldValue(toolkitData,srcPath,'')}"
			required="*"
			defaultValue=""
			size="40"
			helptext="fieldElement_helptext|scriptpath">
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