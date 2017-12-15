<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<jsp:useBean id="pageData" class="com.agencyport.toolkit.data.search.PageEntitySearchData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="titlePath" value="${path}.@title"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="deletePath" value="${path}.@deleteMode"/>
<c:set var="descriptionPath" value="${path}.description"/>
<c:set var="typePath" value="${path}.@type"/>
<c:set var="viewClassPath" value="${path}.@class"/>
<c:set var="typeValue" value="${tk:getFieldValue(toolkitData, typePath, '')}"/>
<c:set var="viewClassValue" value="${tk:getFieldValue(toolkitData, viewClassPath, '')}"/>
<c:set var="relatedAggregatePath" value="${path}.@relatedAggregateId"/>
<c:set var="displayFormatPath" value="${path}.@displayFormat"/>
<c:set var="storageFormatPath" value="${path}.@storageFormat"/>
<c:set var="customClassPath" value="${path}.viewClassName"/>
<c:set var="additionalJsp" value="none" />

<%-- See what, if any, additional jsp we'll need to load --%>
<c:if test="${(viewClassValue=='aggregateExistsBoolean')}">
	<c:set var="additionalJsp" value="AggregateExistsBooleanView.jsp" />
</c:if>

<c:if test="${(viewClassValue=='remarks')}">
	<c:set var="additionalJsp" value="RemarksView.jsp" />
</c:if>

<div id="${param.path}_palette" style="" class="palette">

	<tk:tabs path="${param.path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Used By" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}" >
		<input type="hidden" name="${path}.@class" id="${path}.@class" value="${viewClassValue}" />
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="${typeValue}" />
		<input type="hidden" id="${path}.@delete" name="${path}.@delete" value=""/>

		<tk:input path="${titlePath}"
				label="Title"
				fieldValue="${tk:getFieldValue(toolkitData,titlePath,'')}"
				required="*"
				defaultValue=""
				size="40"
				className="accordion_update change_event"
				helptext="view_helptext|title">
		</tk:input>

		<tk:input path="${idPath}"
				label="ID"
				fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"
				required="*"
				size="40"
				defaultValue="path"
				className="idCharacters"
				helptext="view_helptext|id">
		</tk:input>

		<c:if test="${(viewClassValue=='remarks')}">
		   	<tk:input path="${relatedAggregatePath}" 
				label="Related Aggregate Id" 
				fieldValue="${tk:getFieldValue(toolkitData,relatedAggregatePath,'')}"  
				required="*" 
				defaultValue="" 
				size="20" 
				className="relatedAggregate_editor" 
				helptext="view_helptext|relatedaggregateid">
			</tk:input>	
		</c:if>
		
		<c:if test="${(viewClassValue=='dateFormat')}">		   
		   	<tk:input path="${displayFormatPath}" 
				label="Display Format" 
				fieldValue="${tk:getFieldValue(toolkitData,displayFormatPath,'')}" 
				required="*" 
				defaultValue="" 
				size="40" 
				className="displayFormat_editor" 
				helptext="view_helptext|displayformat">
			</tk:input>	
			
		   	<tk:input path="${storageFormatPath}" 
				label="Storage Format" 
				fieldValue="${tk:getFieldValue(toolkitData,storageFormatPath,'')}" 
				required="*" 
				defaultValue="" 
				size="40" 
				className="storageFormat_editor" 
				helptext="view_helptext|storageformat">
			</tk:input>		
		</c:if>
		

		<%-- If a new custom class blank out value --%>
		<c:if test="${viewClassValue=='custom'}">	
			<tk:input path="${customClassPath}"
				label="Class Name"
				fieldValue="${tk:getFieldValue(toolkitData, customClassPath, 'com.agencyport.domXML.view.View')}"
				required="*"
				defaultValue="com.agencyport.domXML.view.View"
				size="40"
				className="title_editor"
				helptext="view_helptext|viewClassName">
			</tk:input>
		</c:if>
		
		<tk:textarea path="${descriptionPath}"
				label="Description"
				fieldValue="${tk:getFieldValue(toolkitData,descriptionPath,'')}"
				required=""
				size="40"
				defaultValue=""
				className=""
				helptext="view_helptext|description">
		</tk:textarea>		
	</tk:tabContent>

	<tk:tabContent tabName="Used By" path="${path}" styleValue="display: none">
		<tk:displayPageSearch errorMsg="${pageData.fieldErrorMsg}">
			<jsp:include page="../../shared/palette/tdfCrossReferencePalette.jsp">
				<jsp:param name="entity" value="View" />
			</jsp:include>
		</tk:displayPageSearch>
	</tk:tabContent>

	<tk:tabContent tabName="Advanced" path="${path}" styleValue="display: none">

		<tk:select label="Delete Mode"
			path="${deletePath}"
			helptext="view_helptext|deletemode">
			${tk:getOptionsHTML(toolkitData, 'viewsDeleteMode',deletePath, '')}
		</tk:select>

		<c:if test="${(additionalJsp!='none')}">
		 	<jsp:include page="${additionalJsp}"/>
		 </c:if>
	</tk:tabContent>
</div>
