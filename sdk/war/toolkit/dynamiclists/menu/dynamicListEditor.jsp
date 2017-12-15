<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<div id="${param.artifactId}_menu" style="" class="menu">

	<tk:menuPill id="${param.artifactId}_deletePill">
		<tk:menuButton id="${param.artifactId}_delete" title="Delete This Dynamic List File" text="Delete" classname="deleteArtifact"/>
	</tk:menuPill>
	<tk:menuPill id="${param.artifactId}_searchPill">
		<tk:menuButton id="${param.artifactId}_search" title="Search" text="Search" classname="search"/>
	</tk:menuPill>
	<tk:menuPill id="${param.artifactId}_dynamicListsPill">
		<tk:menuButton id="dynamicListTemplate_addDynamicList" title="New Dynamic List" text="Add Dynamic List" classname="solo addable addNew"/>
	</tk:menuPill>
</div>