<!--  ACTIVE USERS -->
<%@page import="com.agencyport.utils.AppProperties"%>
<%
	boolean supportsCollapse = AppProperties.getAppProperties().getTrueFalseBooleanProperty("workitemassistant.supportsCollapse", true);
%>

<div class="panel panel-default wia-users">
	<% if (supportsCollapse) { %>
	<div class="panel-heading collapsed" data-toggle="collapse" href="#workItemAssistant_activeUsers_section" aria-expanded="true" aria-controls="workItemAssistant_activeUsers_section" style="cursor:pointer">
	<% } else { %>
		<div class="panel-heading">
	<% } %>
		<h4 class="panel-title">
			<span class="has-users"><i class="fa"></i></span>
			{{activeusers.label}}
		</h4>
	</div>
	<div class="panel-body wia-comments <% if (supportsCollapse) { %>collapse<% } %>" id="workItemAssistant_activeUsers_section">
		<div id="workItemAssistant_activeUsers_container" class="wia-container panel-fixed-height">
			<dl>
				<dd id="workItemAssistant_activeUsers" ng-repeat="entry in activeusers.entries">
					{{entry.userName}}
				</dd>
			</dl>
		</div>
	</div>
</div>