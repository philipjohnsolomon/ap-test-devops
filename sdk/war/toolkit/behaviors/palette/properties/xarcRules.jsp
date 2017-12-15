<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="xarcRulesPath" value="${path}.xarcRules"/>
<c:set var="ruleLibPath" value="${xarcRulesPath}.@ruleLibraryId"/>		
<c:set var="idPath" value="${xarcRulesPath}.@id"/>
<c:set var="idValue" value="${tk:getFieldValue(toolkitData,idPath,'')}"/>
<c:set var="rulePath" value="${xarcRulesPath}.@ruleId"/>
<c:set var="ruleValue" value="${tk:getFieldValue(toolkitData,rulePath,'')}"/>
<c:set var="removePath" value="${xarcRulesPath}.@remove"/>
		
	<div>
		<tk:input fieldValue="${idValue}" defaultValue="${idValue}" label="ID" path="${idPath}" size="20"/>
		<tk:select label="Rule Library Title" path="${ruleLibPath}" className="change_event refreshXarcRulesList" required="*">
			<c:out value="${RULELIBRARY}" escapeXml="false"/>
		</tk:select>
		<tk:select label="Rule Title" path="${rulePath}" required="*" >
			<c:out value="${RULELIBRARYOPTIONS}" escapeXml="false"/>
		</tk:select>
		<tk:select label="Remove" path="${removePath}" >
			<c:out value="${tk:getOptionsHTML(toolkitData, 'noYes', removePath, '')}" escapeXml="false"/>
		</tk:select>
	</div>