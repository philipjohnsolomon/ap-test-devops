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

	<%
		JSONArray docs = resObj.getJSONArray("docs");
		for (int i = 0; i < count; i++) {
			JSONObject doc = docs.getJSONObject(i);
			String id = doc.getString("id");
			String accountNumber = doc.getString("account_number");
			String type = doc.getString("account_type");
			String entityName = doc.getString("other_name");
			String accountType = rb.getString("account.management.accounttype.commercial");
			if (IAccount.AccountType.isPersonal(type)) {
				entityName = doc.getString("firstName") + " " + doc.getString("lastName");
				accountType = rb.getString("account.management.accounttype.personal");
			}
			String address = doc.getString("address");
			
			String rowclass = (i % 2== 0) ?"roweven":"rowodd";
			String rowId = "account_" + id;
			String rowCss = "account_css_" + id;
	%>
			<tr class="<%= rowclass %>  account_row" id="<%=rowId%>">
			    <input type="hidden" id="<%=rowCss %>" value="<%= rowclass %>" />
			    <td><div style="text-align:left;"><%=type%></div></td>
				<td><div style="text-align:left;"><%=JSPHelper.prepareForHTML(entityName)%></div></td>
				<td><div style="text-align:left;"><%=JSPHelper.prepareForHTML(accountNumber)%></div> </td>
				<td><div style="text-align:left;"><%=JSPHelper.prepareForHTML(address)%></div></td>
				<td><div style="text-align:left;"><input type="button" id="<%=id%>" onclick="javascript: ap.accountSearchMgr.upload(<%=id%>)" value="<%=rb.getString("account.management.label.select")%>"/></div></td>
			</tr>
	<%
		}
	%>
