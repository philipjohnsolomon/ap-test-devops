<%@page import="com.agencyport.constants.TurnstileConstantsProvider"%>
<%@ page import="com.agencyport.trandef.Transaction"%>
<%@ page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.shared.locale.ISharedLocaleConstants"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
%>

<div class="modal" data-backdrop="static" data-keyboard="false" id="turnstile-lob-selector" 
	tabindex="-1" role="dialog" aria-labelledby="Turnstile LOB Selector" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title"><%= accountRB.getString("label.Transaction.UploadForms") %></h2>
			</div>
			<div class="modal-body">
				<div class="alert alert-danger" id="lob-validation-message" style="display: none;">
				</div>
				<p><%= accountRB.getString("label.Transaction.WhatLOB") %></p>
				<div class="row">
					<div class="col-xs-6">
						<div class="list-group" id="forms-list"></div>
						<div class="list-group" id="error-forms-list"></div>
						<div class="list-group" id="unknown-forms-list"></div>
					</div>
					<div class="col-xs-6">
						<div class="list-group" id="turnstile-transaction-list">
							<div class="list-group-item">
								<h4 class="list-group-item-heading"><%= accountRB.getString("header.Title.LOB") %></h4>
							</div>
							<%
								for (Transaction tx : jspHelper.getNewBusinessTransactions()) {
							%>
								<div class="list-group-item">
									<div class="checkbox">
										<label> <input type="checkbox" name="transactions"
											value="<%=tx.getLob()%>"> <%=tx.getTitle()%>
										</label>
									</div>
								</div>
							<%
								}
							%>

						</div>
					</div>
				</div>
				<div class="button-row">
					<button type="button" class="btn btn-primary continue"><%= accountRB.getString("action.Continue") %></button> 
					<button type="button" class="btn btn-default cancel" data-dismiss="modal"><%= accountRB.getString("action.Back")%></button>
					<input type="hidden" id="turnstile-stage-guid" value="" />
				</div>
			</div>
		</div>
	</div>
</div>
			
<div class="modal " id="turnstile-workitem-selector" tabindex="-1" role="dialog" aria-labelledby="Turnstile LOB Selector" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title"><%= accountRB.getString("label.Transaction.UploadForms") %></h2>
			</div>
			<div class="modal-body" id="turnstile-processed-workitems">
				<p id="turnstile-processed-message"> 
					<%= accountRB.getString("message.Transaction.CreatedItems") %>
				</p>
 				<table class="table table-striped">
					<thead>
						<tr>
							<th><%= accountRB.getString("label.Transaction.Number") %></th>
							<th><%= accountRB.getString("label.Transaction.LOB") %></th>
							<th></th>
						</tr>
					</thead>
					<tbody id="turnstile-processed-lob-listing">
			
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>			