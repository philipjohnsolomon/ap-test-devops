<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
%>
<div class="{{workitemData.account_type}}">
	<div id="{{workitemData.account_id}}" data-ng-dblclick="performDoubleClick()" data-ng-click="getWorkItemActions()" class="card account worklist-item {{workitemData.account_type}}">
			<span class="lob-icon noaction">
				<i class="fa"></i>
			</span>
			<ul>
				<li class="other_name">{{workitemData.entity_name}}</li>
				<li class="type">{{lookupValue("ACCOUNT_TYPE",workitemData.account_type)}}</li>
				<li class="account-number">{{workitemData.account_number}}</li>
				<li class="address">{{workitemData.address}}</li>
			</ul>
			
		<div data-ng-show="isWorkItemSelected()" class="row card-actions" id="card-actions">
			<div class="worklist-card-button">
				<span onmouseover="return true;" data-ng-click="actionClicked(action)" 
					data-ng-repeat="action in workitemData.actions | filter: {isPrimary: true}"
					title="{{action.localizedTitle}}" class="worklist-actions action btn btn-default" id="eventWorkItemAction_{{action.code}}"> 
					<span>{{action.localizedTitle}}</span>
				</span>
			</div>
			
		</div>
	</div>	
</div>
