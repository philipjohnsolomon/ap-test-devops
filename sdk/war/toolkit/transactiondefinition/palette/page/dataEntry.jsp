<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="pageData" class="com.agencyport.toolkit.data.search.PageEntitySearchData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="titlePath" value="${path}.@title"/>
<c:set var="defaultIdVal" value="${fn:replace(idPath,'[','_')}"/>
<c:set var="defaultIdVal" value="${fn:replace(idPath,']','')}"/>
<c:set var="sourcePath" value="${path}.@source"/>
<c:set var="typePath" value="${path}.@type"/>
<c:set var="pageType" value="${tk:getFieldValue(toolkitData,typePath,'')}"/>
<c:set var="subTypePath" value="${path}.@subType"/>
<c:set var="prevalidatePath" value="${path}.@prevalidate"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>
<c:set var="fieldValidationsPath" value="${path}.@fieldValidations"/>
<c:set var="validateTransactionOnDisplay" value="${path}.@validateTransactionOnDisplay"/>
<c:set var="ignorePageVisitedCheckPath" value="${path}.@ignorePageVisitedCheck"/>
<c:set var="slowLoaderPath" value="${path}.@slowLoader"/>
<c:set var="menuDisplayPath" value="${path}.@menuDisplay"/>
<c:set var="pageLibraryEntity" value="pageLibrary"/>
<c:set var="supportsIPDTRDynamicContent" value="${path}.@supportsIPDTRDynamicContent"/>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Impacted By" focusOnLoad="false" path="${path}"></tk:tab>
		<c:if test="${pageLibraryEntity == ARTIFACT_TYPE}">
			<tk:tab tabName="Used By" focusOnLoad="false" path="${path}"></tk:tab>
		</c:if>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}" styleValue="">
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="dataEntry"/>
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		<tk:input path="${titlePath}"
			label="Title"
			fieldValue="${tk:getFieldValue(toolkitData,titlePath,'New Data Entry Page')}"
			required="*"
			defaultValue=""
			size="20"
			className="title_editor change_event accordion_update"
			helptext="page_helptext|title">
		</tk:input>
		<tk:input path="${idPath}"
			label="ID"
			fieldValue="${tk:getFieldValue(toolkitData,idPath,defaultIdVal)}"
			required="*"
			defaultValue=""
			size="20"
			className="idCharacters"
			helptext="page_helptext|id">
		</tk:input>

		<c:if test="${pageType == 'roster'}">
			<tk:input path="${sourcePath}"
				label="Roster Source Path"
				fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"
				required="*"
				defaultValue="${defaultIdVal}"
				size="40"
				className="idCharacters"
				helptext="page_helptext|rostersourcepath">
			</tk:input>
		</c:if>
		<tk:select label="Field Validations"
			path="${fieldValidationsPath}"
			helptext="page_helptext|fieldvalidations">
			${tk:getOptionsHTML(toolkitData,'fieldValidations',fieldValidationsPath,'')}
		</tk:select>
	</tk:tabContent>

	<tk:tabContent tabName="Impacted By" path="${path}" styleValue="display: none">
		<tk:displayPageSearch errorMsg="">
			<jsp:include page="../behaviorCrossRef.jsp">
				<jsp:param name="entity" value="Page" />
			</jsp:include>
		</tk:displayPageSearch>
	</tk:tabContent>

	<tk:tabContent tabName="Used By" path="${path}" styleValue="display: none">
		<tk:displayPageSearch errorMsg="${pageData.pageErrorMsg}">
			<jsp:include page="../transactionCrossRef.jsp">
				<jsp:param name="entity" value="Page Library" />
			</jsp:include>
		</tk:displayPageSearch>
	</tk:tabContent>

 	<tk:tabContent tabName="Advanced" path="${path}" styleValue="display: none">
 		<tk:select label="Menu Display"
			path="${menuDisplayPath}"
			helptext="page_helptext|menudisplay">
			${tk:getOptionsHTML(toolkitData,'menuDisplay',menuDisplayPath,'')}
		</tk:select>
	 	<tk:select label="Slow Loader"
			path="${slowLoaderPath}"
			helptext="page_helptext|slowloader">
			${tk:getOptionsHTML(toolkitData,'booleanFalse',slowLoaderPath,'')}
		</tk:select>
	  	<tk:select label="Ignore Page Visited Check"
			path="${ignorePageVisitedCheckPath}"
			helptext="page_helptext|ignorepagevisitedcheck">
			${tk:getOptionsHTML(toolkitData,'booleanFalse',ignorePageVisitedCheckPath,'')}
		</tk:select>
		<tk:select label="Prevalidate"
			path="${prevalidatePath}"
			helptext="page_helptext|prevalidate">
			${tk:getOptionsHTML(toolkitData,'booleanTrue',prevalidatePath,'')}
		</tk:select>
		<c:if test="${pageType == 'roster'}">
			<tk:input path="${subTypePath}"
				label="Roster Sub Type"
				fieldValue="${tk:getFieldValue(toolkitData,subTypePath,'')}"
				required=""
				defaultValue=""
				size="20"
				helptext="page_helptext|rostersubtype">
			</tk:input>
		</c:if>
		<tk:input path="${styleClassPath}"
			label="Style Class"
			fieldValue="${tk:getFieldValue(toolkitData,styleClassPath,'')}"
			required=""
			defaultValue=""
			size="40">
		</tk:input>
		<tk:select label="Validate Transaction On Display"
			path="${validateTransactionOnDisplay}">
			${tk:getOptionsHTML(toolkitData,'booleanFalse',validateTransactionOnDisplay,'')}
		</tk:select>
		<tk:select label="Support IPDTR Dynamic Content" 
			path="${supportsIPDTRDynamicContent}" 
			helptext="page_helptext|supportsipdtrdynamiccontent" >
				${tk:getOptionsHTML(toolkitData, 'booleanFalse', supportsIPDTRDynamicContent, '')}
		</tk:select>	
	 </tk:tabContent>
</div>
