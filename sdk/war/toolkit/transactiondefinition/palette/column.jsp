<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="labelPath" value="${path}.@label"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="maxLengthPath" value="${path}.@maxLength"/>
<c:set var="lookupSourcePath" value="${path}.@lookupSource"/>
<c:set var="viewIdPath" value="${path}.@viewId"/>
<c:set var="uniqueIdPath" value="${path}.@uniqueId"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>

<div id="${path}_palette" class="palette">

	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Corrections" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Impacted By" focusOnLoad="false" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>

	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="column"/>
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		
		<tk:input path="${path}.@title" 
			label="Label" 
			fieldValue="${tk:getFieldValue(toolkitData,labelPath,'')}"  
			required="*" 
			defaultValue="New Column"
			size="20"
			elementName="${labelPath}"
			className="title_editor change_event accordion_update"  
			helptext="fieldElement_helptext|rosterlabel">
		</tk:input>				
		<tk:textarea path="${idPath}" 
			label="Field Path" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"  
			required="*" 
			defaultValue="" 
			size="40"
			elementName="${idPath}"
			className="idCharacters" 
			helptext="fieldElement_helptext|rosterfieldpath">
		</tk:textarea>
		<tk:input path="${maxLengthPath}" 
			label="Column Max Length" 
			fieldValue="${tk:getFieldValue(toolkitData,maxLengthPath,'')}"  
			required="*" 
			defaultValue="20" 
			className="numeric"
			size="20"
			helptext="fieldElement_helptext|columnmaxlength">
		</tk:input>		
		<tk:textarea path="${lookupSourcePath}" 
			label="Option List Path" 
			fieldValue="${tk:getFieldValue(toolkitData,lookupSourcePath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			elementName="${lookupSourcePath}"
			helptext="fieldElement_helptext|optionlistpath">
		</tk:textarea>	
		<tk:select label="View Id" 
			path="${viewIdPath}"
			helptext="fieldElement_helptext|viewid">
			<c:out value="${viewResults}" escapeXml="false"/>
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
		<tk:input path="${styleClassPath}" 
			label="Style Class" 
			fieldValue="${tk:getFieldValue(toolkitData,styleClassPath,'')}"  
			required="" 
			defaultValue="" 
			size="40">
		</tk:input>
	</tk:tabContent>
</div>