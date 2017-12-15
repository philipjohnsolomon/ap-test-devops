<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="fieldPath" value="${toolkitData.basePath}[${toolkitData.currentIndex}]"/>
<c:set var="fieldTitlePath" value="${fieldPath}.@title"/>
<c:set var="defaultPath" value="${fieldPath}.@id"/>
<c:set var="defaultTitle" value="${tk:getFieldValue(toolkitData, defaultPath, 'New Option List')}"/>
<c:set var="fieldValue" value="${tk:getFieldValue(toolkitData, fieldTitlePath, defaultTitle)}"/>
<tk:accordion fieldPath="${fieldPath}" action="loadEntry" className="optionList" fieldValue="${fieldValue}">
</tk:accordion>