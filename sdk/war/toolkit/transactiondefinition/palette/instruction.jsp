<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<c:set var="path" value="${toolkitData.basePath}"/>
<c:set var="typePath" value="${path}.@type"/>
<c:set var="type" value="${tk:getFieldValue(toolkitdata, typePath, param.type)}"/>
<c:set var="jspPage" value="connectors/${type}.jsp"/>

<jsp:include page="${jspPage}" />
