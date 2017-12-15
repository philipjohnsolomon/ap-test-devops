<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<ap:header heading="${RESOURCE_BUNDLE['timeline.event.rule.heading']}" type="rule"/>

<jsp:useBean id="rule_event_data" class="java.util.ArrayList" scope="request"/>

<div class="details">
	<table class="table">
		 <thead>
			<tr>
				<th>${RESOURCE_BUNDLE['timeline.event.rule.detail.page']}</th>
				<th>${RESOURCE_BUNDLE['timeline.event.rule.detail.message']}</th>
				<th>${RESOURCE_BUNDLE['timeline.event.rule.detail.severity']}</th>
			</tr>
		 </thead>
		<tbody>
			<c:forEach var="ruleData" items="${rule_event_data}" varStatus="rowCounter">
				<c:choose>
					<c:when test="${rowCounter.count % 2 == 0}">
						<c:set var="rowStyle" scope="page" value="evenRow"/>
					</c:when>
					<c:otherwise>
						<c:set var="rowStyle" scope="page" value="oddRow"/>
					</c:otherwise>
				</c:choose>
				<tr class="${rowStyle}">			
					<td>${ruleData.pageId}</td>
					<td>${ruleData.message}</td>
					<td>${ruleData.severity}</td>
				</tr>			
			</c:forEach>
		 </tbody>
	</table>
</div>

