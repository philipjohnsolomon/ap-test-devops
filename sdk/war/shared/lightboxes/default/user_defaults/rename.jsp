 

<!-- Modal -->
<div class="modal fade" id="lb_rename_default" tabindex="-1" role="dialog" 	aria-labelledby="renameModal" aria-hidden="true">
 	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        		<h2 class="modal-title" id="myModalLabel"><%=defaultsrb.getString("title.Rename.Rename")%></h2>
			</div>
			<form method="post" action="FrontServlet" id="lb_rename_default_form">
				<div class="modal-body">
					<p>
						<label for="DefaultsItemName"><%=defaultsrb.getString("label.Rename.GiveNewName")%></label>
						<input type="text" id="DefaultsItemName" name="DefaultsItemName" class="form-control input-sm" size="30" maxlength="60" value="" />
					</p>
					<p>
						<input type="hidden" name="NEXT" value="RenameDefaults" />
						<input type="hidden" name="DefaultsItemId" value="" />
						<input type="hidden" name="WORKITEMID" value="<%=jspHelper.getWorkItemId()%>" />
						<input type="hidden" name="FROMLIGHTBOX" value="lb_rename_default" />
						<input type="hidden" name="METHOD" value="Process" />
						<input type="hidden" name="PAGE_NAME" value="<%=htmlPage.getId()%>" />
						<input type="hidden" name="TRANSACTION_NAME" value="<%=htmlPage.getOwningTransaction().getId()%>" />
						<ap:csrf/>
												
					</p>
					<div class="button-row">				
						<input name="defaultsOkButton" type="submit" value="<%=rb.getString("action.Save")%>" class="btn btn-primary" />
						<input name="defaultsCancelButton" type="button" value="<%=rb.getString("action.Cancel")%>" data-dismiss="modal" class="btn btn-default" />
					</div>
				</div>
			</form>
		</div>
	</div>
</div>