<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
%>

<div id="saved_filter_delete_modal">
   	<div class="modal-header">
       	<button type="button" class="close" ng-click="no()" data-dismiss="modal" aria-hidden="true">&times;</button>
       	<h2  class="modal-title"><%= workItemRB.getString("title.filter.delete") %></h2>
     </div>
	<div class="modal-body">
		<p><%= workItemRB.getString("action.filter.delete") %></p>
		<div class="button-row">
      		<button type="button" class="btn btn-primary" ng-click="yes()"><%= workItemRB.getString("modal.confirmation.button.yes") %></button>
			<button type="button" class="btn btn-default" ng-click="no()" data-dismiss="modal"><%= workItemRB.getString("modal.confirmation.button.no") %></button>
		</div>
	</div>
</div>
