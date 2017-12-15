
<div class="modal fade" id="lb_confirm_convert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title" id="myModalLabel"><%=rb.getString("action.Convert.Confirm.QQWillBeConvertedConfirm")%></h2>
			</div>
      		<div class="modal-body">
        		<p><%= rb.getString("action.Convert.Confirm.QQWillBeConvertedTitle")%></p>
				<div class="button-row">
					<button type="button" class="btn btn-primary" onclick="page.confirmConversion=true;page.submit('ConvertToApplication');ap.pleaseWaitLB(true);"><%=rb.getString("action.Yes")%></button>
					<button type="button" class="btn btn-default" onclick="page.deselectCurrentSecondaryAction();" data-dismiss="modal"><%=rb.getString("action.No")%></button>
				</div>
      		</div>
      
		</div>
	</div>
</div>


<div class="modal fade" id="lb_confirm_convert_exit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

	<script type="text/javascript">
		function lb_convertHandleYes() {	
			$("#lb_confirm_convert_exit").modal("toggle");
			if(page.action == 'left_nav_menu')  {
				page.checkSaveStatus=false;
				page.navigatingToPage.executeClickEvents();
			}
			$('#lb_confirm_convert').modal();
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
					<input name="yesButton" type="button" class="btn btn-primary" value="<%=rb.getString("action.Yes")%>" accesskey="o" onclick="lb_convertHandleYes()" /> 
					<input name="noButton" type="button" class="btn btn-default" value="<%=rb.getString("action.No")%>" data-dismiss="modal"  />
				</div>
			</div>

		</div>
	</div>
</div>