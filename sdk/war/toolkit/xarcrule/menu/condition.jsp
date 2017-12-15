<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<div id="${param.path}_menu" style="" class="menu">
	<tk:menuPill id="${param.path}_conditionPill">
		<tk:menuDropDown id="${param.path}_addCondition_button" title="Add" text="Add" classname="addable condition">
			<tk:menuOption id="${param.path}_addCondition" title="condition" text="condition" classname="addNew"/>
			<tk:menuOption id="${param.path}_addCustom" title="custom" text="custom" classname="addNew"/>
		</tk:menuDropDown>
	</tk:menuPill>
</div>	