<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>

<div id="${param.path }_menu" style="" class="menu">
	<tk:menuPill id="${param.path}_variablePill">
		<tk:menuButton id="${param.path}_${param.action}" title="New Entry" text="${param.label}" classname="addable addNew"/>
	</tk:menuPill>
</div>	