<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="basePath" value="${toolkitData.basePath}"/>

<c:set var="viewType" value="${tk:getViewType(toolkitData, basePath, '')}"/>
<c:set var="deleteFieldPath" value="${basePath}.deleteField" />
<c:set var="fieldPath" value="${basePath}.field" />
<c:set var="searchPath" value="${basePath}.@searchId" />
<c:set var="treatSearchIdAsRegexPath" value="${basePath}.@treatSearchIdAsRegex" />

<div id="${basePath}_wrapperDiv" class="fieldSet">  
	<fieldset id="${basePath}" >
		<legend id="${basePath}_legend" class="fieldSet_legend"> 
			Instruction Set
		</legend>
		
		<input type="hidden" name="${basePath}.@delete" id="${basePath}.@delete" value="" />
		<div id="${basePath}.field_container">
	
			<c:if test="${viewType=='mutuallyExclusiveFieldSets'}">
				<tk:input label="If this value is found" 
							required="" 
							path="${searchPath}" 
							className="required field_toggle" 
							defaultValue="" 
							fieldValue="${tk:getFieldValue(toolkitData, searchPath, '')}"
							size="40">
				</tk:input>
				<tk:select path="${treatSearchIdAsRegexPath}" label="Treat value as Regular Expression?"
					elementName="${treatSearchIdAsRegexPath}">
					<c:out
						value="${tk:getOptionsHTML(toolkitData, 'boolean', treatSearchIdAsRegexPath, '')}" escapeXml="false" />
				</tk:select>
			</c:if>
			
			<c:forEach var="index" begin="1" step="1" end="${tk:getCount(toolkitData, fieldPath)}">
				<jsp:setProperty property="currentIndex" name="toolkitData" value="${index - 1}"/>
				<jsp:setProperty property="basePath" name="toolkitData" value="${fieldPath}[${index-1}]"/>
				<jsp:include page="field.jsp"/>	
			</c:forEach>
		</div>
		
		<div id="${basePath}.deleteField_container" >
			<c:forEach var="deleteFieldIndex" begin="1" step="1" end="${tk:getCount(toolkitData, deleteFieldPath)}">
				<jsp:setProperty property="basePath" name="toolkitData" value="${deleteFieldPath}[${deleteFieldIndex-1}]"/>
				<jsp:include page="deleteField.jsp" />	
			</c:forEach>
		</div>
	</fieldset>
</div>  
