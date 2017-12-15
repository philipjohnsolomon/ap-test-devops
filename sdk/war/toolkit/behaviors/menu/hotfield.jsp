<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="${param.path}_menu" style="" class="menu">
	<tkmenu:menuPill id="${param.path}_deletePill">
		<tkmenu:menuButton id="${param.path}_delete" title="Delete This Hotfield" text="Delete" classname="deleteAction"/>
	</tkmenu:menuPill>
</div>