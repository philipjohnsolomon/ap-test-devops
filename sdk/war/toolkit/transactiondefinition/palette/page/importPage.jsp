<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>
<c:set var="pageIdPath" value="${path}.@pageId"/>
<c:set var="pageTitleIdPath" value="${path}.@pageTitle"/>
<c:set var="fileNamePath" value="${path}.@fileName"/>
<c:set var="fileName" value="${tk:getFieldValue(toolkitData, fileNamePath, '')}"/>

<div id="${path}_palette" style="display:none" class="palette">

  	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Impacted By" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="importPage"/>

		<tk:select label="Page Library"
			path="${fileNamePath}"
			required="*"
			className="change_event tdfListRefresh"
			helptext="page_helptext|pagelibrary">
			${pageLibraryList}
		</tk:select>

		<tk:select label="Page Name"
			path="${idPath}"
			required="*"
			className="title_editor page_id change_event accordion_update"
			helptext="page_helptext|pagename">
			${pageLibraryPages}
		</tk:select>

		<tk:input path="${pageIdPath}"
			label="Override Page Id"
			fieldValue="${tk:getFieldValue(toolkitData,pageIdPath,'')}"
			required=""
			size="20"
			defaultValue=""
			elementName="${pageIdPath}"
			helptext="page_helptext|overridepageid">
		</tk:input>

		<tk:input path="${pageTitleIdPath}"
			label="Override Page Title"
			fieldValue="${tk:getFieldValue(toolkitData,pageTitleIdPath,'')}"
			required=""
			size="20"
			defaultValue=""
			elementName="${pageTitleIdPath}"
			helptext="page_helptext|overridepagetitle">
		</tk:input>
	</tk:tabContent>

	<tk:tabContent tabName="Impacted By" path="${path}" styleValue="display: none">
		<tk:displayPageSearch errorMsg="">
			<jsp:include page="../behaviorCrossRef.jsp">
				<jsp:param name="entity" value="Page" />
			</jsp:include>
		</tk:displayPageSearch>
	</tk:tabContent>

	<tk:tabContent tabName="Advanced" path="${path}" styleValue="display: none;">
		<tk:input path="${styleClassPath}"
			label="Style Class"
			fieldValue="${tk:getFieldValue(toolkitData,styleClassPath,'')}"
			required=""
			defaultValue=""
			size="40">
		</tk:input>
	</tk:tabContent>
</div>
