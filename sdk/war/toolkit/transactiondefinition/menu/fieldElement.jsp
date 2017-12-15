<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="typePath" value="${path}.@type"/>
<c:set var="type" value="${tk:getFieldValue(toolkitData,typePath,'')}"/>

<div id="${path}_menu" style="" class="menu">

	<tkmenu:menuPill id="${path}_deletePill">
		<tkmenu:menuButton id="${path}_delete" title="Delete This Field" text="Delete" classname="deleteAction"/>
	</tkmenu:menuPill>
	<tkmenu:menuPill id="${path}_addPill">
		<c:if test="${type == 'selectlist' || type == 'filterlist' || type == 'radio'}">
    		<tkmenu:menuDropDown title="Add Values" text="Add Values" id="${path}_addValuesActions">
				<tkmenu:menuOption id="${path}_addXmlReader" title="Add XML Reader List" text="XML Reader" classname="addNew"/>
				<tkmenu:menuOption id="${path}_addDynamic" title="Add Dynamic List Template" text="Dynamic" classname="addNew"/>
				<tkmenu:menuOption id="${path}_addCustomList" title="Add Custom List" text="Custom" classname="addNew"/>
			</tkmenu:menuDropDown>
		</c:if> 
		
		<tkmenu:menuDropDown title="Add a Field Helper" text="Add Field Helper" id="${path}_addFieldHelperActions">
			<tkmenu:menuOption id="${path}.fieldHelper_addBalloonFieldHelper" title="Add Ballon" text="Balloon" classname="addNew"/>
			<tkmenu:menuOption id="${path}.fieldHelper_addScriptFieldHelper" title="Add Script" text="Script" classname="addNew"/>
		</tkmenu:menuDropDown>
		
		<jsp:include page="corrections/loadCorrectionsMenu.jsp" />

		<jsp:include page="validations/loadValidationMenu.jsp" />

	</tkmenu:menuPill>
	
	<tkmenu:menuPill id="${path}_movePill">
		<tkmenu:menuButton id="${path}_copyFieldElement" title="Copy this Field" text="Copy" classname="copy_event"/>
		<tkmenu:menuButton id="${path}_moveFieldElement" title="Move This Field" text="Move" classname="move_event"/>
	</tkmenu:menuPill>	
</div>