<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>

<div id="${param.path}_menu" style="" class="menu pageElement">
	<tk:menuPill id="${param.path}_deletePill">
		<tk:menuButton id="${param.path}_delete" title="Delete This Field" text="Delete" classname="deleteAction"/>
	</tk:menuPill>
	
	<tk:menuPill id="${param.path}_addPill">
		<tk:menuDropDown title="Add a Field Element" text="Add Field Element" id="${param.path}_addables">
			<tk:menuOption id="${param.path}.fieldElement_addText" title="Add Text" text="Text" classname="addable text addNew"/>
			<tk:menuOption id="${param.path}.fieldElement_addDate" title="Add Date" text="Date" classname="addable date addNew"/>
			<tk:menuOption id="${param.path}.fieldElement_addSelectlist" title="Add Selectlist" text="Selectlist" classname="addable selectlist addNew"/>
			<tk:menuOption id="${param.path}.fieldElement_addRadio" title="Add Radio" text="Radio" classname="addable radio addNew"/>
			<tk:menuOption id="${param.path}.fieldElement_addTextarea" title="Add Textarea" text="Textarea" classname="addable textarea addNew"/>
			<tk:menuOption id="${param.path}.fieldElement_addHidden" title="Add Hidden" text="Hidden" classname="addable hiddenFE addNew"/>
			<tk:menuOption id="${param.path}.fieldElement_addMessage" title="Add Message" text="Message" classname="addable message addNew"/>
			<tk:menuOption id="${param.path}.fieldElement_addFile" title="Add File" text="File" classname="addable file addNew"/>
			<tk:menuOption id="${param.path}.fieldElement_addFilterlist" title="Add Filterlist" text="Filterlist" classname="addable filterlist addNew"/>
			<tk:menuOption id="${param.path}.fieldElement_addCheckbox" title="Add Checkbox" text="Checkbox" classname="addNew"/>
		</tk:menuDropDown>
	</tk:menuPill>	
	<tk:menuPill id="${param.path}_movePill">
		<tk:menuButton id="${param.path}_movePageElement" title="Move This Page Element" text="Move" classname="move_event"/>
	</tk:menuPill>	
</div>