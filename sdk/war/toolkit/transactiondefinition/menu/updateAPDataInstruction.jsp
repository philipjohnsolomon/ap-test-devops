<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>

<div id="${param.path}_menu" style="" class="menu">
	<jsp:include page="leafDelete.jsp"/>
		
	<tk:menuPill id="${param.path}_movePill">
		<tk:menuButton id="${param.path}_moveInstruction" title="Move This Page" text="Move" classname="move_event"/>
	</tk:menuPill>
</div>