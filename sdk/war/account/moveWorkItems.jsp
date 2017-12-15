<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<%@page import="com.agencyport.account.AccountDetails"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.account.IAccountConstants"%>
<%@page import="com.agencyport.jsp.JSPHelper,
				com.agencyport.product.ProductDefinitionsManager"%>

<%
	JSPHelper jspHelper = JSPHelper.get(request);
	String versionNumber = ProductDefinitionsManager.getCurrentlyRunningVersion().toString();
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
	AccountDetails details = (AccountDetails) request.getAttribute("accountDetails");

%>

<ap:ap_rb_loader rbname="account_management"/>

<div class="move_workitem_wrapper">

	<fieldset class="standardForm">
		<legend id="action_title">${ACCOUNT_MANAGEMENT_RB['account.actions.move.workitem']}</legend>
		<p id="instruction_tip">${ACCOUNT_MANAGEMENT_RB['account.actions.merge.account.searchAcctMoveTip']} 
			<b>
				<%=JSPHelper.prepareForHTML(details.getAccountName()) %>
			</b>
		</p> 
		<input type="hidden" id="accountAction" value="" />
		
		<div id="move_workitem_account_search_content" class="move_workitem_account_search">
			<div class="input-group move_workitem_content">
				<input type="text" class="form-control" placeholder="${ACCOUNT_MANAGEMENT_RB['account.actions.move.workitem.tip']}" id="move_workitem_search_input" name="autocomplete_parameter" />
				<span class="input-group-button">
					<input type="button" class="btn btn-default" id="account_action_search_btn" value="<%=rb.getString("account.management.menu.search", "Search") %>" onclick="javascript: ap.account.searchAccount('')" />
				</span>
				
				<span id="move_workitem_search_indicator" style="display: none">
					<img src="<%= jspHelper.getWebContentPrefix() %>assets/img/indicator.gif" alt="<%=rb.getString("account.management.working", "Working...") %>" />
				</span>		
				<div id="move_workitem_autocomplete_choices" class="autocomplete"></div>
			</div>
		</div>
		<div id="account_search_result_container" style="display:none;">
			<div id="account_search_help"><p id="tip" class="account_help_tip" /></div>
			<div id="account_search_results"></div>	
		</div>
		<div id="workitem_result_container" style="display:none;">
			<div id="workitem_search_help"><p id="tip"><%=rb.getString("account.actions.move.workitem.selectworkitem")%></p></div>
			<div id="account_workitem_results"></div>		
		</div>
	</fieldset>
	<div id="account_buttons">
		<input class="btn btn-default" name="moveButton" id="moveButton" type="button" value="${ACCOUNT_MANAGEMENT_RB['account.actions.move']}" accesskey="o"
			onclick="ap.account.sendMoveWorkItemRequest()" />
		<input class="btn btn-default" name="cancelButton" id="cancelButton" type="button" value="${CORE_RB['action.Cancel']}"
			onclick="ap.account.cancelMoveOrMerge()" />
	</div>
</div>