<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<div id="${param.path}_menu" style="" class="menu">
	<tk:menuPill id="${param.path}_dynamicListPill">
		<tk:menuButton id="${param.path}_delete" title="Delete This Dynamic List" text="Delete List" classname="left deleteAction"/>
	</tk:menuPill>
	<tk:menuPill id="${param.path}_dynamicListFieldPill">
		<tk:menuButton id="${param.path}.field_addListField" text="Add Field" title="New Field" classname="right addable addNew"/>
	</tk:menuPill>
</div>