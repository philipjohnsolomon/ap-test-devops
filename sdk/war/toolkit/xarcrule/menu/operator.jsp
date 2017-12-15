<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<div id="${param.path}_menu" style="" class="menu">
	<tk:menuPill id="${toolkitData.basePath}_deleteMenuPill">
		<tk:menuButton id="${toolkitData.basePath}_delete" title="Delete This Condition" text="Delete" classname="deleteAction condition"/>
	</tk:menuPill>
</div>