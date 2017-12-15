<%@ page import="com.agencyport.jsp.JSPHelper,
				com.agencyport.security.profile.ISecurityProfile,
				com.agencyport.account.AccountManagementFeature"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="java.util.Locale"%>
<%@page import="com.agencyport.locale.LocaleFactory"%>
<%@page import="com.agencyport.constants.TurnstileConstantsProvider"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.agencyport.security.profile.impl.SecurityProfileManager"%>
<%@page import="com.agencyport.webshared.URLBuilder"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.agencyport.trandef.Transaction"%>
<%@page import="com.agencyport.domXML.widgets.LOBCode"%>
<%@page import="com.agencyport.trandef.TransactionDefinitionManager"%>
<%@page import="com.agencyport.webshared.IWebsharedConstants"%>

<%
	JSPHelper jspHelper = JSPHelper.get(request);
	ISecurityProfile securityProfile = jspHelper.getSecurityProfile();
	IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE, request);
	String mainMenu = "MainMenu";
	if (AccountManagementFeature.get().isOn()) {
		mainMenu = AccountManagementFeature.get().getAccountMainMenuName();
	}
	
	TreeMap<String, String> quickQuotes = new TreeMap<String, String>();
	TreeMap<String, String> newBusinesses = new TreeMap<String, String>();
	List<Transaction> newBusinessTransactions = new ArrayList<Transaction>();
	List<Transaction> quickQuoteTransactions = new ArrayList<Transaction>();
	if(securityProfile != null){
		List<Transaction> transactions = TransactionDefinitionManager.getTransactions(true); 
		ListIterator<Transaction> iterator = transactions.listIterator();
		Set<String> userPermissions = securityProfile.getRoles().getPermissionNames(securityProfile.getSubject().getPrincipal());

		while (iterator.hasNext()) {
			Transaction tran = iterator.next();
			if (tran == null) {
				continue;
			}
			String permissionForTransaction = "access" + tran.getLob();
			if (!userPermissions.contains(permissionForTransaction)) {
				continue;
			}

			if (tran.getType().equals(IWebsharedConstants.NEW_BUSINESS_TRANSACTION_TYPE)) {
				String url = URLBuilder.buildFrontServletURL(-1, null,Boolean.TRUE.toString(), tran.getId(),URLBuilder.DISPLAY_METHOD, false);
				newBusinesses.put(tran.getTitle(), url);
				newBusinessTransactions.add(tran);
			}

			if (tran.getType().equals(IWebsharedConstants.QUICK_QUOTE_TRANSACTION_TYPE)) {
				quickQuoteTransactions.add(tran);
			}
		}
		
		for(Transaction tran : quickQuoteTransactions){
			for(Transaction newtran : newBusinessTransactions){
				if(newtran.getLob().equals(tran.getLob())){
					String url = URLBuilder.buildFrontServletURL(-1, null,Boolean.TRUE.toString(), tran.getId(),URLBuilder.DISPLAY_METHOD, false);
					quickQuotes.put(newtran.getTitle(), url);
				}
			}			
		}
	}
%>

<div class="navbar navbar-default navbar-fixed-top main-menu" id="main-menu" role="navigation">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only"><%= coreRB.getString("menu.Name.ToggleNavigation") %></span> 
				<span class="icon-bar"></span>
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a href="DisplayHomePage" class="navbar-brand"><%= coreRB.getString("menu.Name.Agencyportal") %></a>
		</div>
		<div class="collapse navbar-collapse">
			<% if (securityProfile != null) {%> 				
				<ul class="nav navbar-nav navbar-right current-user">
					<li class="dropdown">
						<a id="menu-entry-current-user" title="Current User: <%= securityProfile.getSubject().getUserInfo().getFullName() %>" data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="fa"></i><span><%= securityProfile.getSubject().getUserInfo().getFullName() %> <b class="caret"></b></span></a>
						<ul class="dropdown-menu">
							<li><a id="menu-entry-logout" href="ProcessLogoff"><%=coreRB.getString("action.Logout")%></a></li>
						</ul>
					</li>					
				</ul>
												
				<ul class="nav navbar-nav navbar-right get-started">
					<li class="dropdown">
						<a id="menu-entry-get-started" title="Get Started" data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="fa"></i><span><%=coreRB.getString("menu.get.started")%><b class="caret"></b></span></a>
						<ul class="dropdown-menu">
							<% if(TurnstileConstantsProvider.isTurnstileEnabled()){%> 							
								<li><a id="menu-entry-get-started-upload" href="javascript:ap.turnstileWidget.launchUploadWidget();"><%=coreRB.getString("menu.get.started.upload")%><span id="upload-status-count" class="badge"></span></a></li>							
							<%} %>
						
							<%if(quickQuotes.size() > 0){ %>
								<li class="divider" role="presentation"></li>
								<li class="dropdown-header" role="presentation"><span><%=coreRB.getString("menu.get.started.quickquote")%></span></li>		
								<%
								SortedSet<String> keys = new TreeSet<String>(quickQuotes.keySet());
								for (String key : keys) { %>
									<li><a href="<%= quickQuotes.get(key) %>"><%=key%></a></li>
								<%} 
							}%>
						
							<li class="divider" role="presentation"></li>
							<li class="dropdown-header" role="presentation"><span><%=coreRB.getString("menu.get.started.policyapp")%></span></li>	
							<%
							SortedSet<String> titles = new TreeSet<String>(newBusinesses.keySet());
							for (String title : titles) { %>
								<li><a href="<%= newBusinesses.get(title) %>"><%=title%></a></li>
							<%} %>
						</ul>
					</li>					
				</ul>

				<%=jspHelper.getMenuHtml(mainMenu)%>	
															
			<% } %>
		</div>
	<!-- /.navbar-collapse -->
	</div>
</div>
<script type="text/javascript" language="javascript">
	var url = window.location.href
	$(".navbar-nav").find(".active").removeClass("active");
	 $(".navbar-nav a").each(function(index){
		 if(url.indexOf($(this).attr('href'))>0){
			 $(this).parent().addClass("active");
		 }
	});
 </script>
 
 <% 
 	if(null != securityProfile) {
 		%>
 			<!-- Global turnstile widget. -->
		<jsp:include page="../shared/lightboxes/default/turnstile_upload_widget.jsp" flush="true"/>
 		<% 
 	}
 %>
 