<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<ap:header heading="${RESOURCE_BUNDLE['timeline.event.status.heading']}" type="status_change"/>

<div class="details">
	<table class="table status_change">
		 <thead>
			<tr>
				<th>${RESOURCE_BUNDLE['timeline.event.status.previous.status']}</th>
				<th></th>
				<th>${RESOURCE_BUNDLE['timeline.event.status.new.status']}</th>
			</tr>
		 </thead>
		<tbody>
			<tr>
				<td>${PREVIOUS_STATUS}</td>
				<td><div class="status_change_icon"></div></td>
				<td>${CURRENT_STATUS}</td>
			</tr>			
		 </tbody>
	</table>
</div>

<ap:changeSummary message="${RESOURCE_BUNDLE['timeline.event.status.change.heading']}"/>
<ap:workItemData message="${RESOURCE_BUNDLE['timeline.event.status.summary.heading']}"/>
