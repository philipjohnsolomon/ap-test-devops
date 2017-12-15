<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>
<c:set var="messagePath" value="${path}.@content"/>
<c:set var="htmlDefinitionIdPath" value="${path}.@htmlDefinitionId"/>
<c:set var="encodePath" value="${path}.@encode"/>

<div id="${path}_palette" class="palette">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Impacted By" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Corrections" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>
	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="message"/>
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
			
		<tk:input path="${idPath}" 
			label="ID" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"  
			required="" 
			defaultValue="" 
			size="40" 
			className="idCharacters" 
			helptext="fieldElement_helptext|id">
		</tk:input>	
		<tk:textarea path="${messagePath}" 
			label="Message" 
			fieldValue="${tk:getFieldValue(toolkitData,path,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${path}"
			className="title_editor change_event accordion_update" 
			helptext="fieldElement_helptext|message">
		</tk:textarea>
	</tk:tabContent>
	
	<tk:tabContent tabName="Impacted By" path="${path}" styleValue="display: none">	
		<tk:displayPageSearch errorMsg="">
			<jsp:include page="behaviorCrossRef.jsp">
				<jsp:param name="entity" value="Field Element" />
				<jsp:param name="field" value="true"></jsp:param>	
			</jsp:include>
		</tk:displayPageSearch>	
	</tk:tabContent>
			
	<tk:tabContent tabName="Corrections" path="${path}" styleValue="display: none">
		<jsp:include page="../palette/corrections/corrections.jsp" />
	</tk:tabContent>
	
	<tk:tabContent tabName="Advanced" path="${path}" styleValue="display: none">
		<tk:input path="${styleClassPath}" 
			label="Style Class" 
			fieldValue="${tk:getFieldValue(toolkitData,styleClassPath,'')}"  
			required="" 
			defaultValue="" 
			size="40">
		</tk:input>
		<tk:input path="${htmlDefinitionIdPath}" 
			label="HTML Definition Id" 
			fieldValue="${tk:getFieldValue(toolkitData,htmlDefinitionIdPath,'')}"  
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