<%@ page import="com.agencyport.locale.ResourceBundleManager" %>
<%@ page import="com.agencyport.locale.ILocaleConstants" %>
<%@ page import="com.agencyport.locale.IResourceBundle" %>
<%@ page import="com.agencyport.locale.ResourceBundleStringUtils" %>
<% IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE); %>

<!-- Modal -->
<div class="modal fade" id="lb_confirm_exit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

	<script type="text/javascript">
		function lb_handleYes() {	
			$("#lb_confirm_exit").modal("toggle");
			if(page.action == 'left_nav_menu')  {
				page.checkSaveStatus=false;
				page.navigatingToPage.executeClickEvents();
			}
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
					<input name="yesButton" type="button" class="btn btn-primary" value="<%=rb.getString("action.Yes")%>" accesskey="o" onclick="lb_handleYes()" /> 
					<input name="noButton" type="button" class="btn btn-default" value="<%=rb.getString("action.No")%>" data-dismiss="modal"  />
				</div>
			</div>

		</div>
	</div>
</div>