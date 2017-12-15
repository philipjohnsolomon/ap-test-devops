<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="pageData" class="com.agencyport.toolkit.data.search.PageEntitySearchData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="idValue" value="${tk:getFieldValue(toolkitData,idPath,path)}"/>
<c:set var="fieldTitlePath" value="${path}.@title"/>
<c:set var="fieldValue" value="${tk:getFieldValue(toolkitData, fieldTitlePath, idValue)}"/>

<tk:basePalette path="${path}">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Used By" focusOnLoad="false" path="${path}"/>
	</tk:tabs>
	<tk:tabContent tabName="Options" path="${path}">
		<c:set var="titlePath" value="${path}.@title" />
			<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="false"></input>
			<tk:input path="${titlePath}" label="Title" fieldValue="${fieldValue}" 
				elementName="${titlePath}" required="" defaultValue="" size="20" className="accordion_update change_event hotUpdate" helptext="codeList_helptext|title">
			</tk:input>
			
			<c:set var="descPath" value="${path}.@description" />
			<tk:textarea path="${descPath}" label="Description" fieldValue="${tk:getFieldValue(toolkitData,descPath, ' ')}" 
				elementName="${descPath}" required="" defaultValue="" size="20" className="" helptext="codeList_helptext|description">
			</tk:textarea>

			<tk:input path="${idPath}" label="ID" fieldValue="${idValue}" 
				elementName="${idPath}" required="*" defaultValue="" size="20" className="idCharacters" helptext="codeList_helptext|id">
			</tk:input>
	</tk:tabContent>
	<tk:tabContent tabName="Used By" path="${path}" styleValue="display: none">	
		<tk:displayPageSearch errorMsg="${pageData.fieldErrorMsg}">
			<jsp:include page="../../shared/palette/tdfCrossReferencePalette.jsp">
				<jsp:param name="entity" value="Option List" />	
			</jsp:include>
		</tk:displayPageSearch>	
	</tk:tabContent>	
</tk:basePalette>