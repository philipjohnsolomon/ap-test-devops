<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
	String csrfToken = JSPHelper.get(request).getCSRFToken();
%>

<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%@page import="com.agencyport.account.AccountDetails" %>
<%@page import="com.agencyport.utils.AppProperties"%>

<%
	IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
	String currencyFormat = AppProperties.getAppProperties().getStringProperty("application.premium.formatter", "currency : \"$\" : 0");
%>

<div id="{{workitemData.work_item_id}}" data-ng-dblclick="performDoubleClick()" data-ng-click="getWorkItemActions()" class="card workitem worklist-item {{workitemData.lob}} card-{{workitemData.status  | lowercase}}">

	<div class="percentage-color text-center"></div>
	<div class="card-header">
		<span class="{{after_title | lowercase}} noaction">{{workitemData.work_item_id}}: {{workitemData.lob}}
			<span class="badge">{{workitemData.complete_percent}}%</span>
			<div data-ng-show="isWorkItemSelected()">
				<span id="eventWorkItemAction_Delete" class="delete">
					<i class="fa"></i>
				</span>
			</div>
		</span>
	</div>
    <div class="card-content">
		<i class="fa"></i>					
		<h2>
			<span>{{workitemData.entity_name}}</span>
			<span data-ng-hide="isLinkedToAccount()" class="no-account" title="<%=accountRB.getString("account.actions.link.workitem.hover") %>"><i class="fa"></i></span>
		</h2>
		<ul>
			<li><%=workItemRB.getString("label.WorkList.EffectiveOn")%> {{workitemData.effective_date}}</li>
 			<li class="premium"><%=workItemRB.getString("label.WorkList.Premium")%> {{workitemData.premium | <%= currencyFormat %>}}</li>
			<li>{{lookupValue("TRANSACTION_TYPE",workitemData.transaction_type)}}</li>
			<li>{{lookupValue("STATUS",workitemData.status)}}</li>
			<li ng-show="isWorkItemSubmitted()" ><%= workItemRB.getString("label.WorkList.SubmissionId","Submission ID:")%> {{workitemData.external_id}}</li>
		</ul>
	</div>

	<div data-ng-show="isWorkItemSelected()" id="tile-actions" class="row card-actions">
		<div class="card-button">
			<span onmouseover="return true;" data-ng-click="actionClicked(action)" title="{{action.localizedTitle}}"
					data-ng-repeat="action in workitemData.actions | filter: {isPrimary: true}" 
					class="work_list_action action-button btn btn-default" id="eventWorkItemAction_{{action.code}}"> 
				<span>{{action.localizedTitle}}</span>
			</span>
			<div class="btn-group other-actions" dropdown is-open="actionsOpen" ng-if="(workitemData.actions | filter: {isPrimary: false}).length > 0">
				<button id="work_item_actions_secondary" class="btn btn-default dropdown-toggle" dropdown-toggle ng-disabled="disabled">
					<%=rb.getString("action.OtherActions") %><span class="caret"></span>
				</button>
				<ul class="dropdown-menu other-actions" role="menu">
					<li data-ng-repeat="action in workitemData.actions | filter: {isPrimary: false}" class="work_item_actions-{{action.code}}">
						<span onmouseover="return true;" data-ng-click="actionClicked(action)" title="{{action.localizedTitle}}" class="work_list_action" id="eventWorkItemAction_{{action.code}}"> 
							<span>{{action.localizedTitle}}</span>
						</span>
					</li>	
				</ul>
			</div>
		</div>
	</div>
</div>