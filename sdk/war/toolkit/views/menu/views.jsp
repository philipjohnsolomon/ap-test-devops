<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="standardHelptext" value="${tk:getOptionsListValue('view_helptext', 'standard')}"/>
<c:set var="aebHelptext" value="${tk:getOptionsListValue('view_helptext', 'aggregateexistsboolean')}"/>
<c:set var="remarksHelptext" value="${tk:getOptionsListValue('view_helptext', 'remarks')}"/>
<c:set var="dateformatHelptext" value="${tk:getOptionsListValue('view_helptext', 'dateformat')}"/>
<c:set var="uppercaseHelptext" value="${tk:getOptionsListValue('view_helptext', 'uppercase')}"/>
<c:set var="transformsinglevalueHelptext" value="${tk:getOptionsListValue('view_helptext', 'transformsinglevalue')}"/>
<c:set var="mutexHelptext" value="${tk:getOptionsListValue('view_helptext', 'mutuallyexclusive')}"/>

<div id="${param.artifactId}_menu" style="" class="menu">
	<tkmenu:menuPill id="${param.artifactId}_deletePill">
		<tkmenu:menuButton id="${param.artifactId}_delete" title="Delete This Set of Views" text="Delete" classname="deleteArtifact"/>
	</tkmenu:menuPill>
	<tkmenu:menuPill id="${param.artifactId}_searchPill">
		<tkmenu:menuButton id="${param.artifactId}_search" title="Search" text="Search" classname="search"/>
	</tkmenu:menuPill>
	<tkmenu:menuPill id="${param.path}_addPill">
		<tkmenu:menuDropDown title="Add Standard View" text="Add Standard View" id="${param.path}_addables[0]">
			
			<tkmenu:menuOption id="view_standard-basic" title="${standardHelptext}" text="Standard" classname="addable addNew"/>
			<tkmenu:menuOption id="view_standard-aggregateExistsBoolean" title="${aebHelptext}" text="Aggregate Exists Boolean" classname="addable addNew"/>
			<tkmenu:menuOption id="view_standard-remarks" title="${remarksHelptext}" text="Remarks" classname="addable addNew"/>
			<tkmenu:menuOption id="view_standard-dateFormat" title="${dateformatHelptext}" text="Date Format" classname="addable addNew"/>
			<tkmenu:menuOption id="view_standard-custom" title="Custom" text="Custom" classname="addable addNew"/>
			
		</tkmenu:menuDropDown>
		<tkmenu:menuDropDown title="Add Mutually Exclusive Fieldsets" text="Add Mutually Exclusive Fieldsets" id="${param.path}_addables[1]">
		
			<tkmenu:menuOption id="view_mutuallyExclusiveFieldSets-basic" title="${mutexHelptext}" text="Standard" classname="addable addNew"/>
			<tkmenu:menuOption id="view_mutuallyExclusiveFieldSets-custom" title="Custom Exclusive Field Sets" text="Custom" classname="addable addNew"/>
			
		</tkmenu:menuDropDown>
		<tkmenu:menuDropDown title="Add Display View" text="Add Display View" id="${param.path}_addables[2]">
		
			<tkmenu:menuOption id="view_display-basic" title="Standard Display View" text="Standard" classname="addable addNew"/>
			<tkmenu:menuOption id="view_display-custom" title="Custom Display View" text="Custom" classname="addable addNew"/>
			
		</tkmenu:menuDropDown>
	</tkmenu:menuPill>
</div>