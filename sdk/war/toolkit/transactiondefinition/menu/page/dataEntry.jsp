<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<div id="${param.path}_menu" style="" class="menu">
	<tk:menuPill id="${param.path}_deletePill">
		<tk:menuButton id="${param.path}_delete" title="Delete This Page" text="Delete" classname="deleteAction"/>
	</tk:menuPill>
	<tk:menuPill id="${param.path}_addPill">
		<tk:menuDropDown title="Add a Page Element" text="Add Page Element" id="${param.path}_addables">
			<tk:menuOption id="${param.path}.pageElement_addFieldset" title="Add Fieldset" text="Fieldset" classname="addable fieldset addNew"/>
			<tk:menuOption id="${param.path}.pageElement_addQuestionnaire" title="Add Questionnaire" text="Questionnaire" classname="addable questionnaire addNew"/>
			<tk:menuOption id="${param.path}.pageElement_addScript" title="Add Script" text="Script" classname="addable script addNew"/>
			<tk:menuOption id="${param.path}.pageElement_addServiceData" title="Add Service Data" text="Service Call Data" classname="addable fieldset addNew"/>
			<tk:menuOption id="${param.path}.pageElement_addTips" title="Add Tip" text="Tip" classname="addable tips addNew"/>
		</tk:menuDropDown>
	</tk:menuPill>	
	<tk:menuPill id="${param.path}_movePill">
		<tk:menuButton id="${param.path}_movePage" title="Move This Page" text="Move" classname="move_event"/>
	</tk:menuPill>	
</div>

