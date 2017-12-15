<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="moveData" class="com.agencyport.toolkit.data.search.MoveDialogListData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<select id="pageElementOptions">
	<c:out value="${moveData.pageElementResults}" escapeXml="false"/>
</select>
<select id="fieldElementOptions">
	<c:out value="${moveData.fieldElementResults}" escapeXml="false"/>
</select>