<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal" %>
<tk:menuPill id="${param.path}_savePill">
	<tk:menuButton id="saveButton" title="Save" text="Save" classname="left save primary"/>
	<tk:menuButton id="exportButton" title="Export as XML" text="Export" classname="rigth export"/>
</tk:menuPill>

<jsp:include page="menu/dynamicListEditor.jsp" />