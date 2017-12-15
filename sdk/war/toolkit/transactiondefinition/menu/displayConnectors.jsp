<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>

<div id="${param.path}_menu" style="" class="menu">	
	<tk:menuPill id="${param.path}_addPill">
		<tk:menuDropDown title="Add a Connector" text="Add Connector" id="${param.path}_addConnector">
			<tk:menuOption id="${param.path}.connector_addXARC" title="Add xARC Connector" text="xARC" classname="addable connector addNew"/>
			<tk:menuOption id="${param.path}.connector_addCustomConnector" title="Add Custom Connector" text="Custom" classname="addable connector addNew"/>
		</tk:menuDropDown>
	</tk:menuPill>
	<tk:menuPill id="${param.path}_addPill">
		<tk:menuDropDown title="Add an Instruction" text="Add Instruction" id="${param.path}_addInstruction">
			<tk:menuOption id="${param.path}.instruction_addStatusChange" title="Add Change Status Instruction" text="Change Status" classname="addable instruction addNew"/>
			<tk:menuOption id="${param.path}.instruction_addAssign" title="Add Assign Instruction" text="Assign" classname="addable instruction addNew"/>
			<tk:menuOption id="${param.path}.instruction_addUpdateAPData" title="Add Instruction to Commit APData Changes" text="Commit Data" classname="addable instruction addNew"/>
			<tk:menuOption id="${param.path}.instruction_addGenerateMessage" title="Add Generate Message Instruction" text="Generate Message" classname="addable instruction addNew"/>
			<tk:menuOption id="${param.path}.instruction_addCustomInstruction" title="Add Custom Instruction" text="Custom" classname="addable instruction addNew"/>
			<tk:menuOption id="${param.path}.instruction_addUpdateServiceData" title="Add Service data Instruction" text="Service Data" classname="addable instruction addNew"/>
		</tk:menuDropDown>
	</tk:menuPill>		
</div>