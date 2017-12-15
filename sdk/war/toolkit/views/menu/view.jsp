<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<c:set var="viewType" value="${tk:getViewType(toolkitData, param.path, '')}"/>

<div id="${param.path}_menu" style="" class="menu">
	<tkmenu:menuPill id="${param.path}_deletePill">
		<tkmenu:menuButton id="${param.path}_delete" title="Delete This View" text="Delete" classname="deleteAction"/>
	</tkmenu:menuPill>
	
	<c:if test="${viewType=='mutuallyExclusiveFieldSets'}">
		<tkmenu:menuPill id="${param.path}_addPill">
			<tkmenu:menuButton id="${param.path}.fieldSet_addFieldSet" title="Add an Instruction set" text="Add an Instruction set" classname="addable addNew Fieldset"/>
		</tkmenu:menuPill> 
	</c:if>
</div>