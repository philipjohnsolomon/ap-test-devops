<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<c:set var="viewType" value="${tk:getViewType(toolkitData, param.path, '')}"/>

<div id="${param.path}_menu" style="" class="menu">

	<c:if test="${(viewType !='mutuallyExclusiveFieldSets') || (FIELDSET_INDEX > 1)}">
		<tkmenu:menuPill id="${param.path}_deletePill">
			<tkmenu:menuButton id="${param.path}_delete" title="Delete This Fieldset" text="Delete" classname="deleteFieldSet"/>
		</tkmenu:menuPill>
	</c:if>
	
	<tkmenu:menuPill id="${param.path}_addPill">
		<tkmenu:menuButton id="${param.path}.field_addField" title="Add a Field" text="Add a Field" classname="addable addNew"/>
		<c:if test="${(viewType !='display')}">	
			<tkmenu:menuButton id="${param.path}.deleteField_addDeleteField" title="Add a Delete Field" text="Add a Delete Field" classname="addable addNew "/>
		</c:if>
	</tkmenu:menuPill>
	
</div>
