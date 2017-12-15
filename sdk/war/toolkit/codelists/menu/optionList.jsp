<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<div id="${param.path}_menu" style="" class="menu">
	<tk:menuPill id="${param.artifactId}_codeListPill">
		<tk:menuButton id="${param.artifactId}_addOptionList" text="Add Option List" title="New Option List" classname="solo addable addNew"/>
	</tk:menuPill>
	<tk:menuPill id="${param.path}_optionListPill">
		<tk:menuButton id="${param.path}_delete" title="Delete This Option List" text="Delete Option List" classname="left deleteAction"/>
		<tk:menuButton id="${param.path}.option_addOption" text="Add Option" title="New Option" classname="right addable addOption addNew"/>
	</tk:menuPill>
</div>