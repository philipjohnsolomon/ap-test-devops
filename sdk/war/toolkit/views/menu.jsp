<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<tk:menuPill id="${param.path}_savePill">
	<tk:menuButton id="saveButton" title="Save" text="Save" classname="save primary"/>
	<tk:menuButton id="exportButton" title="Export as XML" text="Export" classname="export"/>
</tk:menuPill>

<jsp:include page="menu/views.jsp" />

