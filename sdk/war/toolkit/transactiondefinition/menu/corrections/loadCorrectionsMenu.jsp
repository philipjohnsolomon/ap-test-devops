<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="correctionsPath" value="${path}.correction"/>
			
<tkmenu:menuDropDown title="Add Correction" text="Add Correction" id="${path}_addCorrectonActions">
	<tkmenu:menuOption id="${correctionsPath}_addCorrection-useSubstitute" title="Add Use Substitute" text="Use Substitute" classname="addNew"/>
	<tkmenu:menuOption id="${correctionsPath}_addCorrection-findClosest" title="Add Find Closest" text="Find Closest" classname="addNew"/>
	<tkmenu:menuOption id="${correctionsPath}_addCorrection-bestMatch" title="Add Best Match" text="Best Match" classname="addNew"/>
	<tkmenu:menuOption id="${correctionsPath}_addCorrection-delete" title="Add Delete" text="Delete" classname="addNew"/>
	<tkmenu:menuOption id="${correctionsPath}_addCorrection-custom" title="Add Custom" text="Custom" classname="addNew"/>
</tkmenu:menuDropDown>