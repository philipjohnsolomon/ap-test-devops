<!-- Modal -->		
<div class="modal fade" id="lb_upload_info" tabindex="-1" role="dialog" aria-labelledby="lb_upload_info" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title" id="myModalLabel"><%=uploadrb.getString("header.Info.AboutThisUpload")%></h2>
			</div>
			<div class="modal-body">
				<table class="table table-striped">
					<tbody>
						<tr>
							<td><%=uploadrb.getString("label.Info.System")%></td>
							<td><%=JSPHelper.prepareForHTML(uploadSourceSystem)%></td>
						</tr>
						<tr>
							<td><%=uploadrb.getString("label.Info.Version")%></td>
							<td><%=JSPHelper.prepareForHTML(uploadSourceVersion)%></td>
						</tr>
						<tr>
							<td><%=uploadrb.getString("label.Info.Vendor")%></td>
							<td><%=JSPHelper.prepareForHTML(uploadSourceOrg)%></td>
						</tr>			
					</tbody>
				</table>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->