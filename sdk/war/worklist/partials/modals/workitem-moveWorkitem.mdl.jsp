<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
	IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
%>

<div id="move-workitem-account-modal">
	<div class="modal-header">
		<button type="button" class="close" ng-click="close()" aria-hidden="true">&times;</button>
		<h2 class="modal-title"><%=accountRB.getString("account.actions.move.workitem") %></h2>
	</div>
	<div class="modal-body">
		<p><%= accountRB.getString("account.actions.move.workitem.tip") %></p>
		<div class="input-group">
			<input type="text" class="form-control" ng-model="searchVal" ng-change="lookupAccounts()" placeholder='<%= accountRB.getString("account.actions.move.workitem.searchbox") %>' >
			<span class="input-group-addon search"><i class="fa"></i></span>
		</div>
		<div id="move-account-search" class="move-account-container">
			<table class="table table-condensed table-striped prepend-top turnstile-account-search-listing accounts-search-modal-results" id="move-account-search-results-listing">
				<thead>
					<tr ng-show="displayResults"><th colspan="4">{{accounts.length}}&nbsp;<%= accountRB.getString("account.management.search.found")%></th></tr> 
				</thead>
				<tbody>
					<tr id="account_{{account.work_item_id}}" ng-repeat="account in accounts"> 
						<td class="account-type {{account.account_type}}"><i class="fa"></i></td>
						<td>{{account.entity_name}}</td>
						<td>{{account.work_item_id}}</td>
						<td><button type="button" ng-click="select(account)" class="btn btn-primary select-account pull-right"><%= accountRB.getString("account.management.label.select")%></button></td>
					</tr>
				</tbody>
			</table>				
		</div>
	</div>
</div>