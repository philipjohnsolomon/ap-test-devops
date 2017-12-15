<!-- Modal -->
<div class="modal fade" id="lb_save_to_default" tabindex="-1" role="dialog"
	aria-labelledby="save_to_default" aria-hidden="true">

	<script type="text/javascript">
		function lb_validate_save_to_default(parentform) {
			if (parentform.DefaultsItemName.value == "") {
				alert("<%=defaultsrb.getString("title.Save.PleaseGiveYourDefaultsName")%>");
				return false;
			}
			ap.pleaseWaitLB(true);	
			return true;
		}
	</script>
	
	<div class="modal-dialog">
		<form method="post" action="FrontServlet" id="lb_save_to_default_form" onsubmit="return lb_validate_save_to_default(this);">
			<div class="modal-content">
			
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h2 class="modal-title" id="myModalLabel"><%=defaultsrb.getString("title.Save.PleaseGiveYourDefaultsName")%></h2>
				</div>

				<div class="modal-body">
						
					<p>
						<span style="font-weight: bold"><%=defaultsrb.getString("message.Save.SavingAsDefaults.1A")%></span> <%=defaultsrb.getString("message.Save.SavingAsDefaults.1B")%>
					</p>
					<p>
						<%=defaultsrb.getString("message.Save.SavingAsDefaults.2")%>
					</p>
					<p>
						<label for="DefaultsItemName">
							<%=defaultsrb.getString("label.Save.PleaseGiveYourDefaultsName")%>
						</label>
						<input type="text" id="DefaultsItemName" class="form-control input-sm" name="DefaultsItemName" size="20" maxlength="60" value="" />
					</p>
					<p>
						
						<input type="hidden" name="NEXT" value="SaveToDefaults" />
						<input type="hidden" name="WORKITEMID" value="<%=jspHelper.getWorkItemId()%>" />
						<input type="hidden" name="FROMLIGHTBOX" value="lb_save_to_default" />
						<input type="hidden" name="METHOD" value="Process" />
						<input type="hidden" name="PAGE_NAME" value="<%=htmlPage.getId()%>" />
						<input type="hidden" name="TRANSACTION_NAME" value="<%=htmlPage.getOwningTransaction().getId()%>" />
						<ap:csrf/>
					</p>
					<div class="button-row">
						<input name="defaultsOkButton" type="submit" value="<%=rb.getString("action.Save")%>"	id="defaultsOkButton" class="btn btn-primary" />
						<input name="defaultsCancelButton" type="button" value="<%=rb.getString("action.Cancel")%>"  data-dismiss="modal"  accesskey="o" id="defaultsCancelButton" class="btn btn-default" />
					</div>
				</div>
	
			</div>
		</form>
	</div>
</div>