<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
	IResourceBundle workListRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
%>
<section id="worklist_contents_section" class="worklist-section" data-ng-controller="ap.worklist.worklistDataCtrl as dataCtrl">
	<div class="ajax-messages alert" ng-if="dataCtrl.messages.length > 0">
		<p ng-repeat="message in dataCtrl.messages" class="alert-warning"><strong><%=workListRB.getString("message.workitem_creation_error", "Error:")%></strong> {{message}}</p>
	</div>
	<div class="container">
		<div id="work_list_contents">
			<div class="row worklist-table">
				<!--  Add new card -->
				<!-- @param addlinks is an array of new workitem links objects
					 @param type is a string indicating the type of worklist (worklist/account) 
					 @name is the name of the worklist (WorkItemsView/AccountsView/AccountItemsView)
					 @when-upload is a function that is to be called when Upload button is clicked
					 @create-work-item is a function that is called when create workitem is clicked
				-->
				<div addnew-card
					addlinks="dataCtrl.workListModel.metaData.newWorkItemLinks"
					type="{{dataCtrl.workListModel.metaData.index}}"
					name="dataCtrl.workListModel.metaData.name"
					when-upload="dataCtrl.initiateUpload()"
					create-work-item="dataCtrl.createWorkItem(href)">
				</div>
				<!-- END Add new card -->
				
				<!-- START Workitem cards -->
				<div class="col-xs-12 col-sm-6 col-md-4" data-ng-repeat="workitem in dataCtrl.workListModel.workItems">
					<!-- 
						workitem-card is the reusable directive that engage appropriate template for cards
						workitem-data is the variable in the directive that holds workitem object
						type is the index type. template is for card ( <type>-card.tpl.jsp) is picked up based on this value
						e.g. account-card.tpl.jsp and worklist-card.tpl.jsp
					-->			  
					<div workitem-card 
						workitem-data="workitem" 
						type="{{dataCtrl.workListModel.metaData.index}}" 
						when-selected="dataCtrl.itemSelected(selectedWorkItem)"
						when-action-clicked="dataCtrl.performAction(selectedWorkItem, action)">
					</div>
				</div>
				<!-- END Workitem cards -->
			</div>
		</div>
		<!-- pagination -->
		<div ng-if="dataCtrl.workListModel.pagination.total > dataCtrl.workListModel.pagination.fetchSize">
			<pagination total-items="dataCtrl.workListModel.pagination.total" items-per-page="dataCtrl.workListModel.pagination.fetchSize"
				ng-model="dataCtrl.workListModel.pagination.currentPage" ng-change="dataCtrl.pageChanged()" max-size="5" class="pagination-sm" 
				boundary-links="true" rotate="false" num-pages="numPages" 
				first-text="<%=rb.getString("action.First", "First") %>"
				next-text="<%=rb.getString("action.Next", "Next") %>"
				previous-text="<%=rb.getString("action.Previous", "Previous") %>"
				last-text="<%=rb.getString("action.Last", "Last") %>">
			</pagination>
		</div>
	</div>
</section>