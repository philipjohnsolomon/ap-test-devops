<%@ page import="com.agencyport.locale.LocaleFactory" %>
<%@ page import="com.agencyport.locale.LocaleStore" %>
<%@ page import="com.agencyport.locale.IResourceBundle" %>
<%@ page import="com.agencyport.locale.ResourceBundleManager" %>
<%@ page import="com.agencyport.locale.ILocaleConstants" %>
<%@ page import="com.agencyport.security.constants.ISecurityConstants" %>
<%@ page import="com.agencyport.security.exception.SecurityException" %>
<%@ page import="java.util.Locale"%>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal"%>

<%
	// Since there is no session, we will get resource bundle based on the best guessing the locale from the request and or application properties.
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.SECURITY_REFERENCE_BUNDLE, request);
	SecurityException securityException = (SecurityException) request.getAttribute(ISecurityConstants.LOGON_STATUS);
%>


<script type="text/javascript">
	var ap = ap || {};
	
	ap.forgotPswdBackgroundMan = new ap.DynamicBackgroundManager(1, 19);
	ap.forgotPswdBackgroundMan.applyRandomBackground();
</script>

<!-- Adding core_prompts resource bundles for JavaScript use -->
<ap:ap_rb_loader rbname="core_prompts" />

<!-- start logon box -->
<div class="container logon-block">
	<div class="row">
		<div class="col-sm-6 col-md-4 col-sm-offset-3 col-md-offset-4">
			<h2 class="animated fadeIn"><%=rb.getString("title.ForgotPassword")%></h2>
			<div class="logon-box">
				<div class="logon-logo animated fadeIn">
					<a href="#"></a>
				</div>
				<hr />
				
				<div class="logon-form">
				
					<% if (securityException != null) { %>
					<div class="alert alert-warning alert-dismissable">
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						<p><%=securityException.getMessage()%></p>
					</div>
					<% } %>

					<form class="form-signin" role="form" method="POST" action="ProcessForgotPassword?rnd=<%=Math.random()%>" id="forgotPassword" name="forgotPassword">					
						<input type="email" class="form-control" autocapitalize="off" placeholder="<%=rb.getString("label.EmailAddress")%>" name="emailAddress" id="emailAddress" required autofocus> 
						<button class="btn btn-logon animated fadeIn" name="NEXT" id="continueButton" type="submit"><%=rb.getString("action.RequestPassword")%></button>
					</form>
					
					<br/>
					<div class="logon-links">
						<a href="DisplayLogonForm?rnd=<%=Math.random()%>"><%=rb.getString("action.Cancel")%></a>
					</div>

					<br/>
					<p class="credit">©<script type="text/javascript">document.write((new Date()).getFullYear());</script> Agencyport Software All Rights Reserved.</p>
					
				</div> <!-- /.logon-form -->
			</div> <!-- /.logon-box -->
     		
		</div> <!-- /.col-* -->
	</div> <!-- /.row -->
</div> <!-- /.container -->