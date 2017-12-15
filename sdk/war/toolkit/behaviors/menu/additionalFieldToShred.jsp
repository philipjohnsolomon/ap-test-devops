<%@ taglib prefix="tkmenu" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"></jsp:useBean>
<c:set var="path" value="${toolkitData.basePath}" />

<div id="${path}_menu" style="" class="menu">
	<tkmenu:menuPill id="${toolkitData.basePath}_additionalFieldToShredPill">
		<tkmenu:menuButton id="${path}_delete" title="Delete This Additional Field" text="Delete" classname="deleteAction"/>
	</tkmenu:menuPill> 
</div>