<%@page import="com.agencyport.account.model.IAccount"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.agencyport.jsp.JSPHelper,
				com.agencyport.product.ProductDefinitionsManager"%>

<%
	JSPHelper jspHelper = JSPHelper.get(request);
	String versionNumber = ProductDefinitionsManager.getCurrentlyRunningVersion().toString();
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
	
	int count = 0;
	JSONObject results = (JSONObject)request.getAttribute("SEARCH_RESULTS");
	JSONObject resObj = null;
	if(!results.isNull("response")){
		resObj = results.getJSONObject("response");		
		count = resObj.getInt("numFound");
	}

	String searchVal = (String) request.getParameter("value");
	String sortVal = (String) request.getParameter("sort");
	if(sortVal == null){
		sortVal = "";
	}
	String accountTypeVal = (String) request.getParameter("account_type");
	if(accountTypeVal == null){
		accountTypeVal = "";
	}
	
	String accountNumberVal = (String) request.getParameter("account_number");
	String cityVal = (String) request.getParameter("city");
	String stateVal = (String) request.getParameter("state_prov_cd");
	String zipVal = (String) request.getParameter("zip");
	
%>

<div id="pageBody" class="noMenu">
	<section id="accountSearchResults">
		<div class="container">
		    <%
		    String dupfound = request.getParameter("DUP_FOUND");
		    if(dupfound!= null && dupfound.equals("true")){
		      %>
			<!-- Duplicate Account message -->
		    <div id="alert_warning" class="alert alert-warning">
				<strong>${CORE_RB['alert.heading.warning']}</strong> 	
				%=accountRB.getString("account.management.duplicateAccountMsg","The account you're trying to create may already exist.") %>
		    </div>
		    <%}%>
		    
		    <%
		    if(count == 0 && resObj != null){
		      %>
			<!-- no results found -->
		    <div id="alert_warning" class="alert alert-warning">
				<strong>${CORE_RB['alert.heading.warning']}</strong> 
				<%=accountRB.getString("account.management.noMatchingAccountMsg","We can't find any accounts that match your search.") %>
		    </div>
		    <%}%>
		    
		    <%
		    if(!results.isNull("error")){
		    	JSONObject errObj = results.getJSONObject("error");
		    	String message = accountRB.getString("account.management.search.invalidInput") + searchVal;
		      %>
			<!-- Error message -->
		    <div id="alert_critical" class="critical">
				<h4 class="critical">${CORE_RB['alert.heading.error']}</h4>
				<p><%=message%></p>
		    </div>
		    <%}%>
		    
			<!-- TOP BAR -->
			
			<h2 class="search-results-title">
				Search Results
				<div class="form-group form-inline pull-right" id='account_controls'>
					<label class="small" for="createNewAccount">Not what you're looking for?</label>
					<input class="btn btn-primary" type="button" value="Create New Account"  id="createNewAccount" placeholder="Create New Account">
				</div>
			</h2>
			<form class="form-inline sort-by" role="form" id="accountSearchResults">
				<div class="row">
					<div class="col-md-4 results-sorters">
						<span class="counter"><span class="amount"><%=count%> </span><%=(count==1)?accountRB.getString("account.management.label.account", "Account"):accountRB.getString("account.management.label.accounts", "Accounts")%></span>
						<div class="form-group filter">
							<label class="sr-only" for="exampleInputEmail2"><%=accountRB.getString("label.SearchResults.Type") %></label>
							<select class="form-control" id="filter" onchange="javascript: ap.accountSearchMgr.launchSearch()">
								<option value="" <%=(accountTypeVal.equals(""))?"selected":"" %>><%=accountRB.getString("account.management.label.any", "Any")%></option>
								<option value="P" <%=(IAccount.AccountType.isPersonal(accountTypeVal))?"selected":"" %>><%=accountRB.getString("account.management.label.people", "People")%></option>
								<option value="C" <%=(IAccount.AccountType.isCommercial(accountTypeVal))?"selected":"" %>><%=accountRB.getString("account.management.label.companies","Companies")%></option>
							</select>
						</div>
						<div class="form-group sort">
							<label class="sr-only" for="exampleInputPassword2"><%=accountRB.getString("label.SearchResults.SortBy") %></label>
							<select class="form-control" id="sortresults" class="sort-results" onchange="javascript: ap.accountSearchMgr.launchSearch()">
								<option value="last_update_time desc" <%=(sortVal.equals("last_update_time desc"))?"selected":""%>><%=accountRB.getString("account.management.sort.last_update_time", "Last Updated")%></option>
								<option value="creation_time desc" <%=(sortVal.equals("creation_time desc"))?"selected":""%>><%=accountRB.getString("account.management.sort.recentCreated", "Recently Created")%></option>
								<%
									if(IAccount.AccountType.isPersonal(accountTypeVal)){
								%>
								<option value="lastName asc" <%=(sortVal.equals("lastName asc"))?"selected":""%>><%=accountRB.getString("account.management.sort.lastNameA-Z", "Last Name: A-Z")%></option>
								<option value="lastName desc" <%=(sortVal.equals("lastName desc"))?"selected":""%>><%=accountRB.getString("account.management.sort.lastNameZ-A", "Last Name: Z-A")%></option>
								<%	}else if(IAccount.AccountType.isCommercial(accountTypeVal)){
								%>
								<option value="other_name asc" <%=(sortVal.equals("other_name asc"))?"selected":""%>><%=accountRB.getString("account.management.sort.companyA-Z", "Company Name: A-Z")%></option>
								<option value="other_name desc" <%=(sortVal.equals("other_name desc"))?"selected":""%>><%=accountRB.getString("account.management.sort.companyZ-A", "Company Name: Z-A")%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>				
					
					<div id="account_search_content" class="fcol-md-8 account_search">
						<%@include file="autosearch.jsp" %>
					</div>
				</div>
			</form>
		</div>
	</section>
	<section id="">
		<div class="container">
			<div class="searchresults">
				<!--  TITLES for RESULTS -->
				<% 
					if(resObj != null){
						
						JSONObject highlightingObj = results.getJSONObject("highlighting");
			
						JSONArray docs = resObj.getJSONArray("docs");
						for(int i=0; i<count; i++){
							JSONObject doc = docs.getJSONObject(i);
							String id = doc.getString("id");
							String account_number = doc.getString("account_number");;
							String type = doc.getString("account_type");
							String name = "";
							if(IAccount.AccountType.isPersonal(type)){
								name = doc.getString("firstName") + " " + doc.getString("lastName");
							}else{
								name = doc.getString("other_name");
							}
		
							String streetAddr = doc.getString("address");
							String cityStateZip = doc.getString("city") + ", " + doc.getString("state_prov_cd") +  " " + doc.getString("postal_code");
				%>
				<div class="col-xs-12 col-sm-6 col-md-4">
					<div class="tile account <%=type%>"  onclick="javascript: ap.accountSearchMgr.launchAccount(<%=id%>);">
						<i class="fa fa-user lob-icon"></i>
						<i class="fa fa-building-o lob-icon"></i>
						<ul>
							<li class="companyName"><%=name%></li>
							<li class="type"><%=type%></li>
							<li class="account-number"><%=accountRB.getString("account.management.label.accountHashTag","Account #")%>&nbsp;<%=account_number%></li>
							<li class="address"><%=streetAddr%></li>
							<li class="address"><%=cityStateZip%></li>
						</ul>
					</div>
				</div>
				<%
						}
					}
				%>
			</div>
		</div>	
	</section>


</div>	
<!-- BODY -->


<script type="text/javascript">
	ap.accountSearchMgr = new ap.AccountSearchManager();
	ap.accountSearchMgr.initialize();
</script>
