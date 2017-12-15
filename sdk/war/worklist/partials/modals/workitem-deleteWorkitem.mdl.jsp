<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
%>

<div id="workitem_delete_modal">
   	<div class="modal-header">
       	<button type="button" class="close" ng-click="no()" data-dismiss="modal" aria-hidden="true">&times;</button>
       	<h2 ng-if="details.isAccount == false" class="modal-title"><%= workItemRB.getString("header.Title.DeleteThisWorkItem") %></h2>
       	<h2 ng-if="details.isAccount == true" class="modal-title"><%= accountRB.getString("header.Title.ConfirmAccountDeletion") %></h2>
     	</div>
	<div class="modal-body">
		<p ng-if="details.isAccount == false"><%= workItemRB.getString("action.WorkItem.canConfirm") %></p>
		<p ng-if="details.isAccount == true"><%= accountRB.getString("account.actions.delete.warn") %></p>
		<div class="button-row">
      		<button type="button" class="btn btn-primary" ng-click="yes()"><%= workItemRB.getString("modal.confirmation.button.yes") %></button>
			<button type="button" class="btn btn-default" ng-click="no()" data-dismiss="modal"><%= workItemRB.getString("modal.confirmation.button.no") %>  </button>
		</div>
	</div>
</div>
