<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
  
<div id="${param.path}_action_menu" style="" class="menu">
	<tk:menuPill id="${param.path}_actionPill">
		<tk:menuDropDown title="Add items to this Rule" text="Add" id="${param.path}_action_addables">
			<tk:menuOption id="${param.path}.step.select_addMsgVariable" title="Add Message Variable" text="Message Variable" classname="addable addMsgVariable"/>
			<tk:menuOption id="${param.path}_addMessage" title="Add Message" text="Message" classname="addable addMessage"/>
		</tk:menuDropDown>		
	</tk:menuPill>
</div>	
