<%@page import="com.agencyport.account.model.IAccount"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.account.IAccountConstants"%>

<%
	JSPHelper jspHelper = JSPHelper.get(request);
	JSONObject results = (JSONObject) request.getAttribute("SEARCH_RESULTS");
	int count = 0;
	JSONObject resObj = null;
	try{
		resObj = results.getJSONObject("response");
		count = resObj.getInt("numFound");
	}catch(Exception e){
		e.fillInStackTrace();
	}
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
%>
<%if(count > 0) {%>
<div id="move_workitem_account_list" class="move_workitem_container">
	<div id="result_account_list" class="result_account_container result_account_container_height">
		<table border="0" cellspacing="0" cellpadding="0" summary="Accounts" class="account_table">
			<thead>	
				<tr>
					<th width="5%"><%=rb.getString("account.management.label.type")%></th>
					<th width="40%"><%=rb.getString("account.management.label.accountName")%></th>
					<th width="13%"><%=rb.getString("account.management.label.accountHashTag")%></th>
					<th width="35%"><%=rb.getString("account.management.label.accountAddr")%></th>
					<th width="7%" id="account_action_column"><%=rb.getString("account.management.label.action")%></th>
					</tr>
			</thead>
	
	
		<tbody id="lightboxSearchResults">
		<%
		JSONArray docs = resObj.getJSONArray("docs");
		for (int i = 0; i < count; i++) {
			JSONObject doc = docs.getJSONObject(i);
			String id = doc.getString("id");
			String account_number = doc.getString("account_number");
			String type = doc.getString("account_type");
            String entityName = doc.getString("entity_name");
			String accountType = rb.getString("account.management.accounttype.personal");
			if (IAccount.AccountType.isCommercialAccount(type)) {
				accountType = rb.getString("account.management.accounttype.commercial");
			}
			String address = doc.getString("address");
			
			String rowclass = (i % 2== 0) ?"roweven":"rowodd";
			String rowId = "account_" + id;
			String rowCss = "account_css_" + id;
	%>
			<tr class="<%= rowclass %>  account_row"  id="<%=rowId%>">
			    <input type="hidden" id="<%=rowCss %>" value="<%= rowclass %>" />
			    <td width="5%"><div  style="text-align:left;"><%=type%></div></td>
				<td width="40%"><div  style="text-align:left;"><%=JSPHelper.prepareForHTML(entityName)%></div></td>
				<td width="13%"><div  style="text-align:left;"><%=JSPHelper.prepareForHTML(account_number)%></div> </td>
				<td width="35%"><div  style="text-align:left;"><%=JSPHelper.prepareForHTML(address)%></div></td>
				<td width="7%"><div  style="text-align:left;"><input type="button" id="<%=id%>" class="account_action_button" onclick="javascript: ap.account.doMoveOrMerge(<%=id%>)" value="<%=rb.getString("account.actions.merge")%>"/></div></td>
			</tr>
	<%
		}
	%>
		</tbody>
	</table>
	</div>
</div>
<%}else{ %>
	<div id="move_workitem_account_list" class="move_workitem_container">	
	  <div id="no_account" class="no_workitem_warning"><%=rb.getString("account.management.noMatchingAccountMsg")%></div>
	</div>
<%} %>
