<%@ page import="com.agencyport.jsp.JSPHelper" %>
<%@ page import="com.agencyport.webshared.IWebsharedConstants" %>
<%@ page import="com.agencyport.trandef.Transaction" %>
<%@page import="com.agencyport.locale.IResourceBundle" %>
<%@page import="com.agencyport.locale.ResourceBundleManager" %>
<%@page import="com.agencyport.locale.ILocaleConstants" %>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils" %>	

<%
JSPHelper jspHelper = JSPHelper.get(request);
IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);

String actionJustApplied = "";
String messageForActionJustApplied = "";
boolean actionWasJustApplied = jspHelper.actionWasJustApplied();

Transaction transaction = jspHelper.getTransaction();

if (actionWasJustApplied) 
	actionJustApplied = jspHelper.getActionJustApplied();

if (transaction.getType().equals("QUICK_QUOTE")) { %>
	<%@include file="convert/confirm.jsp" %>
<% } if (actionWasJustApplied && actionJustApplied.equals(IWebsharedConstants.CONVERT_TO_APPLICATION)) {
%>
	<%@include file="convert/just_converted.jsp" %>
<% } %>