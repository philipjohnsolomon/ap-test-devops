<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="labelPath" value="${path}.@label"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="requiredPath" value="${path}.@required"/>
<c:set var="requiredValue" value="${tk:getFieldValue(toolkitData, requiredPath, 'false')}"/>
<c:set var="defaultValuePath" value="${path}.@defaultValue"/>
<c:set var="uniqueIdPath" value="${path}.@uniqueId"/>
<c:set var="readOnlyPath" value="${path}.@readonly"/>
<c:set var="groupIdPath" value="${path}.@groupId"/>
<c:set var="hopelessPath" value="${path}.@hopeless"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>
<c:set var="splitPath" value="${fn:split(path, '.')}"/>
<c:set var="pageTypePath" value="${splitPath[0]}.@type"/>
<c:set var="pageType" value="${tk:getFieldValue(toolkitData, pageTypePath, '')}"/>
<c:set var="viewIdPath" value="${path}.@viewId"/>
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
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="hidden"/>
		
		<tk:textarea path="${idPath}" 
			label="Saves To" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'Saves To Path')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${idPath}"
			className="idCharacters change_event accordion_update" 
			helptext="fieldElement_helptext|savesto">
		</tk:textarea>				
		<tk:textarea path="${defaultValuePath}" 
			label="Default Value" 
			fieldValue="${tk:getFieldValue(toolkitData,defaultValuePath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${defaultValuePath}"
			className="idCharacters" 
			helptext="fieldElement_helptext|defaultvalue">
		</tk:textarea>	
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
						
		<c:if test="${pageType == 'roster'}">	
			<c:set var="firstTimeDefaultPath" value="${path}.@firstTimeDefaultValue"/>
			<c:set var="copyPath" value="${path}.@copy"/>
			
			<tk:textarea path="${firstTimeDefaultPath}" 
				label="Default Value First Roster Entry" 
				fieldValue="${tk:getFieldValue(toolkitData,firstTimeDefaultPath,'')}"  
				required="" 
				defaultValue="" 
				size="40"
				elementName="${firstTimeDefaultPath}"
				className="idCharacters" 
				helptext="fieldElement_helptext|defaultvaluefirstrosterentry">
			</tk:textarea>			
			<tk:select label="Copy Field During Roster Copy" 
				path="${copyPath}" 
				helptext="fieldElement_helptext|readonly">
				${tk:getOptionsHTML(toolkitData,'booleanTrue',copyPath,'')}
			</tk:select>	
		</c:if>
		
		<tk:select label="Repair Validation Error" 
			path="${hopelessPath}" 
			helptext="fieldElement_helptext|repairvalidationerror">
			${tk:getOptionsHTML(toolkitData,'booleanFalse',hopelessPath,'')}
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