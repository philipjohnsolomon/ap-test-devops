<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.account.model.IAccount.AccountType"%>
<% 

 String csrfToken = JSPHelper.get(request).getCSRFToken();

 IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
%>

<div class="col-xs-12 col-sm-6 col-md-4 add-new-work-item" id="add_new_workitem">
	<div class="card add" id="add-button" ng-show="addNewState == 'none'">
		<div ng-click="setState('show-transactionList')" class="add-button">
			<i class="fa"></i>
			<a><%= accountRB.getString("action.AddNewAccount") %></a>
		</div>
	</div>	
	<div class="card add" id="add-list" ng-show="addNewState == 'show-transactionList'">
		<div class="add-account">
			<a ng-href="" ng-click="createWorkItem({href:addlinks[0].value + '&account_type=<%=AccountType.C.name()%>'})" class="add-commercial"><i class="fa"></i><span class="link"><%= accountRB.getString("label.Account.Commercial") %></span></a>
			<a ng-href="" ng-click="createWorkItem({href:addlinks[0].value + '&account_type=<%=AccountType.P.name()%>' })" class="add-personal"><i class="fa"></i><span class="link"><%= accountRB.getString("label.Account.Personal") %></span></a>
		</div>
	</div>
</div>	