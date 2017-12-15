<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="pageData" class="com.agencyport.toolkit.data.search.PageEntitySearchData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="idValue" value="${tk:getFieldValue(toolkitData,idPath,path)}"/>
<c:set var="typePath" value="${path}.@type"/>
<c:set var="typeValue" value="${tk:getFieldValue(toolkitData, typePath, '')}"/>
<c:set var="labelPath" value="${path}.@label"/>
<c:set var="labelValue" value="${tk:getFieldValue(toolkitData, labelPath, '')}"/>

<tk:basePalette path="${path}">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
	</tk:tabs>
	<tk:tabContent tabName="Options" path="${path}">     
		<c:set var="labelPath" value="${path}.@label" />
			<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="false"></input>
			<div id="${typePath}_formRow" class="formRow">
				<label class="label" id="${typePath}_labelElement" for="${typePath}">
					<span id="${typePath}_labelText">
								Section Type
					</span>
				</label>
				<span>
					<span id="${typePath}">${typeValue}</span>
				</span>
			</div>
			<tk:input path="${labelPath}" label="Label" fieldValue="${labelValue}" 
				elementName="${labelPath}" required="*" defaultValue="" size="50" className="accordion_update change_event hotUpdate" helptext="workitemAssistant_helptext|sectiontitle">
			</tk:input>
			<div id="${idPath}_formRow" class="formRow">
				<label class="label" id="${idPath}_labelElement" for="${idPath}">
					<span id="${idPath}_labelText">
								ID
					</span>
				</label>
				<span>
					<span id="${idPath}">${idValue}</span>
				</span>
			</div>
	</tk:tabContent>
</tk:basePalette>