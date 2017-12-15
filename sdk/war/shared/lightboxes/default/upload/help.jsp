<!-- Modal -->
<div class="modal fade upload-help" id="lb_upload_help" tabindex="-1" role="dialog" aria-labelledby="lb_upload_help" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title" id="myModalLabel"><%=uploadrb.getString("header.Help.Help")%></h2>
			</div>
			<div class="modal-body">
			
					
				<% if ( isQuickQuote ) { %>
					<p><%=uploadrb.getString("helpText.Help.SubmissionIsQQ")%></p>
				<% } %>
		
				<h3><%=uploadrb.getString("helpText.Help.AsYouAreWorking")%></h3>
		
				<% if (supportsPreValidation) { %>
					<p><span class="problem-field"><%=uploadrb.getString("helpText.Help.EmphasizedLabels.1")%></span> <%=uploadrb.getString("helpText.Help.EmphasizedLabels.2")%></p>
				<% } %>
				
				<div class="legend">
					<p class="not-available"><i class="fa fa-2"></i>&nbsp;<%=uploadrb.getString("helpText.Help.IconUploadNotAvailable.1")%></p>
					<p><%=uploadrb.getString("helpText.Help.IconUploadNotAvailable.2")%></p>
					<p><%=uploadrb.getString("helpText.Help.IconUploadNotAvailable.3")%></p>
					
					<p class="system-auto-correct"><i class="fa fa-2"></i> <%=ResourceBundleStringUtils.makeSubstitutions(uploadrb.getString("helpText.Help.SystemAutoCorrected.1"), uploadSourceSystem)%></p>	
					<p class="change"><i class="fa fa-2"></i> <%=uploadrb.getString("helpText.Help.IconRestoreAvailable.2")%></p>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal upload-help --> 