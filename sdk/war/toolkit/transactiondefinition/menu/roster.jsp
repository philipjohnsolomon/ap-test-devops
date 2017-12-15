<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="${param.path}_menu" style="" class="menu pageElement">
	<tk:menuPill id="${param.path}_deletePill">
		<tk:menuButton id="${param.path}_delete" title="Delete This Field" text="Delete" classname="deleteAction"/>
	</tk:menuPill>
	
	<tk:menuPill id="${param.path}_addRosters">
		<tk:menuButton id="${param.path}.joinInfo_addJoin" title="Add Join" text="Add Join" classname="addNew"/>
		<tk:menuButton id="${param.path}.fieldElement_addColumn" title="Add Column" text="Add Column" classname="addNew"/>
	</tk:menuPill>		
</div>