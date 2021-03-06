<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="tdfData" class="com.agencyport.toolkit.data.tdf.TDFData" scope="request"/>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="legendPath" value="${toolkitData.basePath}.@legend"/>
<c:set var="legendValue" value="${tk:getFieldValue(toolkitData, legendPath, 'New Service Data')}"/>
<tk:accordion fieldPath="${toolkitData.basePath}" action="loadEntry" fieldValue="${legendValue}" className="fieldSet">
</tk:accordion>