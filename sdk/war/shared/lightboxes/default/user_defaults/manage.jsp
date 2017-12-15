
<!-- Modal -->
<div class="modal fade" id="lb_manage_default" tabindex="-1" role="dialog"	aria-labelledby="myModalLabel" aria-hidden="true">

	<script type="text/javascript">
		ap.DefaultLightboxManager = function() {
			this.list = new Array();
			
			this.addListing = function(listing) {
				this.list.push(listing);
			};
			
			this.getListing = function(id) {
				for (var i=0; i< this.list.length; i++)
					if (this.list[i].id == id) 
						return this.list[i];
			};
			
			this.deleteDefault = function(id) {	
				var listing = this.getListing(id);
				$('#lb_manage_default_form [name="DefaultsItemId"]').val(listing.id);
				$('#lb_confirm_delete_default_title').html(listing.name);
				return true;
			};
			this.rename = function(id) {
				var listing = this.getListing(id);
				$('#lb_rename_default_form [name="DefaultsItemId"]').val(listing.id);
				$('#lb_rename_default_title').innerHTML = listing.name;
			};
		};
		ap.defaultLightboxManager = new ap.DefaultLightboxManager();
		
	</script>
 

	<div class="modal-dialog">
		<div class="modal-content">
			<form method="post" action="FrontServlet" id="lb_manage_default_form">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        			<h2 class="modal-title" id="myModalLabel"><%=defaultsrb.getString("header.Manage.SavedDefaults")%></h2>
				</div>
	
				<div class="modal-body">
				
					<table class="table table-striped" id="lb_manage_defaults_table">
						<%
						for (int ix = 0; ix < defaultsList.length; ix++) {
							String rawDefaultsName = defaultsList[ix].getDefaultsName();
							String htmlSafeDefaultsName = JSPHelper.prepareForHTML(rawDefaultsName);
							String jsSafeDefaultsName = JSPHelper.prepareForJavaScript(rawDefaultsName);
							%>
							<script type="text/javascript">
								ap.defaultLightboxManager.addListing({name:'<%= jsSafeDefaultsName %>',id:<%=defaultsList[ix].getDefaultsId()%>});
							</script>
							<tr>
								<td>
									<span style="font-weight: bold"><%= htmlSafeDefaultsName %></span></td>
								<td>
									<a
										href="#lb_rename_default" data-toggle="modal" data-dismiss="modal"
										onclick="ap.defaultLightboxManager.rename(<%=defaultsList[ix].getDefaultsId()%>)" 
										title="<%=defaultsrb.getString("title.Manage.Rename")%>"><span><%=defaultsrb.getString("action.Manage.Rename")%></span>
									</a>
								</td>
								<td>
									<a
										href="#lb_confirm_default_delete" data-toggle="modal" data-dismiss="modal" 
										onclick="ap.defaultLightboxManager.deleteDefault(<%=defaultsList[ix].getDefaultsId()%>)"
										title="<%=defaultsrb.getString("title.Manage.Delete")%>"><span><%=defaultsrb.getString("action.Manage.Delete")%></span>
									</a>
								</td>
							</tr>
							<%
						}
						%>
					</table>
					<div class="button-row">
						<input name="defaultsCancelButton" type="button" value="<%=rb.getString("action.Cancel")%>" data-dismiss="modal" id="defaultsCancelButton" class="btn btn-default" />
					</div>
					
					<input type="hidden" name="NEXT" value="DeleteDefaults" />
					<input type="hidden" name="DefaultsItemId" value="" />
					<input type="hidden" name="WORKITEMID" value="<%=jspHelper.getWorkItemId()%>" />
					<input type="hidden" name="FROMLIGHTBOX" value="lb_manage_default" />
					<input type="hidden" name="METHOD" value="Process" />
					<input type="hidden" name="PAGE_NAME" value="<%=htmlPage.getId()%>" />
					<input type="hidden" name="TRANSACTION_NAME" value="<%=htmlPage.getOwningTransaction().getId()%>" />
					<ap:csrf/>
					
				</div>
	
			</form>
		</div>
	</div>
</div>