<%@ page
	import="com.agencyport.defaults.DefaultsItem,
	com.agencyport.data.corrections.*,
	com.agencyport.trandef.Transaction,
	com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%

JSPHelper jspHelper = JSPHelper.get(request);
TransactionCorrectionReport[] tcrs = jspHelper.getTransactionCorrectionReports();
Transaction transaction = jspHelper.getTransaction();
IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
IResourceBundle virb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.VALIDATION_INFO_BUNDLE);

boolean isQuickQuote = false;
if (transaction.getType().equals("QUICK_QUOTE")) {
	isQuickQuote = true;
}
if (tcrs.length > 0) {
	CorrectiveActionAudit[] corrections = null;
%>
	<%@include file="tcr/display.jsp" %>
	<%@include file="tcr/help.jsp" %>

<% } %>