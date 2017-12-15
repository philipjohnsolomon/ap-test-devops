<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="creationHeader" value="timeline.event.workitem.creation.${TRANSACTION_TYPE}" />
<ap:header heading="${RESOURCE_BUNDLE[creationHeader]}" type="created"/>

<c:if test="${UPLOAD_SITUATION}">
	<ap:upload></ap:upload>
</c:if>


<c:if test="${INCLUDE_POLICY_DATA}">
	<ap:workItemData message=""/>
</c:if>