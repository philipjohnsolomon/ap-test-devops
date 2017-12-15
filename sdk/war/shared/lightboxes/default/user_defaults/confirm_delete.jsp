 <!-- Modal -->
<div class="modal fade" id="lb_confirm_default_delete" tabindex="-1" role="dialog"  aria-labelledby="deletemodal" aria-hidden="true">

	<div class="modal-dialog">
		<div class="modal-content">
		
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h2 class="modal-title" id="myModalLabel"><%=defaultsrb.getString("message.ConfirmDelete.AreYouSure")%></h2>
	      </div>		
		
			<div class="modal-body">
				<p><%=defaultsrb.getString("message.ConfirmDelete.Id.1")%>
					<span id="lb_confirm_delete_default_title" style="font-weight: bold"></span><%=defaultsrb.getString("message.ConfirmDelete.Id.2")%>
				</p>
				<div class="button-row">
					<input name="defaultsOkButton" type="button" value="<%=rb.getString("action.Yes")%>" onclick="$('#lb_manage_default_form').submit();ap.pleaseWaitLB(true);" data-dismiss="modal" class="btn btn-primary" /> 
					<input name="defaultsCancelButton" type="button" value="<%=rb.getString("action.No")%>" data-dismiss="modal"  class="btn btn-default"  />
				</div>
			</div>

		</div>
	</div>
</div>

<div class="modal fade" id="lb_confirm_default_save" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

	<script type="text/javascript">
		function lb_saveDefaultHandleYes() {	
			$("#lb_confirm_default_save").modal("toggle");
			if(page.action == 'left_nav_menu')  {
				page.checkSaveStatus=false;
				page.navigatingToPage.executeClickEvents();
			}
			$('#lb_save_to_default').modal();
		}
	</script>

	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title" id="myModalLabel"><%=rb.getString("action.Confirm.ExitQuestion")%></h2>
			</div>
			<div class="modal-body">
				<p><%= rb.getString("action.Confirm.ExitTitle") %></p>
				<div class="button-row">
					<input name="yesButton" type="button" class="btn btn-primary" value="<%=rb.getString("action.Yes")%>" accesskey="o" onclick="lb_saveDefaultHandleYes()" /> 
					<input name="noButton" type="button" class="btn btn-default" value="<%=rb.getString("action.No")%>" data-dismiss="modal"  />
				</div>
			</div>

		</div>
	</div>
</div>