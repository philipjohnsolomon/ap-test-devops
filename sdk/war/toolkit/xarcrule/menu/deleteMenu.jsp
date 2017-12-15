<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>

<div id="${param.path}_menu" style="" class="menu">
	<tk:menuPill id="${param.path}_deleteMenuPill">
		<tk:menuButton id="${param.path}_delete" title="${param.title}" text="Delete" classname="deleteAction ${param.entityType}"/>
	</tk:menuPill>
</div>	