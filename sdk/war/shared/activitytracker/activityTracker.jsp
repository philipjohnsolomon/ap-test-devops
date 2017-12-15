<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.TIMELINE_BUNDLE);
	JSPHelper jspHelper = JSPHelper.get(request);
	int updateInterval = jspHelper.getActivityTrackerUpateInterval();
%>

<% if(updateInterval > 0) {%>

  	<script type="text/javascript" src="<%=jspHelper.getWebContentPrefix()%>javascript/ap_activity_tracker.js"></script>

	<fieldset id="recentActivity">
		<legend><%=rb.getString("activity.tracker.title")%></legend> 
		<div id="workItemActivities"></div>
	</fieldset>
	<script type="text/javascript">
		ap_activityTracker.start(<%= updateInterval %>);
	</script>		
<% } %>