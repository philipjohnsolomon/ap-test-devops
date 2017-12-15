<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value=""/>
<c:set var="idPath" value="@id"/>
<c:set var="idValue" value="${tk:getFieldValue(toolkitData,idPath,'')}"/>
<c:set var="fieldTitlePath" value="@title"/>
<c:set var="fieldValue" value="${tk:getFieldValue(toolkitData, fieldTitlePath, idValue)}"/>

<div id="palette">
	<div id="${param.artifactId}_palette" style="" class="palette events_created">
		<input type="hidden" id="${param.artifactId}.@delete" name="${param.artifactId}.@delete" value=""/>
	
		<tk:tabs path="${path}">
			<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
			<tk:tab tabName="Used By" focusOnLoad="false" path="${param.artifactId}"></tk:tab>
		</tk:tabs>
	
		<tk:tabContent tabName="Options" path="${path}">
			<tk:input path="${idPath}" label="ID" fieldValue="${idValue}" 
				elementName="${idPath}" required="*" defaultValue="" size="20" className="idCharacters" helptext="workitemAssistant_helptext|id">
			</tk:input>
		</tk:tabContent>
		<tk:tabContent tabName="Used By" path="${param.artifactId}" styleValue="display: none">	
			<tk:displayPageSearch errorMsg="${pageData.fieldErrorMsg}">
				<jsp:include page="./transactionCrossReference.jsp">
					<jsp:param name="entity" value="Work Item Assistant" />	
				</jsp:include>
			</tk:displayPageSearch>	
		</tk:tabContent>	
	</div>
</div>


