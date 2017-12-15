<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="${param.artifactId}_menu" style="" class="menu">

	<tk:menuPill id="${param.artifactId}_deletePill">
		<tk:menuButton id="${param.artifactId}_delete" title="Delete This Option List File" text="Delete" classname="deleteArtifact"/>
	</tk:menuPill>
	<tk:menuPill id="${param.artifactId}_searchPill">
		<tk:menuButton id="${param.artifactId}_search" title="Search" text="Search" classname="search"/>
	</tk:menuPill>
	<tk:menuPill id="${param.artifactId}_codeListPill">
		<tk:menuButton id="${param.artifactId}_addOptionList" text="Add Option List" title="New Option List" classname="solo addable addNew"/>
	</tk:menuPill>
</div>