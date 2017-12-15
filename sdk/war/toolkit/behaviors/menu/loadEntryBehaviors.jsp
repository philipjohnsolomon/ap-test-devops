<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>

<div id="${param.path}_menu" style="" class="menu">
	<tk:menuPill id="${param.artifactId}_searchPill">
		<tk:menuButton id="${param.artifactId}_search" title="Search" text="Search" classname="search"/>
	</tk:menuPill>
	<tk:menuPill id="${param.path}_loadEntryBehaviorsPill">
		<tk:menuButton id="${param.path}_addBehavior" title="Add New Behavior" classname="addNew addBehavior" text="Add Behavior" />
	</tk:menuPill>
</div>