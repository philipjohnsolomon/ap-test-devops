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

<div id="merge-account" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" title="Close this window">&times;</button>
				<h2 class="modal-title"><%= rb.getString("account.actions.merge.account") %> </h2>
			</div>
			<div class="modal-body">
				<div id="merge-account_container" >
					<p id="instruction_tip"><%= rb.getString("account.actions.merge.account.searchAcctMoveTip1") %>
						<b>
							&ldquo;
							<%=JSPHelper.prepareForHTML(details.getAccountName())%>
							&ndash; <%= rb.getString("account.management.label.accountHashTag") %>  <%=details.getAccountNumber()%>
							&rdquo;
						</b>
					</p> 
					<div class="row">
						<div class="col-lg-12">
							<div class="input-group">
								<input type="text" class="form-control" placeholder=' <%= rb.getString("account.actions.merge.account.searchbox") %>' name="autocomplete_parameter" id="merge-account-search-input" >
								<span class="input-group-btn">
									<button class="btn btn-default search" type="button" id="merge-account-search-button" ><span><i class="fa"></i></span></button>
								</span>
							</div><!-- /input-group -->
						</div><!-- /.col-lg-8 -->
					</div><!-- /.row -->						

					<div class="row">
						<div class="col-lg-12" id="merge-account-search-results-listing"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="merge-account-confirm" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" title="Close this window">&times;</button>
				<h2 class="modal-title"><%= rb.getString("account.actions.merge.account") %></h2>
			</div>
			<div class="modal-body">
				<p id="merge-account-confirm-message">
					<%= rb.getString("account.actions.merge.account.confirm") %>
					<b>
						&ldquo;
							<%=JSPHelper.prepareForHTML(details.getAccountName()) %>
						&rdquo;
					</b>
				</p>
				<div class="button-row">
					<button type="button" class="btn btn-primary" data-dismiss="modal"><%= rb.getString("modal.confirmation.button.yes") %></button>
					<button type="button" class="btn btn-default" data-dismiss="modal"><%= rb.getString("modal.confirmation.button.no") %></button>
				</div>
			</div>
		</div>
	</div>
</div>


