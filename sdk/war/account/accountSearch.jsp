<%@page import="java.util.Map"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.jsp.JSPHelper,
				com.agencyport.product.ProductDefinitionsManager"%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.agencyport.html.optionutils.OptionListPrinter"%>
<%@page import="com.agencyport.html.optionutils.OptionList"%>
<%@page import="java.util.List"%>
<%@page import="com.agencyport.html.optionutils.OptionsMap"%>
<%@page import="com.agencyport.paging.worklist.IColumnMetaData"%>
<%@ page import="com.agencyport.worklist.WorkListHelper"%>
<%@ page import="com.agencyport.paging.worklist.IWorkListResults"%>
<!-- account/accountSearch.jsp-->
<%
	JSPHelper jspHelper = JSPHelper.get(request);
	String versionNumber = ProductDefinitionsManager.getCurrentlyRunningVersion().toString();
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
	String searchVal="";
	String accountNumberVal = (String) request.getParameter("accountNumber");
	String cityVal = (String) request.getParameter("city");
	String stateVal = (String) request.getParameter("state");
	String zipVal = (String) request.getParameter("zip");
	List<IColumnMetaData> columnMetaData  = (List<IColumnMetaData>) request.getAttribute(WorkListHelper.ColumnMetadata);
%>

<div id="account_launch" class="search-filter">
	<h2><%=accountRB.getString("account.management.menu.header", "")%></h2>
	<div class="row filter-row">
		<div class="col-md-10 col-sm-10 col-xs-8">
			<div class="">
				<div class="filter-counter hidden-xs" id="num-accounts"></div>
				<div class="btn-group account-type">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"><%=accountRB.getString("label.SearchResults.Type") %> <b class="caret"></b></button>
					<ul class="dropdown-menu filter-type" id="filter_type" role="menu"></ul>
				</div>
				<div class="btn-group sort-by">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"><%=accountRB.getString("label.Account.SortBy") %> <b class="caret"></b></button>	
					<ul class="dropdown-menu" role="menu">
						<input type="hidden" id="sortresults" value="last_update_time desc" />
                            
                         <% for(IColumnMetaData column : columnMetaData) {
                                if(column.isSortingEnabled()) {%>
                                    <li class="<%=column.getColumnName()%>">
                                        <a href="#" onclick="ap.WorkItemList_Table.sort(this, '<%=(column.isIdentityColumn()) ? "id" : column.getColumnName() %>')">
                                            <%=column.getColumnTitle()%>
                                        </a>
                                    </li>
                                <%}
                        }%>
					</ul>
				</div>
				<div id="advanced_search_div" class="btn-group dropdown advanced-search-div">
					<button class="btn btn-default dropdown-toggle advanced-search" type="button" id="dropdown-advanced" data-toggle="dropdown">
						<%=accountRB.getString("label.SearchResults.AdvancedSearch") %>
						<span class="caret"></span>
					</button>
					<div class="dropdown-menu dropdown-advanced" role="menu" aria-labelledby="dropdown-advanced">
						<form role="form" id="advancedDropDown" class="advanced">
							<div class="error-message">
								<p id="error_msg_advanced_search" style="display:none"></p>
							</div>
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
								<select class="form-control" id="state">
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
							<div class="form-group">
								<button onclick="javascript: ap.WorkItemList.validateAndFetchWorkItems();" class="btn btn-primary" id="searchBtn" name="searchBtn" type="button">Search</button>
							</div>
						</form>
					</div>
				</div>				
			</div>
	  	</div>
		<div class="col-md-2 col-sm-2 col-xs-4" id="switch-options">
			<div class="btn-group pull-right switch-options">
				<a id="tile-view" class="card-view btn btn-default active"><i class="fa"></i></a>				
				<a id="list-view" class="list-view btn btn-default"><i class="fa"></i></a>
			</div>
		</div>   			
	</div>
	<div class="row active-filters-display" id="active_filters_display"></div>
	<div class="row search-bar">
		<div class="search-field" id="search">
			<label class="sr-only" for="exampleInputEmail2"><%=accountRB.getString("label.AutoSearch.FindAnAccount") %></label>
			<input type="text" class="form-control account-search-input" placeholder="<%=accountRB.getString("account.management.label.findAccount", "Search for an account by name (3 character minimum)") %>" id="account_searchInput" name="autocomplete_parameter" />
		</div>
	</div>
				
<script type="text/javascript">
	ap.accountSearchMgr = new ap.AccountSearchManager();
	ap.accountSearchMgr.initialize();
</script>

