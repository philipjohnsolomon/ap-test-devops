<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="fieldPath" value="${toolkitData.basePath}[${toolkitData.currentIndex}]"/>
<c:set var="pageDetails" value="${tdfData.pageDetails[toolkitData.currentIndex]}"/>
<tk:accordion fieldPath="${fieldPath}" action="${pageDetails.pageAction}" fieldValue="${pageDetails.pageTitle}" className="${tdfData.artifactType}">
</tk:accordion>