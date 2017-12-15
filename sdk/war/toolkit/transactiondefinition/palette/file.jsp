<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="labelPath" value="${path}.@label"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="requiredPath" value="${path}.@required"/>
<c:set var="requiredValue" value="${tk:getFieldValue(toolkitData, requiredPath, 'false')}"/>
<c:set var="uniqueIdPath" value="${path}.@uniqueId"/>
<c:set var="readOnlyPath" value="${path}.@readonly"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>
<c:set var="htmlDefinitionIdPath" value="${path}.@htmlDefinitionId"/>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Corrections" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Impacted By" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="file"/>
			
		<tk:textarea path="${idPath}" 
			label="ID" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${idPath}"
			className="idCharacters" 
			helptext="fieldElement_helptext|id">
		</tk:textarea>	
		<tk:input path="${labelPath}" 
			label="Label" 
			fieldValue="${tk:getFieldValue(toolkitData,labelPath,'New File Field')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${labelPath}"
			className="title_editor change_event accordion_update" 
			helptext="fieldElement_helptext|label">
		</tk:input>	
		<tk:required
			path="${requiredPath}"
			value="${requiredValue}"
			className="change_event accordion_update">
		</tk:required>
		<tk:textarea path="${uniqueIdPath}" 
			label="Unique ID" 
			fieldValue="${tk:getFieldValue(toolkitData,uniqueIdPath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${uniqueIdPath}"
			className="idCharacters" 
			helptext="fieldElement_helptext|uniqueid">
		</tk:textarea>			
	</tk:tabContent>
	
	<tk:tabContent tabName="Corrections" path="${path}" styleValue="display: none">
		<jsp:include page="../palette/corrections/corrections.jsp" />
	</tk:tabContent>
	
	<tk:tabContent tabName="Impacted By" path="${path}" styleValue="display: none">	
		<tk:displayPageSearch errorMsg="">
			<jsp:include page="behaviorCrossRef.jsp">
				<jsp:param name="entity" value="Field Element" />
				<jsp:param name="field" value="true"/>
			</jsp:include>
		</tk:displayPageSearch>	
	</tk:tabContent>		
	
	<tk:tabContent tabName="Advanced" path="${path}" styleValue="display: none">						
		<tk:select label="Read Only" 
			path="${readOnlyPath}" 
			helptext="fieldElement_helptext|readonly">
			${tk:getOptionsHTML(toolkitData,'booleanFalse',readOnlyPath,'')}
		</tk:select>			
			
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
	</tk:tabContent>
</div>