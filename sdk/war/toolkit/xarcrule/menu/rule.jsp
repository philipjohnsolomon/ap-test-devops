<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>

<div id="${path}_menu" style="" class="menu">
	<tkmenu:menuPill id="${path}_rulePill">
		<tkmenu:menuButton id="${path}_delete" title="Delete This Arc Rule" text="Delete" classname="deleteAction"/>
	</tkmenu:menuPill>
	
	<tkmenu:menuPill id="${path}_copyrulePill">
		<tkmenu:menuButton id="${path}_copyRule" title="Copy Rule" text="Copy Rule" classname="copy_event"/>
	</tkmenu:menuPill>

	<tkmenu:menuPill id="${path}_movePill">
		<tkmenu:menuButton id="${path}_rule_move" title="Move This Rule" text="Move" classname="move_event"/>
	</tkmenu:menuPill>

</div>	