<!-- Modal -->
<div class="modal fade" id="lb_apply_default" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

	<script type="text/javascript">
		function lb_validate_apply_defaults(parentform) {
			
			if (parentform.DefaultsItemId.options[parentform.DefaultsItemId.selectedIndex].value == "") {
				alert("<%=defaultsrb.getString("title.Apply.PleaseChooseWhichDefaultsApply")%>");
				return false;
			}
			ap.pleaseWaitLB(true);
			return true;
		}
	</script>

	<div class="modal-dialog">
		<form method="post" action="FrontServlet" id="lb_apply_default_form" onsubmit="return lb_validate_apply_defaults(this);">
			
			<div class="modal-content">
				<div class="modal-header">
		        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	    	    	<h2 class="modal-title" id="myModalLabel"><%=defaultsrb.getString("message.Apply.ApplyingDefaults.1")%></h2>
	      		</div>
	      		
				<div class="modal-body">
					<p>
						<span style="font-weight: bold"><%=defaultsrb.getString("message.Apply.ApplyingDefaults.1")%></span>
						<%=defaultsrb.getString("message.Apply.ApplyingDefaults.2")%>
						<a href="#lb_help_default" data-toggle="modal" data-dismiss="modal" title="<%=defaultsrb.getString("title.Apply.ApplyingDefaults")%>"><%=defaultsrb.getString("action.Apply.ApplyingDefaults")%></a>
					</p>

					<select name="DefaultsItemId" class="form-control">
						<option selected="" value=""><%=defaultsrb.getString("title.Apply.ApplyDefaultValuesFrom")%></option>
						<% for (int ix = 0; ix < defaultsList.length; ix++) { %>
						<option value="<%=defaultsList[ix].getDefaultsId()%>"><%=JSPHelper.prepareForHTML(defaultsList[ix].getDefaultsName())%></option>
						<% } %>
					</select> 

					<p>
						<input type="hidden" name="NEXT" value="ApplyDefaults" /> 
						<input type="hidden" name="WORKITEMID"  value="<%=jspHelper.getWorkItemId()%>" /> 
						<input type="hidden" name="FROMLIGHTBOX" value="lb_apply_default" /> 
						<input type="hidden" name="METHOD" value="Process" /> 
						<input type="hidden" name="PAGE_NAME" value="<%=htmlPage.getId()%>" />
						<input type="hidden" name="TRANSACTION_NAME" value="<%=htmlPage.getOwningTransaction().getId()%>" />
						<ap:csrf/>
					</p>
					
					<div class="button-row">
						<input name="defaultsOkButton" type="submit" value="<%=defaultsrb.getString("action.Apply.Apply")%>"id="defaultsOkButton" class="btn btn-primary" /> 
						<input name="defaultsCancelButton" type="button" value="<%=rb.getString("action.Cancel")%>" data-dismiss="modal" id="defaultsCancelButton" class="btn btn-default" /> 
					</div>
				</div>

			</div>
		</form>
	</div>
</div>