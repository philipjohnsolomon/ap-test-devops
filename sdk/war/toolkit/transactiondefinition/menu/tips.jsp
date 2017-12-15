<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>

<div id="${param.path}_menu" style="" class="menu">
	
	<tk:menuPill id="${param.path}_deletePill">
		<tk:menuButton id="${param.path}_delete" title="Delete This Field" text="Delete" classname="deleteAction"/>
	</tk:menuPill>
	
	<tk:menuPill id="${param.path}_addPill">
		<tk:menuButton id="${param.path}.fieldElement_addMessage" title="Add Message" text="Add Message" classname="addable message addNew"/>
	</tk:menuPill>	
	
</div>