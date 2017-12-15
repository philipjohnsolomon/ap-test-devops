<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="idPath" value="${path}.@id"/>
<c:set var="indexPath" value="${path}.@index"/>
<c:set var="relatedIndexPath" value="${path}.@relatedIndex"/>
<c:set var="styleClassPath" value="${path}.@styleClass"/>

<div id="${path}_palette" class="palette">
	<tk:tabs path="${path}">
		<tk:tab tabName="Options" focusOnLoad="true" path="${path}"></tk:tab>
		<tk:tab tabName="Advanced" focusOnLoad="false" path="${path}"></tk:tab>
	</tk:tabs>
	
	<tk:tabContent tabName="Options" path="${path}">
		<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
		<input type="hidden" name="${path}.@type" id="${path}.@type" value="index"/>
	
		<tk:input path="${idPath}" 
			label="ID" 
			fieldValue="${tk:getFieldValue(toolkitData,idPath,'')}"  
			required="" 
			defaultValue="" 
			size="40"
			className="idCharacters" 
			helptext="fieldElement_helptext|id">
		</tk:input>	

		<tk:textarea path="${indexPath}"
			label="Index"
			fieldValue="${tk:getFieldValue(toolkitData,indexPath,'')}"
			required="*"
			defaultValue=""
			size="40"
			elementName="${indexPath}"
			helptext="pageElement_helptext|index">
		</tk:textarea>
		
		<tk:textarea path="${relatedIndexPath}"
			label="Related Index"
			fieldValue="${tk:getFieldValue(toolkitData,relatedIndexPath,'')}"
			required="*"
			defaultValue=""
			size="40"
			elementName="${relatedIndexPath}"
			helptext="pageElement_helptext|relatedIndex">
		</tk:textarea>
		
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