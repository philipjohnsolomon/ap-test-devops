<%@ page import="com.agencyport.constants.TurnstileConstantsProvider"%>
<%@ page import="com.agencyport.account.AccountManagementFeature" %>
<%@ page import="com.agencyport.trandef.Transaction"%>
<%@ page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>

<%
	IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);

	JSPHelper jspHelper = JSPHelper.get(request);
	if(TurnstileConstantsProvider.isTurnstileEnabled()){
		%>
		<div class="modal fade" data-backdrop="static" data-keyboard="false" id="turnstile-upload-widget" 
				tabindex="-1" role="dialog" aria-labelledby="Turnstile Files Selector" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true" title="Close this window">&times;</button>
						<h2 class="modal-title"><%= coreRB.getString("header.Title.UploadForms") %></h2>
					</div>
					<div class="modal-body">
						<ul class="nav nav-tabs" id="upload-tabs">
							<li class="active"><a href="#turnstile-files-selector" data-toggle="tab"><%= coreRB.getString("label.ListItem.New") %></a></li>
							<li><a href="#turnstile-file-upload-status" data-toggle="tab"><%= coreRB.getString("label.ListItem.InProgress") %></a></li>
						</ul>
						<div class="tab-content" >
							<div class="turnstile-files-selector tab-pane fade in active" id="turnstile-files-selector">
								<p><%= coreRB.getString("message.Turnstile.FileType") %></p>
								<%@include file="turnstile/files_selector.jsp" %>
							</div>
							<div class="tab-pane fade turnstile-file-upload-status" id="turnstile-file-upload-status">
								<table class="table table-striped">
									<thead>
										<tr>
											<th><%= coreRB.getString("label.FileDetails.File") %></th>
											<th><%= coreRB.getString("label.FileDetails.DateTime") %></th>
											<th><%= coreRB.getString("label.FileDetails.Status") %></th>
											<th><%= coreRB.getString("label.FileDetails.Actions") %></th>
										</tr>
									</thead>
									<tbody id="turnstile-report-table">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@include file="turnstile/transaction_selector.jsp" %>
		<%@include file="turnstile/account_selector.jsp" %>
		<%@include file="turnstile/turnstile_error.jsp" %>
		<%
	}
%>

<script type="text/javascript">
	var ap = ap || {};
	ap.environment = ap.environment || {}; // Global environment variable store.
	
	ap.environment.isAccountManagementFeatureOn = <%= AccountManagementFeature.get().isOn() %>; 
	ap.environment.isTurnstileEnabled = <%= TurnstileConstantsProvider.isTurnstileEnabled() %>; 
	
</script>
 