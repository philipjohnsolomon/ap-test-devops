<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
%>

<div class="modal-header">
	<h2 class="modal-title"></h2>
</div>
<div class="modal-body">
	<p><%=rb.getString("message.PleaseWait")%>...</p>
</div>
