<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<jsp:useBean id="eventData" class="java.util.ArrayList" scope="request" />

<ul id="timeline_event_list">		
	<c:forEach var="data" items="${eventData}" varStatus="rowCounter">	
		<li id="timeline_event_${data.eventId}" class="">
			<a class="<c:if test="${rowCounter.last}">last</c:if>" id="timeline_event_${data.eventId}_link">
				<span class="timeline-title">
					<span class="timeline-counter">${rowCounter.count}</span> 
					${data.eventTitle}
				</span>
				<span class="timeline-timestamp">${data.timeStampString}</span>				
			</a>
		</li>	
	</c:forEach>
</ul>

	
