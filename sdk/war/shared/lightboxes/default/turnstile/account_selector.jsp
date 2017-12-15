<%@page import="com.agencyport.constants.TurnstileConstantsProvider"%>
<%@ page import="com.agencyport.trandef.Transaction"%>
<%@ page import="com.agencyport.jsp.JSPHelper"%>

<div class="modal" data-backdrop="static" data-keyboard="false" id="turnstile-account-selector" 
	tabindex="-1" role="dialog" aria-labelledby="Turnstile LOB Selector" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title"><%= coreRB.getString("header.Title.UploadForms") %></h2>
			</div>
			<div class="modal-body">
				<p><%= coreRB.getString("prompt.AccountSelector.WhatAccount") %></p> 			
				<div class="form-group">
					<button type="button" class="btn btn-primary no-account"  onclick="javascript:ap.turnstileWidget.continueWithoutAccount();"><span class="pull-left"><%=accountRB.getString("message.Turnstile.button.noAccount") %></span></button>
					<button type="button" class="btn btn-primary new-account"  onclick="javascript:ap.turnstileWidget.createWorkItemsAndAccount();" data-dismiss="modal"><span class="pull-left"><%=accountRB.getString("message.Turnstile.button.newAccount") %></span></button>
					<button type="button" class="btn btn-primary account-search-button"  data-toggle="button" autocomplete="off"><span  class="pull-left"><%=accountRB.getString("message.Turnstile.button.searchForAnAccount") %></span> </button>
				</div>
				
				<div id="turnstile-account-search" class="turnstile-account-search accounts-search-modal-results hidden">
					<h4><%= coreRB.getString("header.Title.SearchForAccount") %></h4>
					<div class="row">
						<div class="col-lg-12">
							<div class="input-group">
								<input type="text" class="form-control" placeholder='<%=accountRB.getString("account.management.label.findAccount") %>' name="autocomplete_parameter" id="turnstile-account-search-input" >
								<span class="input-group-btn">
									<button class="btn btn-default" type="button" id="turnstile-account-search-button" ><span><i class="fa fa-search"></i></span></button>
								</span>
							</div><!-- /input-group -->
						</div><!-- /.col-lg-8 -->
					</div><!-- /.row -->						

					<div class="row">
						<div class="col-lg-12 " id="turnstile-account-search-results-listing"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>