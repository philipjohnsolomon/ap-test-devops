<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="fieldPath" value="${param.basePath}"/>
<tk:accordion fieldPath="${fieldPath}" action="loadEntry" className="${param.className}" fieldValue="${param.title}">
</tk:accordion>
