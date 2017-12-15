<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.activitytracker.ActivityData"%>

<%
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.TIMELINE_BUNDLE);
%>

<jsp:useBean id="work_item_activity_contents" class="java.util.ArrayList" scope="request"/>

<c:if test="${empty ACTIVITY_ERROR}">
	<div>
		<c:forEach var="itemData" items="${work_item_activity_contents}">
			<%
   			 	ActivityData thisItem = (ActivityData) pageContext.getAttribute("itemData");
			%>
			<div class="work_item_activity_entry">
				<span class="workItemActivityText highlight">
					<c:if test="${itemData.workItemId > 0}">
						<a href='#' onclick="javascript:ap_activityTracker.open('${itemData.workItemId}')">
							<%= ResourceBundleStringUtils.makeSubstitutions(rb.getString("activity.tracker.workitem"), Integer.toString(thisItem.getWorkItemId()))%>						
						</a>
					</c:if>
				</span>
				<span class='workItemActivityText'>${itemData.displayString}</span>
			</div>			
		</c:forEach>
	</div>
</c:if>

