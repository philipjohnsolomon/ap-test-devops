<!-- home/home.jsp-->
<!--@@apwebapp_specification_version@@-->
<%@page import="java.util.Set"%>
<%@page import="java.util.ListIterator"%>
<%@page import="com.agencyport.security.profile.impl.SecurityProfileManager"%>
<%@page import="com.agencyport.security.profile.ISecurityProfile"%>
<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.webshared.URLBuilder"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="java.util.List"%>
<%@page import="com.agencyport.trandef.Transaction"%>
<%@page import="com.agencyport.domXML.widgets.LOBCode"%>
<%@page import="com.agencyport.trandef.TransactionDefinitionManager"%>

<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal"%>

<!-- Adding core_prompts resource bundles for JavaScript use -->
<ap:ap_rb_loader rbname="core_prompts"/>

<%
List<Transaction> transactions = TransactionDefinitionManager.getTransactions(true); 
IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
ListIterator<Transaction> iterator = transactions.listIterator();
JSPHelper jspHelper = JSPHelper.get(request);
ISecurityProfile securityProfile = SecurityProfileManager.get().acquire(session);
String userId = securityProfile.getSubject().getId().toString();
Set<String> userPermissions = securityProfile.getRoles().getPermissionNames(securityProfile.getSubject().getPrincipal());
%>
<div class="home-page">
	<section class="get-started">
		<div class="container">
			<h3 class="header"><%=coreRB.getString("label.GetStarted")%></h3>
			<div class="row lines-of-business animated fadeIn">
			<%
			// We expect two transactions (quick quote and new business for each LOB)
			while (iterator.hasNext()){
				Transaction first = iterator.next();
				// Determine if user has the writes to work with this LOB
				String permissionForTransaction = "access" + first.getLob();
				if (!userPermissions.contains(permissionForTransaction)){
					continue;
				}
				String firstURL = URLBuilder.buildFrontServletURL(-1, null, Boolean.TRUE.toString(), first.getId(), URLBuilder.DISPLAY_METHOD, false);
				String secondURL = null;
				Transaction second = null;
				if (iterator.hasNext()){
					second = iterator.next();
					// If the second one's LOB code does not match the first one's then we move the iterator back
					// to catch it the next time around for the next LOB.
					if (!second.getLobCode().equals(first.getLobCode())){
						iterator.previous();
						second = null;
					} else {
						secondURL = URLBuilder.buildFrontServletURL(-1, null, Boolean.TRUE.toString(), second.getId(), URLBuilder.DISPLAY_METHOD, false); 
					}
				}
				String lobCodeDesc = first.getLobCode().getDescription();
				String lobCSSImageClass = jspHelper.getLOBImageClass(first);
			%>
				<div class="col-xs-12 col-sm-6 col-lg-2">
					<div class="<%=lobCSSImageClass%>">
						<div class="hover-color"></div>		
						<div class="btn-group">
							<div class="lob-button"><a class="btn" href="<%=firstURL%>"><%=first.getLocalizedType()%></a></div>
							<%if (second != null) { 
							%>
							<div class="lob-button"><a class="btn" href="<%=secondURL%>"><%=second.getLocalizedType()%></a></div>
							<%}%>
						</div>
						<div class="caption">
							<h4><%=lobCodeDesc%></h4>
						</div>
					</div>
				</div>
			<%}%>	
			</div> <!-- /.row -->
		</div> <!-- /.container -->
	</section>
	<div ng-app="ap.worklist" ng-cloak data-ng-controller="ap.worklist.recentWorkItemsQueueCtrl as recentQCtrl">
	<messages></messages> <!-- Directive that displays messages -->
	<section class="queue">
		<div class="container">
			<h3 class="header"><%=coreRB.getString("label.Queue")%></h3>
			<div class="row">

				<div id="agent_queue" class="queue-agent col-xs-12 col-sm-6 animated fadeIn">
					<h4>
						<i class="fa"></i><%=coreRB.getString("label.MostRecent")%>
					</h4>
					<table class="table table-striped sortable">
						<thead>
							<tr>
								<th ng-class="field.styleClass" ng-repeat="field in recentQCtrl.agentqueue.metaData.listViews[0].fields | filter: {isDisplayed: true}">{{field.title}}</th>
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="workitem in recentQCtrl.agentqueue.workItems">
								<td ng-class="field.styleClass" ng-repeat="field in recentQCtrl.agentqueue.metaData.listViews[0].fields | filter: {isDisplayed: true}">
									<a ng-href="LaunchWorkItem?WORKITEMID={{workitem.work_item_id}}&action=Open&openmode=E&WorkListType=WorkItemsView" >{{recentQCtrl.getWorkItemValue(field,workitem)}}</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>


				<div id="underwriter_queue" class="queue-underwriter col-xs-12 col-sm-6 animated fadeIn">
					<h4>
						<i class="fa"></i><%=coreRB.getString("label.WaitingforUnderwriter")%>
					</h4>
					<table class="table table-striped sortable">
						<thead>
							<tr>
								<th ng-class="field.styleClass" ng-repeat="field in recentQCtrl.uwqueue.metaData.listViews[0].fields | filter: {isDisplayed: true}">{{field.title}}</th>
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="workitem in recentQCtrl.uwqueue.workItems">
								<td ng-class="field.styleClass" ng-repeat="field in recentQCtrl.uwqueue.metaData.listViews[0].fields | filter: {isDisplayed: true}">
									<a ng-href="LaunchWorkItem?WORKITEMID={{workitem.work_item_id}}&action=Open&openmode=E&WorkListType=WorkItemsView" ng-bind="recentQCtrl.getWorkItemValue(field,workitem)"></a>
								</td>
 							</tr>
						</tbody>
					</table>
				</div>
			</div> <!-- /.row -->	
		</div> <!-- /.container -->
	</section>

	<section class="quotes">
		<div id="quote_container" class="container">
			<h3 class="header">Quotes</h3>
			<div class="row">
				<div class="col-xs-6 col-md-3" ng-repeat="status in recentQCtrl.quoteBoxes.statuses">
					<a ng-href="DisplayWorkInProgress?WorkListType=WorkItemsView&status={{status}}">
						<div class="stat label-{{status | lowercase}}"><h1>{{ recentQCtrl.getItemCount(status)}}</h1>
							<p class="bottom-right">{{recentQCtrl.lookupValue('STATUS',status)}}</p>
						</div>
					</a>
				</div>
			</div>
		</div> <!-- /.container -->

	</section>
	</div>
</div>

<jsp:include page="footer.jsp" flush="true" />
