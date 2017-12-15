<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
%>

<div class="modal-header">
	<button type="button" class="close" ng-click="no()" aria-hidden="true" title="Close this window">&times;</button>
	<h2 class="modal-title"> <%= accountRB.getString("account.actions.link.workitem") %> </h2>
</div>
<div class="modal-body">
	<p ng-bind="successMessage">
	</p>
</div>
