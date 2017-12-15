<%@ page import="com.agencyport.constants.PageConstantsProvider" %>
<%@ page import="com.agencyport.locale.LocaleFactory" %>
<%@ page import="com.agencyport.locale.LocaleStore" %>
<%@ page import="com.agencyport.locale.IResourceBundle" %>
<%@ page import="com.agencyport.locale.ResourceBundleManager" %>
<%@ page import="com.agencyport.locale.ILocaleConstants" %>
<%@ page import="com.agencyport.security.constants.ISecurityConstants" %>
<%@ page import="com.agencyport.security.exception.AuthenticationFailedException" %>
<%@ page import="com.agencyport.security.exception.SecurityException" %>
<%@ page import="com.agencyport.security.exception.PasswordChangeRequiredException" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal"%>

<%
	// Since there is no session, we will get resource bundle based on the best guessing the locale from the request and or application properties.
	IResourceBundle securityRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.SECURITY_REFERENCE_BUNDLE, request);
	SecurityException securityException = (SecurityException) request.getAttribute(ISecurityConstants.LOGON_STATUS);
	boolean newPasswordRequired = false;
	boolean authenticationFailed = false;
	if ( securityException instanceof PasswordChangeRequiredException ) {
		newPasswordRequired = true; 
	} else if (securityException instanceof AuthenticationFailedException){
		authenticationFailed = true;
	}
	String returnPage = (String) request.getAttribute(PageConstantsProvider.getReturnToPageAttributeName()); 
	String isNew = (String) request.getAttribute("IS_NEW_WORKITEM");
	
%>

<script type="text/javascript">
	var ap = ap || {};
	
	ap.loginBackgroundMan = new ap.DynamicBackgroundManager(1, 19);
	ap.loginBackgroundMan.applyRandomBackground();
</script>

<!-- Adding core_prompts resource bundles for JavaScript use -->
<ap:ap_rb_loader rbname="core_prompts" />

<!-- start logon box -->
<div class="container logon-block">

	<div class="logon-box col-sm-6 col-md-4 col-sm-offset-3 col-md-offset-4">
		<div class="logon-logo animated fadeIn">
			<a href="#"></a>
			<h2 class="animated fadeIn"><%=securityRB.getString("legend.Signon")%></h2>
		</div>
		<hr />
		
		<div class="logon-form">
		
			<% if (securityException != null) { %>
			<div class="alert alert-warning alert-dismissable">
				<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				<%if (newPasswordRequired) { %>
				<%=securityRB.getString("message.OldPasswordExpired") %>	 
					<a onclick="javascript: ProfileManager.showChangePassword();void(0)" href="javascript: void(0)"><%=securityRB.getString("action.ChangePassword")%></a>
				<% } else if (authenticationFailed){ %>
				<%=securityRB.getString("message.EnsureUserNamePassword") %>
				<% } else { %>
				<%=securityException.getMessage()%> 
				<% } %>
			</div>
			<% } %>
			
			<% if (request.getParameter("change") != null) { %>
			<div class="alert alert-success alert-dismissable">
				<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				<p><%=securityRB.getString("message.NewPasswordSent")%></p>
			</div>
			<% } %>					

			<form class="form-signin" role="form" method="POST" action="ProcessLogonForm" >
				<input type="text" tabindex="1" class="form-control" autocapitalize="off" placeholder="<%=securityRB.getString("label.UserName")%>" name="USERID" id="USERID" required autofocus> 
				<input type="password" tabindex="2" class="form-control" placeholder="<%=securityRB.getString("label.Password")%>" name="PASSWORD" id="PASSWORD" autocomplete="off" required> 
				<button tabindex="3" class="btn btn-logon animated fadeIn" name="NEXT" id="NEXT" type="submit"><%=securityRB.getString("action.Signon")%></button>
									
				<!-- START: For upload "auto logon" feature  -->
				<% if (returnPage != null) { %> <input type="hidden" name="<%=PageConstantsProvider.getReturnToPageAttributeName()%>" value="<%=returnPage%>"> <% } %>
				<% if (isNew != null) { %> <input type="hidden" name="IS_NEW_WORKITEM" value="<%=isNew%>"> <% } %>
				<!-- END: For upload "auto logon" feature  -->
			</form>

			<div class="text-center forgot-password">
				<a tabindex="4" href="DisplayForgotPassword?rnd=<%=Math.random()%>"><%=securityRB.getString("action.ForgotPassword")%></a>
			</div>
			<br>
			
			<p class="credit">&copy;<script type="text/javascript">document.write((new Date()).getFullYear());</script> <%=securityRB.getString("label.Logon.RightsReserved")%></p>
		</div>
	</div>

</div>