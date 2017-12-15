<%@page import="java.util.Locale"%>
<%@page import="com.agencyport.locale.LocaleFactory"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%><!-- \shared\navigation_error.jsp-->
<%
Locale locale = LocaleFactory.get().acquireLocale(request);
IResourceBundle coreRB = ResourceBundleManager.get().getBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE, locale);
coreRB = coreRB.getHTMLEncoder();
%>

<h2><%=coreRB.getString("message.ApplicationNavigationErrorHeader")%></h2>
<p><%=coreRB.getString("message.ApplicationNavigationError")%></p>