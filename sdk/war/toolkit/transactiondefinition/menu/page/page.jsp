<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<div id="${param.path}_menu" style="" class="menu pageElement">

	<tk:menuPill id="${param.path}_deletePill">
		<tk:menuButton id="${param.path}_delete" title="Delete This Page" text="Delete" classname="deleteAction"/>
	</tk:menuPill>
	
	<tk:menuPill id="${param.path}_movePill">
		<tk:menuButton id="${param.path}_movePage" title="Move This Page" text="Move" classname="move_event"/>
	</tk:menuPill>
		
</div>
