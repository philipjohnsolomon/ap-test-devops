<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%@page import="com.agencyport.account.AccountDetails" %>
<%@page import="com.agencyport.account.model.IAccount.AccountType"%>

<%
	IResourceBundle workListRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
%>

<section ng-cloak id="worklist_contents_section" class="worklist-section" ng-controller="ap.worklist.worklistDataCtrl as tblCtrl">
	<div class="ajax-messages alert" ng-if="tblCtrl.messages.length > 0">
		<p ng-repeat="message in tblCtrl.messages" class="alert-warning"><strong><%=workListRB.getString("message.workitem_creation_error", "Error:")%></strong> {{message}}</p>
	</div>
	<div class="container">
		<div id="work_list_contents">

			<div class="button-row add-new-work-item">
				<div class="add-list">
					<div class="btn-group">
						<button data-toggle="dropdown" class="btn btn-default dropdown-toggle">
							<%= workListRB.getString("header.Title.AddWorkItemForLOB") %> <span class="caret"></span>
						</button>
						<ul role="menu" class="dropdown-menu filter-selector filter-lob">
							
							<li ng-if="tblCtrl.isWorkItemsView() || tblCtrl.isAccountItemsView()">
								<a ng-click="tblCtrl.createWorkItem('upload')"><%= workListRB.getString("action.PrefillAcordForm") %></a>
							</li>
							<li ng-if="tblCtrl.isWorkItemsView() || tblCtrl.isAccountItemsView()" role="presentation" class="divider"></li>
							
							<li ng-repeat="link in tblCtrl.workListModel.metaData.newWorkItemLinks | filter:query | orderBy: 'title'" ng-if="tblCtrl.isWorkItemsView() || tblCtrl.isAccountItemsView()">
								<a ng-click="tblCtrl.createWorkItem(link.value)">{{link.title}}</a>
							</li>
							
							<li ng-if="tblCtrl.isAccountsView()">
								<a ng-href="" ng-click="tblCtrl.createWorkItem(tblCtrl.workListModel.metaData.newWorkItemLinks[0].value+'&account_type=<%=AccountType.C.name()%>')" ><%= accountRB.getString("label.Account.Commercial") %></a>
							</li>
							<li ng-if="tblCtrl.isAccountsView()">
								<a ng-href="" ng-click="tblCtrl.createWorkItem(tblCtrl.workListModel.metaData.newWorkItemLinks[0].value+'&account_type=<%=AccountType.P.name()%>')"  ><%= accountRB.getString("label.Account.Personal") %></a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			
			<div class="work-list-table-container">
				<div class="row">
					<div class="table-responsive col-xs-12">
						<table id="work_list_table" summary="A work list" class="table table-border table-hover work-list">
							<thead>
								<tr>
									<th class="columnHeader worklistdata-{{field.id}}" id="columnHeader_{{index}}" ng-repeat="field in tblCtrl.getTableColumns() | filter: {id: '!account_id', isDisplayed: true}">
										<a href="" ng-click="tblCtrl.toggleSort(field)" ng-if="field.isSortable">
											<div class="columnName gainlayout {{tblCtrl.getSortDirection(field)}}" id="headerDiv_{{index}}">
												{{field.title}}
											</div>
										</a>
										<div class="columnName gainlayout" id="headerDiv_{{index}}" ng-if="!field.isSortable">
											{{field.title}}
										</div>
									</th>
								</tr>
							</thead>
							<tbody id="work_list_table_body">
								<tr id="{{workitem.work_item_id}}"  data-ng-dblclick="tblCtrl.performDoubleClick(workitem)" ng-class-odd="'odd'" ng-class-even="'even'" ng-click="tblCtrl.itemSelected(workitem)" 
									class="{{workitem.lob}} worklist-item worklistrow " ng-class="{selected: workitem.selected}" ng-repeat-start="workitem in tblCtrl.workListModel.workItems">
	                                <td class="worklistdata-{{field.id}}" ng-class="field.styleClass" ng-repeat="field in tblCtrl.getTableColumns() | filter: {id: '!account_id', isDisplayed: true}">
	                                    <div title="{{field.title}}" >
	                                    	<span>{{tblCtrl.lookupValue(field,workitem)}}</span>
	                                        <span ng-if="field.id == 'entity_name' && !tblCtrl.isAccountsView()"><span data-ng-hide="tblCtrl.isLinkedToAccount(workitem)" class="no-account" title="<%=accountRB.getString("account.actions.link.workitem.hover") %>"><i class="fa"></i></span></span>
	                                    </div>
	                                    {{workitemData.actions}} 
	                                </td>
								</tr>
								
								 <tr class="worklistactions" data-ng-show="workitem.selected" ng-if="workitem.actions.length > 0">
                                    <td>
                                    	<div id="tile-actions" class="card-actions" ng-if="tblCtrl.isAccountsView()">
                                 			<div class="worklist-card-button">
												<span onmouseover="return true;" data-ng-click="tblCtrl.performAction(workitem, action)" 
													data-ng-repeat="action in workitem.actions | filter: {isPrimary: true}"
													title="{{action.localizedTitle}}" class="worklist-actions action btn btn-default" id="eventWorkItemAction_{{action.code}}"> 
													<span>{{action.localizedTitle}}</span>
												</span>
											</div>
                                    	</div>
                                       	<div id="tile-actions" class="card-actions" ng-if="!tblCtrl.isAccountsView()">
											<div onmouseover="return true;" data-ng-repeat="action in workitem.actions | filter: {isPrimary: true}" 
												data-ng-click="tblCtrl.performAction(workitem, action)" 
												title="{{action.localizedTitle}}" class="actions-open work_list_action btn btn-default" 
												id="eventWorkItemAction_{{action.code}}"> 
												<span></span>
												<span>{{action.localizedTitle}}</span>
											</div>
											<div ng-if="(workitem.actions | filter: {isPrimary: false}).length > 0" class="btn-group actions-other" dropdown is-open="actionsOpen">
												<button id="work_item_actions_secondary" class="btn btn-default dropdown-toggle actions-other" dropdown-toggle ng-disabled="disabled">
													<%=rb.getString("action.OtherActions") %><span class="caret"></span>
												</button>
												<ul class="dropdown-menu other-actions" role="menu">
													<li data-ng-repeat="action in workitem.actions | filter: {isPrimary: false}" class="work_item_actions-{{action.code}}">
														<span onmouseover="return true;" data-ng-click="tblCtrl.performAction(workitem, action)" title="{{action.localizedTitle}}" class="work_list_action" id="eventWorkItemAction_{{action.code}}"> 
															<span>{{action.localizedTitle}}</span>
														</span>
													</li>	
												</ul>
											</div>
										</div>			
                                    </td>
                                </tr>

                                <tr data-ng-show="workitem.selected" class="invisible" ng-repeat-end>
                                	<!-- invisible row to avoid throwing off table striping styles -->
                                </tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
		</div>
		
		<!-- pagination -->
		<div ng-if="tblCtrl.workListModel.pagination.total > tblCtrl.workListModel.pagination.fetchSize">
			<pagination total-items="tblCtrl.workListModel.pagination.total"  items-per-page="tblCtrl.workListModel.pagination.fetchSize"
				ng-model="tblCtrl.workListModel.pagination.currentPage" ng-change="tblCtrl.pageChanged()" max-size="5" class="pagination-sm" 
				boundary-links="true" rotate="false" num-pages="numPages" 
				first-text="<%=rb.getString("action.First", "First") %>"
				next-text="<%=rb.getString("action.Next", "Next") %>"
				previous-text="<%=rb.getString("action.Previous", "Previous") %>"
				last-text="<%=rb.getString("action.Last", "Last") %>">
			</pagination>
		</div>
	</div>
</section>                          