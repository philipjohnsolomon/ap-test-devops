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


<table class="table table-condensed table-striped prepend-top turnstile-account-search-listing">
	<thead>
		<tr ><th colspan="4"><%=count %>&nbsp;<%=rb.getString("account.management.search.found") %></th></tr> 
	</thead>
	<%
		JSONArray docs = resObj.getJSONArray("docs");
		for (int i = 0; i < count; i++) {
			
			JSONObject doc = docs.getJSONObject(i);
			String id = doc.getString("id");
			String account_number = doc.getString("account_number");
			String type = doc.getString("account_type");
			String entityName = doc.getString("entity_name");
			String accountType = rb.getString("account.management.accounttype.commercial");
			if(IAccount.AccountType.isPersonal(type)){
				accountType = rb.getString("account.management.accounttype.personal");
			}
			String address = doc.getString("address");
			 
			String rowId = "account_" + id; 
	%>
			<tr id="<%=rowId%>" > 
			    <td class="account-type <%=type%>"><i class="fa"></i></td>
				<td><%=JSPHelper.prepareForHTML(entityName)%></td>
				<td>#<%=JSPHelper.prepareForHTML(account_number)%> </td>
				<td><button type="button" class="btn btn-primary select-account pull-right" >Select</button></td>
			</tr>
	<%
		}
	%>
 
</table>