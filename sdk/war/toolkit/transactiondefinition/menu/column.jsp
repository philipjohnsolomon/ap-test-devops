<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>

<div id="${param.path}_menu" style="" class="menu">
	<jsp:include page="leafDelete.jsp"/>
	
	<tkmenu:menuPill id="${param.path}_addPill">
		<jsp:include page="corrections/loadCorrectionsMenu.jsp" />
	</tkmenu:menuPill>
</div>