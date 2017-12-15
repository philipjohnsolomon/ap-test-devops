<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="agencyportal" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="activeUserSectionPath" value="section[@type=\"activeUsers\"]"/>
<c:set var="activeUserCount" value="${tk:getCount(toolkitData, activeUserSectionPath)}"/>
<c:set var="activeUserSectionDeletedPath" value="section[@deleteWIAUser=\"true\"]"/>
<c:set var="activeUserDeleteCount" value="${tk:getCount(toolkitData, activeUserSectionDeletedPath)}"/>
<c:set var="netActiveUserCount" value="${activeUserCount - activeUserDeleteCount}"/>

<c:set var="sectionPath" value="section"/>
<c:set var="sectionCount" value="${tk:getCount(toolkitData, sectionPath)}"/>
<c:set var="sectionDeletedPath" value="section[@deleteWIA=\"true\"]"/>
<c:set var="sectionDeletedCount" value="${tk:getCount(toolkitData, sectionDeletedPath)}"/>
<c:set var="netSectionCount" value="${sectionCount - sectionDeletedCount}"/>

<c:set var="typePath" value="${param.path}.@type"/>
<c:set var="type" value="${tk:getFieldValue(toolkitData, typePath, '')}"/>


<div id="${param.path}_menu" style="" class="menu section_menu">

	<agencyportal:menuPill id="${param.path}_deletePill">
		<agencyportal:menuButton id="${param.path}_delete" title="Delete this section" text="Delete Section" classname="deleteAction"/>
	</agencyportal:menuPill>
	<c:if test="${type != 'activeUsers'}">
		<agencyportal:menuPill id="${param.path}_copyPill">
			<agencyportal:menuButton id="${param.path}_copySection" title="Copy this section" text="Copy" classname="copy_event"/>
		</agencyportal:menuPill>
	</c:if>
	
	<c:if test="${netSectionCount > 1}">
		<agencyportal:menuPill id="${param.path}_movePill">
			<agencyportal:menuButton id="${param.path}_moveSection" title="Move this section" text="Move" classname="move_event"/>
		</agencyportal:menuPill>
	</c:if>
	<agencyportal:menuPill id="${param.path}_codeListPill">
		<tkmenu:menuDropDown title="Add Section" text="Add Section" id="${param.path}_addSectionList">
			<tkmenu:menuOption id="${param.path}_addComments" title="Comments" text="Comments" classname="addable addNew"/>
			<tkmenu:menuOption id="${param.path}_addFileAttachments" title="File Attachments" text="File Attachments" classname="addable addNew"/>
			<c:if test="${netActiveUserCount == '0'}">	
				<tkmenu:menuOption id="${param.path}_addActiveUsers" title="Other Active Users" text="Other Active Users" classname="addable addNew"/>			
			</c:if>			
		</tkmenu:menuDropDown>	
	</agencyportal:menuPill>
</div>