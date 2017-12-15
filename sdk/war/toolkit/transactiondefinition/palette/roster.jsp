<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="legendPath" value="${path}.@legend"/>
<c:set var="emptyRosterMessagePath" value="${path}.emptyRosterMessage"/>
<c:set var="minEntriesPath" value="${path}.@minEntries"/>
<c:set var="minEntriesMessagePath" value="${path}.@minEntriesMessage"/>
<c:set var="maxEntriesPath" value="${path}.@maxEntries"/>
<c:set var="maxEntriesMessagePath" value="${path}.@maxEntriesMessage"/>
<c:set var="customRosterReaderClassNamePath" value="${path}.@customRosterReaderClassName"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>
<c:set var="hopelessPath" value="${path}.@hopeless"/>
<c:set var="enableRecoverPath" value="${path}.@enableRecover"/>
<c:set var="dataFilterPath" value="${path}.@dataFilter"/>
<c:set var="htmlDefinitionIdPath" value="${path}.@htmlDefinitionId"/>

<div id="${path}_palette" class="palette">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Impacted By" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="roster"/>
			
		<tk:input path="${path}.@title" 
			label="Legend" 
			fieldValue="${tk:getFieldValue(toolkitData,legendPath,'New Roster')}"  
			required="*" 
			defaultValue="" 
			size="20"
			elementName="${legendPath}"
			className="title_editor change_event accordion_update"
			helptext="pageElement_helptext|legend">
		</tk:input>
		<tk:input path="${idPath}" 
			label="ID" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'New ID')}"  
			required="*" 
			defaultValue="" 
			size="40"
			className="idCharacters" 
			helptext="pageElement_helptext|id">
		</tk:input>	
		<tk:textarea path="${emptyRosterMessagePath}" 
			label="Message" 
			fieldValue="${tk:getFieldValue(toolkitData,emptyRosterMessagePath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${legendPath}"
			className="title_editor" 
			helptext="pageElement_helptext|emptyrostermessage">
		</tk:textarea>		
	</tk:tabContent>
	
	<tk:tabContent tabName="Impacted By" path="${path}" styleValue="display: none;">
		<jsp:include page="behaviorCrossRef.jsp" >
			<jsp:param name="entity" value="Page Element"></jsp:param>
		</jsp:include>
	</tk:tabContent>
	
	<tk:tabContent tabName="Advanced" path="${path}" styleValue="display: none;">		
		<tk:input path="${minEntriesPath}" 
			label="Minimum Entries" 
			fieldValue="${tk:getFieldValue(toolkitData,minEntriesPath,'0')}"  
			required="*" 
			defaultValue="" 
			size="20"
			helptext="pageElement_helptext|minimumentries">
		</tk:input>	
		<tk:textarea path="${minEntriesMessagePath}" 
			label="Minimum Entries Message" 
			fieldValue="${tk:getFieldValue(toolkitData,minEntriesMessagePath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			helptext="pageElement_helptext|minimumentriesmessage">
		</tk:textarea>				
		<tk:input path="${maxEntriesPath}" 
			label="Maximum Entries" 
			fieldValue="${tk:getFieldValue(toolkitData,maxEntriesPath,'1000')}"  
			required="" 
			defaultValue="" 
			size="20"
			helptext="pageElement_helptext|maximumentries">
		</tk:input>		
		<tk:textarea path="${maxEntriesMessagePath}" 
			label="Maximum Entries Message" 
			fieldValue="${tk:getFieldValue(toolkitData,maxEntriesMessagePath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			helptext="pageElement_helptext|maximumentries">
		</tk:textarea>						
		<tk:textarea path="${customRosterReaderClassNamePath}" 
			label="Custom Roster Reader ClassName" 
			fieldValue="${tk:getFieldValue(toolkitData,customRosterReaderClassNamePath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			helptext="pageElement_helptext|customrosterreaderclassname">
		</tk:textarea>				
		<tk:textarea path="${dataFilterPath}" 
			label="Roster Filter" 
			fieldValue="${tk:getFieldValue(toolkitData,dataFilterPath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			helptext="pageElement_helptext|rosterfilter">
		</tk:textarea>									
		<tk:select label="Enable Recover" 
			path="${enableRecoverPath}" 
			helptext="pageElement_helptext|enablerecover">
			${tk:getOptionsHTML(toolkitData, 'booleanTrue', enableRecoverPath, '')}
		</tk:select>				
		<tk:select label="Repair Validation Error" 
			path="${hopelessPath}" 
			helptext="pageElement_helptext|repairvalidationerror">
			${tk:getOptionsHTML(toolkitData, 'booleanFalse', hopelessPath, '')}
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