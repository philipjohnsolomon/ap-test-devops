<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<div id="${param.artifactId}_menu" style="" class="menu">
	<tk:menuPill id="${param.artifactId}_behaviorPill">
		<tk:menuButton id="${param.artifactId}_delete" title="Delete This Arc Rules Library" text="Delete" classname="deleteArtifact"/>
	</tk:menuPill>
	<tk:menuPill id="${param.artifactId}_searchPill">
		<tk:menuButton id="${param.artifactId}_search" title="Search" text="Search" classname="search"/>
	</tk:menuPill>
	<tk:menuPill id="${param.artifactId}_xarcRulePill">
		<tk:menuButton id="rule_addRule" title="Add Rule" text="Add Rule" classname="addable addNew"/>
	</tk:menuPill>
</div>	