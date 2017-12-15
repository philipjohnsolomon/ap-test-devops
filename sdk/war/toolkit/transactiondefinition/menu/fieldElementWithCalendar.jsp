<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="validationsPath" value="${path}.validation"/>

<div id="${path}_menu" style="" class="menu">
	<tkmenu:menuPill id="${path}_deletePill">
		<tkmenu:menuButton id="${path}_delete" title="Delete This Field" text="Delete" classname="deleteAction"/>
	</tkmenu:menuPill>
	<tkmenu:menuPill id="${path}_addPill">
		<tkmenu:menuDropDown title="Add a Field Helper" text="Add Field Helper" id="${path}_addFieldHelperActions">
			<tkmenu:menuOption id="${path}.fieldHelper_addBalloonFieldHelper" title="Add Ballon" text="Balloon" classname="addable view standard addNew"/>
			<tkmenu:menuOption id="${path}.fieldHelper_addDatePickerFieldHelper" title="Add Calendar" text="Calendar" classname="addable view standard addNew"/>
			<tkmenu:menuOption id="${path}.fieldHelper_addScriptFieldHelper" title="Add Script" text="Script" classname="addable view standard addNew"/>
		</tkmenu:menuDropDown>
		
		<jsp:include page="corrections/loadCorrectionsMenu.jsp" />
	
		<jsp:include page="validations/loadValidationMenu.jsp" />
	
	</tkmenu:menuPill>
			
	<tkmenu:menuPill id="${path}_movePill">
		<tkmenu:menuButton id="${path}_copyFieldElement" title="Copy this Field" text="Copy" classname="copy_event"/>
		<tkmenu:menuButton id="${path}_moveFieldElement" title="Move This Field" text="Move" classname="move_event"/>
	</tkmenu:menuPill>
</div>