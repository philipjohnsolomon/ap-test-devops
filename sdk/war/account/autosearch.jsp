<%@page import="java.util.ArrayList"%>
<%@page import="com.agencyport.html.optionutils.OptionListPrinter"%>
<%@page import="com.agencyport.html.optionutils.OptionList"%>
<%@page import="java.util.List"%>
<%@page import="com.agencyport.html.optionutils.OptionsMap"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<% 
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
%>
	<form class="form-inline" role="form">
		<div class="form-group">
			<label class="sr-only" for="exampleInputEmail2"><%= accountRB.getString("label.AutoSearch.FindAnAccount") %></label>
			<input type="text" class="form-control" placeholder="<%=accountRB.getString("account.management.label.findAccount", "Search for an account by name (3 character minimum)") %>" id="account_searchInput" name="autocomplete_parameter" />
			<span id="search_indicator" style="display: none">
				<img src="<%= jspHelper.getWebContentPrefix() %>assets/img/indicator.gif" alt="<%=accountRB.getString("account.management.working", "Working...") %>" />
			</span>
			<span id="autocomplete_choices" class="autocomplete"></span>
			<button id="searchBtn" type="submit" class="btn btn-primary" onclick="javascript: ap.accountSearchMgr.launchSearch(); return false;"><%=accountRB.getString("account.management.menu.search", "Search") %></button> 
			<a class="" href="#" role="button" onclick="javascript: ap.accountSearchMgr.toggleAdvanced()">
				<input class="advancedCheck" type="checkbox" id="advancedSelect" /> <%=accountRB.getString("account.management.menu.advanced", "Advanced") %>
			</a>
		</div>
	</form>
    		
	<form role="form" id="advancedDropDown" class="advanced" style="display: none">
	<div class="form-group">
		<label for="accountNumber"><%=accountRB.getString("account.management.label.accountNumber", "Account Number")%></label>
		<input type="text" class="form-control" placeholder="<%=(accountNumberVal!=null)?accountNumberVal:""%>" id="accountNumber" name="accountNumber">
	</div>
	<div class="form-group">
		<label for="city"><%=accountRB.getString("account.management.label.city", "City")%></label>
		<input type="text" class="form-control" size="20" maxLength="50" placeholder="<%=(cityVal!=null)?cityVal:""%>" id="city" name="city" />
	</div>
	<div class="form-group">
		<label for="state"><%=accountRB.getString("account.management.label.state", "State")%></label>
		<select id="state" class="form-control">
			<%
				List<OptionList.Key> keys = new ArrayList<OptionList.Key>();
				keys.addAll(OptionList.Key.parse("xmlreader:codeListRef.xml:selectOne|xmlreader:codeListRef.xml:state"));
				OptionList options = OptionsMap.getOptionsList(keys, null);
			%>
			<%=OptionListPrinter.print((stateVal!=null)?stateVal:"", "", options)%>
		</select>
	</div>
	<div class="form-group">
		<label for="zip"><%=accountRB.getString("account.management.label.zip", "Zip Code")%></label>
		<input type="text" class="form-control" size="10" maxLength="10" placeholder="<%=(zipVal!=null)?zipVal:""%>" id="zip" name="zip"/>
	</div>
</form>
	