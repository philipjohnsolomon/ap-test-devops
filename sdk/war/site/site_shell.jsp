<!DOCTYPE html>
<!-- site/site_shell.jsp-->
<%@ page import="com.agencyport.jsp.JSPHelper" %>
<%@ page import="com.agencyport.utils.AppProperties" %>
<%@ page import="com.agencyport.security.profile.ISecurityProfile" %>
<%@ page import="com.agencyport.product.ProductDefinitionsManager" %>
<%@ page import="com.agencyport.utils.text.CharacterEncoding" %>
<%@ page import="com.agencyport.utils.AppProperties" %>
<%@ page import="com.agencyport.servlets.base.IBaseConstants" %>
<%@ page import="com.agencyport.locale.LocaleStore" %>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%@ page import="java.util.Locale" %>

<%
JSPHelper jspHelper = JSPHelper.get(request);
ISecurityProfile securityProfile = jspHelper.getSecurityProfile();
String versionNumber = ProductDefinitionsManager.getCurrentlyRunningVersion().toString();
String np = (String)request.getAttribute(IBaseConstants.NEXT_PAGE);

String bodyClass = (String)request.getAttribute("bodyClass");
Locale currentLocale = LocaleStore.getLocale();
String apLocale = currentLocale.toString();

if (bodyClass == null){
	bodyClass = "";
}
IResourceBundle formatInfoRB = ResourceBundleManager.get().getBundle(ILocaleConstants.FORMAT_INFO_BUNDLE);
IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);

%>
<html lang="en">
	<head>
		<meta charset="<%=CharacterEncoding.get().getCharacterEncoding()%>">
		<title><%= coreRB.getString("head.Title.Agencyportal") %></title>
		<meta name="description" content="Agencyport Web Application V10.0">
		<meta name="author" content="Agencyport">
		<meta http-equiv="Content-Type" content="text/html; charset=<%=CharacterEncoding.get().getCharacterEncoding()%>">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">

		<!--[if !IE]><!-->
			<link href="${pageContext.request.contextPath}/assets/themes/agencyportal/agencyportal.css" rel="stylesheet">
		<!--<![endif]-->
		<!--[if IE]>
			<link href="${pageContext.request.contextPath}/assets/themes/agencyportal/agencyportal-ie9.css" rel="stylesheet">
			<link href="${pageContext.request.contextPath}/assets/themes/agencyportal/agencyportal-ie9-blessed1.css" rel="stylesheet">
		<![endif]-->
              	  
		<!-- Fav and touch icons -->
		<link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath}/assets/ico/apple-touch-icon-144-precomposed.png">
		<link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/assets/ico/apple-touch-icon-114-precomposed.png">
		<link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/assets/ico/apple-touch-icon-72-precomposed.png">
		<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/assets/ico/apple-touch-icon-57-precomposed.png">
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/ico/favicon.ico">	
	    
		<script src="${pageContext.request.contextPath}/assets/js/agencyportal.js" type="text/javascript"></script>
		
		<!-- i18n support -->
		<%
			String path = "/assets/js/locale/angular-locale_" + currentLocale.getLanguage() + ".js"; 
			if(jspHelper.localeResourceExist(path)){
		%>
		<script src="${pageContext.request.contextPath}<%=path%>" type="text/javascript"></script>
		<%
			}
			path = "/assets/js/locale/angular-locale_" + currentLocale.getLanguage() + "-" + currentLocale.getCountry() + ".js"; 
			if(jspHelper.localeResourceExist(path)){
		%>
		<script src="${pageContext.request.contextPath}<%=path%>" type="text/javascript"></script>
		<%
			}
		%>
		
		<script>
	// inject inlined constants
		var ap_locale = '<%=currentLocale.getLanguage()%>';
		var statuses = [];
		<%	
			for(int code: jspHelper.getRestSecurityErrorStatuses()){
		%>
				statuses.push(<%=code%>);
		<%
			}
		%>
		angular.module('ap.common.constants', [])
		.constant('csrf',{
			'<%=jspHelper.getCSRFTokenName()%>': '<%=jspHelper.getCSRFToken()%>' 
		})
		.constant('contextPath', '${pageContext.request.contextPath}')
		.constant('dateFormat', '<%=formatInfoRB.getString("default_display.date_format",null)%>')
		.constant('csrfObject', {'tokenobj' : {
			'<%=jspHelper.getCSRFTokenName()%>': '<%=jspHelper.getCSRFToken()%>' 
		},
		'csrftokenName': '<%=jspHelper.getCSRFTokenName()%>',
		'csrftokenValue': '<%=jspHelper.getCSRFToken()%>'
		})
		.constant('securityErrorCodes', statuses)
	</script>	
	</head>
	<body <%= bodyClass %>>
	 
		<div class="agencyportal-5">
			<!--  Navigation Bar -->
			<jsp:include page="../menu/menu.jsp" flush="true" />
		
			<!-- Page Body (Editable Content) -->
			<jsp:include page="<%=np%>" flush="true" />
	
		</div>
		<!-- Idle Timer -->
		<% if(securityProfile != null){ %>
			<jsp:include page="timer.jsp" flush="true" />
		<%} %>

		
		<script src="${pageContext.request.contextPath}/assets/js/agencyportal-body.js" type="text/javascript"></script>
	</body>
</html>