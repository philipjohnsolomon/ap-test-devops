<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<div id="${param.artifactId}_menu" style="" class="menu">

	<tk:menuPill id="${param.path}_deletePill">
		<tk:menuButton id="${param.artifactId}_delete" title="Delete This Transaction" text="Delete" classname="deleteArtifact"/>
	</tk:menuPill>
	
	<tk:menuPill id="${param.path}_addPill">
		<tk:menuDropDown title="Add a Page" text="Add Page" id="${param.path}_addables">
			<tk:menuOption id="page_addDataEntry" title="Add Data Entry" text="Data Entry" classname="addable dataEntry addNew"/>
			<tk:menuOption id="page_addRosterPage" title="Add Roster" text="Roster" classname="addable rosterPage addNew"/>
			<tk:menuOption id="page_addImport" title="Add Import" text="Import" classname="addable importPage addNew"/>
			<tk:menuOption id="page_addCustomPage" title="Add Custom Page" text="Custom Page" classname="addable page addNew"/>
		</tk:menuDropDown>
	</tk:menuPill>		

</div>