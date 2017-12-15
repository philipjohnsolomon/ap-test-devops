<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%@page import="com.agencyport.account.AccountDetails" %>

<% 
	String csrfToken = JSPHelper.get(request).getCSRFToken();
	IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
	IResourceBundle formatInfoRB = ResourceBundleManager.get().getBundle(ILocaleConstants.FORMAT_INFO_BUNDLE);
%>

<section ng-cloak id="worklist_search_section" class="worklist-section" data-ng-controller="ap.worklist.worklistViewCtrl as listCtrl">
	<div id="lb_workitem_locked" class="lightbox_panel" style="display: none">
		<div id="readOnlyMessage">
			<p><%=workItemRB.getString("account.management.pendingupload.locked",null)%></p>
		</div>
	</div>
	
	<!-- Search options -->
	<div id="search_filter" class="search-filter" ng-if="listCtrl.workListModel.metaData.index != undefined">
		<div class="row">
			<div id="messages" class="col-xs-12">
				<div id="error_msg" class="alert alert-error" style="display:none"></div>
				<div id="success_msg" class="alert alert-success" style="display:none"></div>
				<div id="info_msg" class="alert alert-info" style="display:none"></div>		
			</div>
		</div>

		<div class="row filter-row">
			<div id="filter" class="col-md-10 col-sm-10 col-xs-8 input-append animated fadeIn filter-controls">
			
				<div type="button" class="filter-counter hidden-xs" id="num-workitems">
					{{listCtrl.workListModel.pagination.total}}
					<span ng-if="listCtrl.workListModel.metaData.index == 'worklist'"><%=accountRB.getString("label.WorkItems","Work Item(s)")%></span>
					<span ng-if="listCtrl.workListModel.metaData.index == 'account'"><%=accountRB.getString("label.Accounts","Account(s)")%></span>
				</div>
				
				<div class="repeater" data-ng-repeat="filter in listCtrl.workListModel.metaData.filters">
				
					<div class="btn-group" dropdown is-open="filter.status.isopen">
						<button class="btn btn-default dropdown-toggle" dropdown-toggle ng-disabled="disabled">
							{{filter.title}} 
							<b class="caret"></b>
						</button>
						<ul class="dropdown-menu filter-selector filter-{{filter.name | lowercase}}" id="filter_{{filter.name | lowercase}}" role="menu">
							<li class="{{filter.name | lowercase}}-{{option.value}}" data-ng-repeat="option in filter.filterOptions">
								<a id="filter_{{filter.name | lowercase}}_{{option.value}}" ng-href="" ng-click="listCtrl.selectFilter(option)">
								<span class="swatch"></span><i class="fa {{filter.type | lowercase}}-icon"></i>{{option.title}}</a>
							</li>
						</ul>
					</div>
				</div>
				
				<div class="btn-group sort-by" dropdown is-open="sortByStatus.isopen">
					<button type="button" class="btn btn-default dropdown-toggle" dropdown-toggle ng-disabled="disabled">
						{{listCtrl.workListModel.metaData.sortInfo.title}} 
						<b class="caret"></b>
					</button>	
					<ul class="dropdown-menu" role="menu">
						<li class="{{sortOption.relatedFieldId}}" data-ng-repeat="sortOption in listCtrl.workListModel.metaData.sortInfo.sortOptions">
							<a ng-href="" data-ng-click="listCtrl.selectSortOption(sortOption)">
								{{sortOption.title}}
							</a>
						</li>
					</ul>
				</div>
				
				<!-- More Options/Advanced Search -->
				<div id="worklist_advanced_search_div" 
					class="btn-group dropdown advanced-search-div" dropdown is-open="listCtrl.advancedDropDown.isopen" ng-if="listCtrl.workListModel.metaData.queryInfo.pages.length > 0" >
					<button class="btn btn-default dropdown-toggle advanced-search" type="button" 
						id="dropdown-advanced" dropdown-toggle ng-disabled="disabled">
						{{listCtrl.workListModel.metaData.queryInfo.title}}
						<b class="caret"></b>
					</button>
					<div class="dropdown-menu" role="menu" aria-labelledby="dropdown-advanced" ng-click="$event.stopPropagation()">
						<div id="advancedDropDown" class="advanced dropdown-advanced">
						   <section ng-repeat="section in listCtrl.workListModel.metaData.queryInfo.pages[0].sections">
							   <div class="error-message">
									<p id="workitem_error_msg_advanced_search" ng-show="listCtrl.invalidAdvSearch"><%=workItemRB.getString("action.WorkList.selectOperator",null)%></p>
								</div>
								<div class="form-group" ng-repeat="field in section.fields | filter: '!operator'">
									<label class="control-label" for="{{field.name}}_label">
										<span>
											<span class="requiredField" ng-if="field.required">*</span>
										</span> 
										<span>{{field.label}}:</span>
									</label>
									<div class="form-group effective-date-form">
										<input ng-if="field.type =='text'" type="text" class="form-control" autocomplete="off" id="{{field.name}}" ng-model="field.value" ng-required="field.required" ng-minLength="field.minLength" ng-maxLength="field.maxLength" size="{{field.size}}">
							
										<select class="form-control" ng-if="field.type =='selectlist'" ng-model="field.selectedOption">
											<option value=""><%=workItemRB.getString("action.WorkList.select",null)%> {{field.label}}</option>
											<option value="{{opt.value}}" ng-selected="opt.value == field.defaultValue" ng-repeat="opt in field.options">{{opt.displayText}}</option> 
										</select>
										
										
										<div class="effective-date form-group" ng-if="field.type=='date'" ng-repeat="operatorField in section.fields | filter: 'operator'">
											<div class="form-group date-operator" ng-if="operatorField.type == 'selectlist'">
 												<select class="form-control"  ng-init="field.selectedOperator = operatorField.defaultValue" ng-model="field.selectedOperator" ng-options="opt.value as opt.displayText for opt in operatorField.options" >
													<option value=""><%=workItemRB.getString("action.WorkList.select",null)%> {{operatorField.label}}</option>
												</select>
 											</div>
											<div class="form-group start-date">
												<span class="has-addon">
													<div class="input-group date ap-calendar">
														<input type="text" class="form-control" datepicker-popup="<%=formatInfoRB.getString("default_display.date_format",null)%>" ng-model="field.startDate" is-open="listCtrl.startDtOpened" close-text="Close"
															placeholder="<%=formatInfoRB.getString("default_display.date_format",null)%>" ng-required="field.required" />
														<span class="input-group-addon" ng-click="listCtrl.open('startDtOpened', $event)">
															<i class="fa"></i>
														</span>
													</div>
												</span>
											</div>
											<div class="input-group between-dates" ng-if="field.selectedOperator == 'BETWEEN'">
												<span class="has-addon">
													<div class="input-group date ap-calendar">
														<input type="text" class="form-control" datepicker-popup="<%=formatInfoRB.getString("default_display.date_format",null)%>" ng-model="field.endDate" is-open="listCtrl.endDtOpened" close-text="Close" 
															placeholder="<%=formatInfoRB.getString("default_display.date_format",null)%>" ng-required="field.required" />
														<span class="input-group-addon" ng-click="listCtrl.open('endDtOpened',$event)">
															<i class="fa"></i>
														</span>
													</div>
												</span>
											</div>
										</div><!-- End effective-date form-inline -->
									</div><!-- End effective-date form -->
								</div>
							</section>
							
							<div class="form-group button-row">
								<button ng-click="listCtrl.advanceSearchClicked()" class="btn btn-primary button-right" id="searchBtn" name="searchBtn" type="button"><%= workItemRB.getString("worklist.label.search") %></button>								
							</div>
							<div name="searchForm">
								<div class="form-group save-filter-as" ng-if="listCtrl.workListModel.metaData.isSaveable">
									<label for="savedFilterName"><%=workItemRB.getString("worklist.label.filter.saveas", "Save Filter As")%></label>
									<div class="form-inline">
										<input type="text" class="form-control" name="savedSearchName" ng-required="true" ng-model="listCtrl.savedSearchName">
										<button ng-click="listCtrl.saveSearchClicked()" class="btn btn-primary" id="searchBtn" name="searchBtn" type="button"><%= workItemRB.getString("worklist.label.save") %></button>
										<div class="error-message" ng-show="listCtrl.saveError"><%= workItemRB.getString("worklist.label.filter.name.message") %></div>
									</div>
								</div>									
							</div>
						</div>
					</div>
				</div>	
				<!-- End More options -->
				
				<!-- Saved Searches -->
				<div class="btn-group saved-filter" dropdown  ng-if="listCtrl.workListModel.metaData.isSaveable">
					<button type="button" class="btn btn-default dropdown-toggle" dropdown-toggle id="saved_filter_dropdown">
						<%=accountRB.getString("label.Account.SavedFilter") %> 
						<b class="caret"></b>
					</button>
					<ul class="dropdown-menu saved-filter" id="saved-filter-entries" ng-if="listCtrl.workListModel.metaData.savedSearchInfo.savedSearches.length > 0">
					
						<li ng-repeat="search in listCtrl.workListModel.metaData.savedSearchInfo.savedSearches">
							<a ng-click="listCtrl.retriveSavedSearch(search)" class="filter-entry">{{search.name}}</a>
							<span class="pull-right delete">
								<a  ng-click="listCtrl.deleteSavedSearch(search)" title="<%= workItemRB.getString("action.Delete")%>">
									 <i class="fa"></i>
								</a>
							</span>
						</li>
					</ul>
				</div>
				<!-- End Saved Searches -->
			</div>
	
			<div id="switch" class="hidden-xs col-md-2 animated fadeIn">
				<div id="switch-options" class="switch-options btn-group pull-right">
					<a id="{{listview.type}}-view" ng-href="#/{{listview.type}}" ng-click="listCtrl.switchView(listview)" ng-class="{active: listview.selected}" class="{{listview.type | lowercase}}-view btn btn-default" ng-repeat="listview in listCtrl.workListModel.metaData.listViews">
						<i class="fa"></i>
					</a>
				</div>    			
			</div>
		</div>
		
		<div class="row active-filters-display" id="active_filters_display">
			<div class="filter-button reset">
				<a ng-href="" id="reset-filter-button" data-ng-click="listCtrl.clearFilters();" name="reset-filter-button"><%=workItemRB.getString("worklist.label.filter.clear") %></a>
			</div>
			
			<div id="filterbadge_{{filterOption.value}}" class="filter-button" data-ng-repeat="filterOption in listCtrl.getSelectedFilters()">
				<button class="close filter-close" data-ng-click="listCtrl.clearSelected(filterOption)"><i class="fa"></i></button>{{filterOption.title}}
			</div>

			<div id="filterbadge_{{advSearchField.relatedFieldId}}" class="filter-button" ng-if="advSearchField.operands[0] != '*'"
				data-ng-repeat="advSearchField in listCtrl.workListModel.metaData.queryInfo.queryFields | filter: {selected: true, interactive: true, isSaveable: true}">
				<button class="close filter-close" data-ng-click="listCtrl.clearSelected(advSearchField)"><i class="fa"></i></button>
					<span>{{advSearchField.title}}: </span>
					<span ng-if="advSearchField.operands.length == 1">{{advSearchField.operands[0]}}</span>
					<span ng-if="advSearchField.operands.length == 2">{{advSearchField.operands[0]}} - {{advSearchField.operands[1]}}</span>					
			</div>
			
			<div id="filterbadge_sort" class="filter-button">
				<span><%=workItemRB.getString("worklist.label.filter.sortby") %></span>		
				<span data-ng-repeat="sortOption in listCtrl.getSelectedSorts()">{{sortOption.title}}</span>
			</div>
			
			<span data-ng-show="listCtrl.getSelectedFilters().length == 0" ng-if="listCtrl.workListModel.metaData.index == 'worklist'" 
				class="filter-button showing-all">
				<%=workItemRB.getString("worklist.label.searchResults.ShowingAllWorkItems") %>
			</span>
			<span data-ng-show="listCtrl.getSelectedFilters().length == 0" ng-if="listCtrl.workListModel.metaData.index == 'account'" 
				class="filter-button showing-all">
				<%=accountRB.getString("label.Account.ShowingAllAccounts") %>
			</span>
		</div>
		
		<div class="row search-bar">
			<div class="search-field" id="search">
				<div class="input-group search" id="search">

 					<input id="search-box" type="text"  ng-if="listCtrl.workListModel.metaData.index == 'worklist'"
						data-ng-change="listCtrl.fetchWorkItems()" data-ng-model="listCtrl.searchValue" data-ng-repeat="queryField in listCtrl.workListModel.metaData.queryInfo.queryFields | filter: 'entity_name'"  
						class="form-control" autocomplete="off" placeholder="<%=workItemRB.getString("worklist.label.searchPlaceHolder", "Search for an account by name (3 character minimum)") %>" />
				
					<input id="search-box" type="text" ng-if="listCtrl.workListModel.metaData.index == 'account'" 
						data-ng-change="listCtrl.fetchWorkItems()" data-ng-model="listCtrl.searchValue" data-ng-repeat="queryField in listCtrl.workListModel.metaData.queryInfo.queryFields | filter: 'entity_name'"  
						class="form-control" autocomplete="off" placeholder="<%=accountRB.getString("account.management.label.findAccount", "Search for an account by name (3 character minimum)") %>" />
				</div>	
			</div>
		</div>
	</div>
	<!-- Search options -->
</section>

<!-- Directive to display error messages for worklist -->
<div messages></div>

<!-- content for cards/tiles. This div will have content from cardView.jsp/tabularView.jsp-->
<div data-ng-view></div>
