<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.agencyport.webshared.IWebsharedConstants" %>
<%@ page import="com.agencyport.locale.IResourceBundle" %>
<%@ page import="com.agencyport.locale.ResourceBundleManager" %>
<%@ page import="com.agencyport.locale.ILocaleConstants" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<%
	
	IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
	IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
		
%>
<ap:ap_rb_loader rbname="worklist" />
<ap:ap_rb_loader rbname="account_management"/>

<div class="modal" data-backdrop="static" data-keyboard="false" id="move-workitem-account-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title"><%=accountRB.getString("account.actions.link.workitem") %></h2>
			</div>
			<div class="modal-body">
				<p><%= coreRB.getString("prompt.AccountSelector.WhatAccount") %></p> 			
				<div class="form-group">
					<button type="button" class="btn btn-primary new-account" data-dismiss="modal"><span class="pull-left">New Account</span></button>
					<button type="button" class="btn btn-primary account-search-button"  data-toggle="button" autocomplete="off"><span  class="pull-left">Search for an Account</span> </button>
				</div>
				
				<div id="move-account-search" class="move-account-container accounts-search-modal-results hidden">
					<h4><%= coreRB.getString("header.Title.SearchForAccount") %></h4>
					<div class="row">
						<div class="col-lg-12">
							<div class="input-group">
								<input type="text" class="form-control" placeholder='<%= accountRB.getString("account.actions.move.workitem.searchbox") %>' name="autocomplete_parameter" id="move-account-search-input" >
								<span class="input-group-btn">
									<button class="btn btn-default" type="button" id="move-account-search-button" ><span><i class="fa fa-search"></i></span></button>
								</span>
							</div><!-- /input-group -->
						</div><!-- /.col-lg-8 -->
					</div><!-- /.row -->						

					<div class="row">
						<div class="col-lg-12 " id="move-account-search-results-listing"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade in" id="workitem_move_modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content">
    		<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" title="Close this window">&times;</button>
				<h2 class="modal-title"> <%=accountRB.getString("account.actions.move.workitem") %></h2>
			</div>
			<div class="modal-body">
				<div id="move-account_container" class="move-account-container">
 					<p><%= accountRB.getString("account.actions.move.workitem.tip") %></p>
					
					<div class="row">
					  <div class="col-lg-12">
					    <div class="input-group">
					      <input type="text" class="form-control" placeholder="<%= accountRB.getString("account.actions.move.workitem.searchbox") %>" name="autocomplete_parameter" id="move-workitem-search-input" >
					      <span class="input-group-btn">
					        <button class="btn btn-default search" type="button" id="move-workitem-search-button" ><span><i class="fa"></i></span></button>
					      </span>
					    </div><!-- /input-group -->
					  </div><!-- /.col-lg-8 -->
					</div><!-- /.row -->						
					
					<div class="row">
						<div class="col-lg-12 " id="move-workitem-search-results-listing"></div>
					</div>

				</div>					
			</div>
    	</div>
  	</div>
</div>

<div id="move-account-confirm" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" title="Close this window">&times;</button>
				<h2 class="modal-title"> <%= accountRB.getString("account.actions.move.workitem") %> </h2>
			</div>
			<div class="modal-body">
				<p id="move-account-confirm-message">
					 <%= accountRB.getString("account.actions.move.workitem.confirm") %>
				</p>
				<div class="button-row">
					<button type="button" class="btn btn-primary" data-dismiss="modal"><%= accountRB.getString("modal.confirmation.button.yes") %>  </button>
					<button type="button" class="btn btn-default" data-dismiss="modal"><%= workItemRB.getString("modal.confirmation.button.no") %>  </button>
				</div>
			</div>
			
		</div>
	</div>
</div>

<div id="move-account-success" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" title="Close this window">&times;</button>
				<h2 class="modal-title"> <%= accountRB.getString("account.actions.link.workitem") %> </h2>
			</div>
			<div class="modal-body">
				<p id="move-account-success-message">
					 <%= accountRB.getString("account.actions.move.workitem.success") %>
				</p>
			</div>
			
		</div>
	</div>
</div>

<div id="link-account-success" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" title="Close this window">&times;</button>
				<h2 class="modal-title"> <%= accountRB.getString("account.actions.link.workitem") %> </h2>
			</div>
			<div class="modal-body">
				<p id="move-account-success-message1">
					 <%= accountRB.getString("account.actions.link.workitem.success1") %>
				</p>
			</div>
			
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/javascript/worklist/move-workitem-search-filter.js"></script>