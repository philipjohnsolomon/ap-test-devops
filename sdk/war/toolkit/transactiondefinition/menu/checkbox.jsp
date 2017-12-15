<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<div id="${param.path}_menu" style="" class="menu">
	<jsp:include page="leafDelete.jsp"/>

	<tk:menuPill id="${param.path}_addPill">
		<tk:menuDropDown title="Add a Field Helper" text="Add Field Helper" id="${param.path}_addFieldHelperActions">
			<tk:menuOption id="${param.path}.fieldHelper_addBalloonFieldHelper" title="Add Ballon" text="Balloon" classname="addNew"/>
			<tk:menuOption id="${param.path}.fieldHelper_addScriptFieldHelper" title="Add Script" text="Script" classname="addNew"/>
		</tk:menuDropDown>
		<jsp:include page="corrections/loadCorrectionsMenu.jsp" />
	</tk:menuPill>
	<tk:menuPill id="${param.path}_movePill">
		<tk:menuButton id="${param.path}_copyFieldElement" title="Copy this Checkbox" text="Copy" classname="copy_event"/>
		<tk:menuButton id="${param.path}_moveFieldElement" title="Move This Checkbox" text="Move" classname="move_event"/>
	</tk:menuPill>	
</div>