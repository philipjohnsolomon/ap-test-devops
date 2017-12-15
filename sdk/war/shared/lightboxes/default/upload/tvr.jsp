<div class="modal fade" id="lb_upload_tvr" tabindex="-1" role="dialog" aria-labelledby="lb_upload_tvr" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title"><%=ResourceBundleStringUtils.makeSubstitutions(uploadrb.getString("header.Tvr.SubmissionHadIssues"), uploadSourceSystem)%></h2>
			</div>
			<div class="modal-body">
				<p><%=uploadrb.getString("title.Tvr.SubmissionHadIssues")%></p>
				<table class="table">
					<thead>
						<tr>
							<th><%=uploadrb.getString("header.Tvr.Page")%></th>
							<th><%=uploadrb.getString("header.Tvr.Field")%></th>
							<th><%=uploadrb.getString("header.Tvr.Error")%></th>
						</tr>
					</thead>
					<tbody> 
						<%
						for (int ix = 0; ix < validationResults.length; ix++) {
						DataContainer dataContainer = validationResults[ix].getDataContainerWithIssue();
						%>
						<tr>
						<%
						if (validationResults[ix].appliesToFieldElement()) {
						%>
							<td><%=JSPHelper.prepareForHTML(dataContainer.getPage().getTitle())%></td>
							<td><%=JSPHelper.prepareForHTML(validationResults[ix].getRelatedFieldElement().getLabel())%></td>
						<%
						}
						else {
						%>
							<td colspan="2"><%=JSPHelper.prepareForHTML(dataContainer.getPage().getTitle())%></td>
						<%
						}
						%>
							<td><%=JSPHelper.prepareForHTML(validationResults[ix].getValidationMessageText())%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
        
				<div class="button-row">
					<button type="button" class="btn btn-default" data-dismiss="modal"  data-toggle="modal" data-target="#lb_upload_welcome" ><%=rb.getString("action.Ok")%></button> 
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->