<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
%>

<div id="workitem_approve_modal">
   	<div class="modal-header">
       	<button type="button" class="close" ng-click="no()" data-dismiss="modal" aria-hidden="true">&times;</button>
       	<h2 class="modal-title"><%= workItemRB.getString("header.Title.approveThisWorkItem") %></h2>
     </div>
	<div class="modal-body">
		<p><%= workItemRB.getString("message.WorkList.approve") %></p>
		<div class="button-row">
			<button type="button" class="btn btn-primary" ng-click="yes()"><%= workItemRB.getString("action.WorkItem.canApprove") %></button>
		</div>
	</div>
</div>