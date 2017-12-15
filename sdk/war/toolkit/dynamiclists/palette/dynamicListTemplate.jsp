<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="pageData" class="com.agencyport.toolkit.data.search.PageEntitySearchData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="titlePath" value="${path}.@title" />
<c:set var="idPath" value="${path}.@id" />
<c:set var="defaultTitle" value="${tk:getFieldValue(toolkitData,idPath,path)}"/>				
<c:set var="descPath" value="${path}.description" />
<c:set var="groupIdPath" value="${path}.groupId" />	
<c:set var="returnIdPath" value="${path}.returnValueId" />
<c:set var="classNamePath" value="${path}.listBuilderClassName" />					

<tk:basePalette path="${path}">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"/>
		<tk:tab tabName="Used By" focusOnLoad="false" path="${path}"/>
	</tk:tabs>
	<tk:tabContent tabName="Options" path="${path}">
		
		<input type="hidden" id="${param.path}.@delete" name="${param.path}.@delete" value=""/>
		
		<tk:input path="${titlePath}" label="Title" fieldValue="${tk:getFieldValue(toolkitData,titlePath,defaultTitle)}" 
			elementName="${titlePath}" required="" defaultValue="" size="20" className="accordion_update change_event hotUpdate" helptext="codeList_helptext|title">
		</tk:input>

		<tk:textarea path="${descPath}" label="Description" fieldValue="${tk:getFieldValue(toolkitData,descPath,'New Dynamic List')}" 
			elementName="${descPath}" required="" defaultValue="" size="20" className="" helptext="codeList_helptext|description">
		</tk:textarea>
		
		<tk:input path="${idPath}" label="ID" fieldValue="${tk:getFieldValue(toolkitData,idPath,path)}" 
			elementName="${idPath}" required="*" defaultValue="" size="20" className="idCharacters" helptext="codeList_helptext|id">
		</tk:input>								

		<tk:input path="${groupIdPath}" label="Group Path" fieldValue="${tk:getFieldValue(toolkitData,groupIdPath,'')}" 
			elementName="${groupIdPath}" required="*" defaultValue="" size="20" className="" helptext="codeList_helptext|grouppath">
		</tk:input>
			
		<tk:input path="${returnIdPath}" label="Return Field Id" fieldValue="${tk:getFieldValue(toolkitData,returnIdPath,'')}" 
			elementName="${returnIdPath}" required="*" defaultValue="" size="20" className="" helptext="codeList_helptext|returnfieldid">
		</tk:input>
			
		<tk:input path="${classNamePath}" label="Custom Java Class Name" fieldValue="${tk:getFieldValue(toolkitData,classNamePath,'')}" 
			elementName="${classNamePath}" required="" defaultValue="" size="20" className="" helptext="codeList_helptext|customjavaclassname">
		</tk:input>
		
	</tk:tabContent>
	<tk:tabContent tabName="Used By" path="${path}" styleValue="display: none">	
		<tk:displayPageSearch errorMsg="${pageData.fieldErrorMsg}">
			<jsp:include page="../../shared/palette/tdfCrossReferencePalette.jsp">
				<jsp:param name="entity" value="Dynamic List" />	
			</jsp:include>
		</tk:displayPageSearch>	
	</tk:tabContent>	
</tk:basePalette>