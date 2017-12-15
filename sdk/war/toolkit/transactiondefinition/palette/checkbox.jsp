<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="labelPath" value="${path}.@label"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="uniqueIdPath" value="${path}.@uniqueId"/>
<c:set var="checkedValuePath" value="${path}.@checkedValue"/>
<c:set var="uncheckedValuePath" value="${path}.@uncheckedValue"/>
<c:set var="checkedDisplayValuePath" value="${path}.@checkedDisplayValue"/>
<c:set var="uncheckedDisplayValuePath" value="${path}.@uncheckedDisplayValue"/>
<c:set var="groupIdPath" value="${path}.@groupId"/>
<c:set var="viewIdPath" value="${path}.@viewId"/>
<c:set var="htmlDefinitionIdPath" value="${path}.@htmlDefinitionId"/>
<c:set var="readOnlyPath" value="${path}.@readonly"/>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Impacted By" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Corrections" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>
	
	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="checkbox"/>
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		<tk:input path="${labelPath}" 
			label="Label" 
			fieldValue="${tk:getFieldValue(toolkitData, labelPath, 'New Checkbox Field')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${labelPath}"
			className="title_editor change_event accordion_update" 
			helptext="fieldElement_helptext|label">
		</tk:input>			
		<tk:textarea path="${idPath}" 
			label="Saves To" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${idPath}"
			className="idCharacters" 
			helptext="fieldElement_helptext|savesto">
		</tk:textarea>	
		<tk:textarea path="${checkedValuePath}" 
			label="Checked Value" 
			fieldValue="${tk:getFieldValue(toolkitData,checkedValuePath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${checkedValuePath}"
			className="" 
			helptext="">
		</tk:textarea>
		<tk:textarea path="${uncheckedValuePath}" 
			label="Unchecked Value" 
			fieldValue="${tk:getFieldValue(toolkitData,uncheckedValuePath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${uncheckedValuePath}"
			className="" 
			helptext="">
		</tk:textarea>
		<tk:textarea path="${checkedDisplayValuePath}" 
			label="Checked Display Value" 
			fieldValue="${tk:getFieldValue(toolkitData,checkedDisplayValuePath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${checkedDisplayValuePath}"
			className="" 
			helptext="">
		</tk:textarea>
		<tk:textarea path="${uncheckedDisplayValuePath}" 
			label="Unchecked Display Value" 
			fieldValue="${tk:getFieldValue(toolkitData,uncheckedDisplayValuePath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${uncheckedDisplayValuePath}"
			className="" 
			helptext="">
		</tk:textarea>
		<tk:select label="Read Only" 
			path="${readOnlyPath}" 
			helptext="fieldElement_helptext|readonly">
			${tk:getOptionsHTML(toolkitData,'booleanFalse',readOnlyPath,'')}
		</tk:select>
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
	
	<tk:tabContent tabName="Impacted By" path="${path}" styleValue="display: none">	
		<tk:displayPageSearch errorMsg="">
			<jsp:include page="behaviorCrossRef.jsp">
				<jsp:param name="entity" value="Field Element" />
				<jsp:param name="field" value="true"/>
			</jsp:include>
		</tk:displayPageSearch>	
	</tk:tabContent>
	
	<tk:tabContent tabName="Corrections" path="${path}" styleValue="display: none">
		<jsp:include page="../palette/corrections/corrections.jsp" />
	</tk:tabContent>
	
	<tk:tabContent tabName="Advanced" path="${path}" styleValue="display: none">
			
		<tk:select label="View Id" 
			path="${viewIdPath}"
			helptext="fieldElement_helptext|viewid">
			<c:out value="${viewResults}" escapeXml="false"/>
		</tk:select>
		<tk:textarea path="${groupIdPath}" 
			label="Group ID" 
			fieldValue="${tk:getFieldValue(toolkitData,groupIdPath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${groupIdPath}"
			className="idCharacters" 
			helptext="fieldElement_helptext|groupid">
		</tk:textarea>
		<tk:input path="${htmlDefinitionIdPath}" 
			label="HTML Definition Id" 
			fieldValue="${tk:getFieldValue(toolkitData,htmlDefinitionIdPath,'')}"  
			required="" 
			defaultValue="" 
			size="40">
		</tk:input>
	</tk:tabContent>
</div>