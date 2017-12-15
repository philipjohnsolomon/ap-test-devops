<!DOCTYPE html>
<!-- error/404.jsp-->
<%@ page import="com.agencyport.locale.IResourceBundle" %>
<%@ page import="com.agencyport.locale.ResourceBundleManager" %>
<%@ page import="com.agencyport.locale.ILocaleConstants" %>
<%@ page import="com.agencyport.servlets.base.IBaseConstants" %>

<%@ page import="com.agencyport.utils.AppProperties" %>
<%@ page import="com.agencyport.utils.text.CharacterEncoding" %>

<% IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE); %>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<title><%= coreRB.getString("head.Title.AgencyPortal") %></title>
		<meta name="description" content="Agencyport Web Application V10.0">
		<meta name="author" content="Agencyport">
		<meta http-equiv="Content-Type" content="text/html; charset=<%=CharacterEncoding.get().getCharacterEncoding()%>">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
	
		<link href="${pageContext.request.contextPath}/assets/themes/agencyportal/agencyportal.css" rel="stylesheet">
	  
		<!-- Fav and touch icons -->
		<link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath}/assets/ico/apple-touch-icon-144-precomposed.png">
		<link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/assets/ico/apple-touch-icon-114-precomposed.png">
		<link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/assets/ico/apple-touch-icon-72-precomposed.png">
		<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/assets/ico/apple-touch-icon-57-precomposed.png">
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/ico/favicon.ico">	
	    
		<script src="${pageContext.request.contextPath}/assets/js/agencyportal.js" type="text/javascript"></script>	
	</head>
	<body class="error-404">
	
		<div class="agencyportal-5">
			<!--  Navigation Bar -->
			<jsp:include page="../menu/menu.jsp" flush="true" />
			
			<section class="error-404-section">
				<div class="container">
					<h1><%= coreRB.getString("header.Title.404.header") %></h1>
					<p><%= coreRB.getString("message.404") %></p>
					<a href="${pageContext.request.contextPath}/DisplayHomePage" class="btn btn-large btn-primary display-home-page">
						<i class="fa fa-white"></i> <%= coreRB.getString("message.GoHome") %>
					</a>
				</div>
			</section>
			<jsp:include page="../home/footer.jsp" flush="true" />
		</div>
		
	</body>
</html>