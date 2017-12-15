<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.LocaleFactory"%>
<%@page import="java.util.Locale"%>

<%
    Locale locale = LocaleFactory.get().acquireLocale(request);
    IResourceBundle coreRB = ResourceBundleManager.get().getBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE, locale);
%>
<div id="ajaxMessages" class="alert alert-info" ng-if="messages.length > 0">
	<p ng-repeat="message in messages">{{message}}</p>
	<a ng-if="hasSecurityError == true" href="DisplayHomePage" class="btn btn-large btn-primary"><%=coreRB.getString("action.ClickHereToContinue")%></a>
</div>