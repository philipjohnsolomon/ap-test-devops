
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%><%
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
%>
<div id="lb_confirm_timeline" class="lightbox_panel lb_question"
	style="display: none">
	<script type="text/javascript">
		function lb_timeline_handleYes() {	
			lightbox.hide();
			timeline.showTimeline();
		}
		function lb_timeline_handleNo() {			
			lightbox.close();
		}
	</script>
	<p><%=ResourceBundleStringUtils.makeSubstitutions(rb.getString("action.Confirm.ExitTitle"), "<span style=\"font-weight: bold\">", "</span>")%></p>
	<p><%=rb.getString("action.Confirm.ExitQuestion")%></p>
	<p>
		<input name="yesButton" type="button" value="<%=rb.getString("action.Yes")%>" accesskey="o"
			onclick="lb_timeline_handleYes()" />
		&nbsp;
		<input name="noButton" type="button" value="<%=rb.getString("action.No")%>"
			onclick="lb_timeline_handleNo()" />
	</p>
</div>