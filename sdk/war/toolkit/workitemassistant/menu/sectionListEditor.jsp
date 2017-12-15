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

<div id="${param.artifactId}_menu" style="" class="menu initial_section_menu">

	<agencyportal:menuPill id="${param.artifactId}_deletePill">
		<agencyportal:menuButton id="${param.artifactId}_delete" title="Delete This Work Item Assistant" text="Delete" classname="deleteArtifact"/>
	</agencyportal:menuPill>
	<agencyportal:menuPill id="${param.artifactId}_codeListPill">
		<tkmenu:menuDropDown title="Add Section" text="Add Section" id="${param.artifactId}_addSectionList">
			<tkmenu:menuOption id="${param.artifactId}_addComments" title="Comments" text="Comments" classname="addable addNew"/>
			<tkmenu:menuOption id="${param.artifactId}_addFileAttachments" title="File Attachments" text="File Attachments" classname="addable addNew"/>
			<c:if test="${netActiveUserCount == '0'}">	
				<tkmenu:menuOption id="${param.artifactId}_addActiveUsers" title="Other Active Users" text="Other Active Users" classname="addable addNew"/>			
			</c:if>			
		</tkmenu:menuDropDown>	
	</agencyportal:menuPill>
</div>