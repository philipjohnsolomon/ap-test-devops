<%@page import="com.agencyport.account.AccountDetails"%>
<%@page import="java.util.List"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="account_upload">
	<%
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);

	String searchVal="";
	String accountNumberVal = (String) request.getParameter("account_number");
	String cityVal = (String) request.getParameter("city");
	String stateVal = (String) request.getParameter("state");
	String zipVal = (String) request.getParameter("zip");
	
	List<AccountDetails> matchingAccounts = jspHelper.getMatchingAccounts();
	
	%>
	<span>
		<%
			if(matchingAccounts.size() == 0){
		%>
			<p><b>${UPLOAD_RB['account.not.found']}</b>&nbsp;${UPLOAD_RB['account.not.found1']}</p>
		<%}else{
		%>
			<p><b>${UPLOAD_RB['account.found']}</b>&nbsp;${UPLOAD_RB['account.found1']}</p>
		<%
		}
		%>
	</span>

	<%@include file="../../../../account/autosearch.jsp" %>
	
	<div id="account_search_result_container">
		<input id="matchedAccountLink" type="hidden" value="${matchedAccountLink}">
		<div id="account_search_results">
			<div id="lb_account_list" class="lb_account_container">
				<table  border="0" cellspacing="0" cellpadding="0" summary="Accounts">
					<thead>	
						<tr>
							<th class="lb_acct_type"><%=accountRB.getString("account.management.label.type")%></th>
							<th class="lb_acct_name"><%=accountRB.getString("account.management.label.accountName")%></th>
							<th class="lb_acct_number"><%=accountRB.getString("account.management.label.accountHashTag")%></th>
							<th class="lb_acct_addr"><%=accountRB.getString("account.management.label.accountAddr")%></th>
							<th class="lb_acct_button"><%=accountRB.getString("account.management.label.action")%></th>
						</tr>
					</thead>
					<tbody id="lightboxSearchResults">
						<%
							if(matchingAccounts.size() == 0){
						%>
							<tr></tr>
						<%
							}else{
								for(int i=0; i< matchingAccounts.size(); i++){
									AccountDetails account = matchingAccounts.get(i);
									String id = account.getAccountId().toString();
									String accountNumber = account.getAccountNumber();
									String type = account.getAccountType();
									String entityName = account.getAccountWorkItem().getEntityName();
									String accountType = rb.getString("account.management.accounttype.personal");
									if (account.getAccountType().equals("C")) {
										accountType = rb.getString("account.management.accounttype.commercial");
									}
									String address = account.getStreetAddress() + account.getCityStateZip();
									
									String rowclass = (i % 2== 0) ?"roweven":"rowodd";
									String rowId = "account_" + id;
									String rowCss = "account_css_" + id;
						%>
								<tr class="<%= rowclass %>  account_row" id="<%=rowId%>">
								    <input type="hidden" id="<%=rowCss %>" value="<%= rowclass %>" />
								    <td><div style="text-align:left;"><%=type%></div></td>
									<td><div style="text-align:left;"><%=entityName%></div></td>
									<td><div style="text-align:left;"><%=accountNumber%></div> </td>
									<td><div style="text-align:left;"><%=address%></div></td>
									<td><div style="text-align:left;"><input type="button" id="<%=id%>" onclick="javascript: ap.accountSearchMgr.upload(<%=id%>)" value="<%=accountRB.getString("account.management.label.select")%>"/></div></td>
								</tr>							
						<%
								}
							}
						%>
						
					</tbody>
				</table>
			</div>
		</div>	
	</div>
	<script type="text/javascript">
		ap.accountSearchMgr = new ap.AccountSearchManager();
		ap.accountSearchMgr.initialize();
	</script>
	<div class="actions">
   		<p><span>${UPLOAD_RB['account.new']}</span>
 			<span>
 				<input id="accountTransaction" type="hidden" value="${accountTransaction}">
 				<input type="button" value="${UPLOAD_RB['account.create']}" onclick="ap.account_upload.handleNewAccount('accountTransaction')" />
 			</span>
 			<span>${UPLOAD_RB['account.or']}</span>	
 			<span>
 				<input type="button" value="${UPLOAD_RB['account.createlater']}" onclick="window.location='DisplayWorkInProgress?WorkListType=PendingItemsView'" />
 			</span>	
		</p>
	</div>
</div>


