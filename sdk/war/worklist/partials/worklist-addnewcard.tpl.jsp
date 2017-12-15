<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
%>
<div class="col-xs-12 col-sm-6 col-md-4 add-new-work-item" id="add_new_workitem">
	<!-- Add new button -->
	<div class="card add show-list" id="add-button" ng-show="addNewState == 'none'">
		<div ng-click="setState('combo')" class="add-button">
			<i class="fa fa-plus lob-icon"></i>
			<a><%= workItemRB.getString("action.AddNewWorkItem") %></a>						
		</div>
	</div>	
	<div class="card add" id="add-list" ng-show="addNewState == 'show-transactionList'">
		<div class="add-list">
			<h3><%= workItemRB.getString("header.Title.SelectLOB") %>
				<button type="button" class="close" aria-hidden="true" ng-click="setState('none')" >
					<i class="fa"></i>
				</button>
			</h3>
			<!-- list of workitem url -->					
			<ul role="menu">
				<li ng-repeat="link in addlinks">
					<a ng-click="createWorkItem({href:link.value})" >{{link.title}}</a>
				</li>
			</ul>	
		</div>
	</div>
	<div class="card add" id="add-turnstile" ng-show="addNewState == 'combo'" >
		<div class="add-turnstile">
			<a ng-href="" class="upload" ng-click="whenUpload()" ><i class="fa"></i><span class="link"><%= workItemRB.getString("action.UploadForm") %></span></a>
			<a ng-href="" class="start" ng-click="setState('show-transactionList')"><i class="fa"></i><span class="link"><%= workItemRB.getString("action.StartNewWorkItem") %></span></a>
		</div>
	</div>
</div>	
