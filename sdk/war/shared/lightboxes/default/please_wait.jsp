<%@ page import="com.agencyport.locale.IResourceBundle"%>
<%@ page import="com.agencyport.locale.ResourceBundleManager"%>
<%@ page import="com.agencyport.locale.ILocaleConstants"%>
<%
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
%>

<!-- Modal -->
<div class="modal fade" id="lb_please_wait" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-body">
				<p><%=rb.getString("message.PleaseWait")%>...</p>
			</div>
		</div>
	</div>
</div>
