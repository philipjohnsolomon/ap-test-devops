
<%@page import="com.agencyport.workitem.model.IWorkListConstants"%>
<%@page import="com.agencyport.workitem.impl.WorkItemAction"%>
<%@page import="com.agencyport.webshared.IWebsharedConstants"%>
<%@page import="com.agencyport.webshared.URLBuilder"%>
<%@ page import="com.agencyport.jsp.JSPHelper"%>
<%@ page import="com.agencyport.pagebuilder.Page"%>
<%@ page import="com.agencyport.utils.text.HtmlTransliterator"%>
<%@ page import="com.agencyport.data.corrections.*"%>
<%@ page import="com.agencyport.trandef.Transaction"%>
<%@ page import="com.agencyport.defaults.DefaultsItem"%>
<%@ page import="com.agencyport.id.Id"%>
<%@ page import="com.agencyport.workitem.model.ILOBWorkItem"%>
<%@ page import="com.agencyport.workitem.model.IWorkItem"%>
<%@ page import="com.agencyport.workitem.model.WorkItemType"%>
<%@ page import="com.agencyport.product.ProductDefinitionsManager"%>
<%@ page import="com.agencyport.locale.IResourceBundle"%>
<%@ page import="com.agencyport.locale.ResourceBundleManager"%>
<%@ page import="com.agencyport.locale.ILocaleConstants"%>
<%@ page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%@ page import="com.agencyport.fieldvalidation.validators.BaseValidator"%>
<%@ page import="com.agencyport.shared.utils.ProgressBarUtilFactory"%>
<%@ page import="com.agencyport.shared.utils.ProgressBarUtil"%>
<%@ page import="com.agencyport.workitem.model.IWorkItemActionResolver" %>
<%@ page import="com.agencyport.workitem.factory.WorkItemFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>

<%
	JSPHelper jspHelper = JSPHelper.get(request);
	int workItemId = jspHelper.getWorkItemId();
	String workItemIdStringValue = Integer.toString(workItemId);
	Transaction transaction = jspHelper.getTransaction();
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
	IResourceBundle accountRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
	IResourceBundle rbTimeline = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.TIMELINE_BUNDLE);
	IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
	
	boolean isUploadSituation = jspHelper.isUploadSituation();
	boolean hasCorrections = false;
	boolean supportsUploadDataCorrection = transaction.supportsUploadDataCorrection();

	String transactionType = transaction.getType();
	boolean isAccount = jspHelper.isWorkItemAccountType();
	
	String workItemTitle = null;
	String entityName = jspHelper.getEntityName();

	String accountUrl = null;
	String accountEntityName = "";
	String accountNum = "";
	
	String  pageId = jspHelper.getPage().getId();
	if(isAccount){
		workItemTitle = ResourceBundleStringUtils.makeSubstitutions(rb.getString("menu.wi.title.AccountReferenceNum.Short"), jspHelper.getAccountNumber());	
		IWorkItem workItem = jspHelper.getWorkItem();
		accountEntityName = jspHelper.getAccountEntityName(workItem.getWorkItemId());
		if(workItem.getCommitFlag().booleanValue()){
			workItemTitle = accountEntityName + " " + workItemTitle;
		}
	}else{
		if (BaseValidator.checkIsEmpty(entityName)){
			workItemTitle = ResourceBundleStringUtils.makeSubstitutions(rb.getString("menu.wi.title.ReferenceNum.Short"), workItemIdStringValue);
		}else{
			workItemTitle = ResourceBundleStringUtils.makeSubstitutions(rb.getString("menu.wi.title.ReferenceNum.Long"), workItemIdStringValue, entityName);
		}
	}

	String styleClass = jspHelper.getPage().getStyleClass();
	
	TransactionCorrectionReport[] tcrs = jspHelper.getTransactionCorrectionReports();
	if (tcrs.length > 0) {
		hasCorrections = true;
	}

	boolean showAccountAssign = true;
	String lastAutoSaved = jspHelper.getLastAutoSaved();
	String versionNumber = ProductDefinitionsManager.getCurrentlyRunningVersion().toString();		
	Id accountId = jspHelper.getAccountId();
	String acctNum = jspHelper.getAccountNumber();
	if(!ILOBWorkItem.NULL_ACCOUNT_ID.equals(accountId)){
		accountEntityName = jspHelper.getAccountEntityName(accountId);
		if(accountEntityName == null){
			accountEntityName = accountRB.getString("label.account.management.incomplete");
		}
		accountNum = ResourceBundleStringUtils.makeSubstitutions(rb.getString("menu.wi.title.AccountReferenceNum.Short"), acctNum);
		accountUrl = URLBuilder.buildURL(IWebsharedConstants.DISPLAY_WORK_IN_PROGRESS_URI, URLBuilder.parm(IWebsharedConstants.WORKITEMID, accountId),
				URLBuilder.parm(WorkItemAction.ACTION, WorkItemAction.OPEN), URLBuilder.parm(IWorkListConstants.WORK_LIST_TYPE, IWorkListConstants.ACCOUNT_DETAILS_WORK_LIST_TYPE));  													
		showAccountAssign = false;
	}
	if(isAccount || !(jspHelper.getWorkItem().getCommitFlag().booleanValue())){
		showAccountAssign = false;
	}
	
	if(showAccountAssign){
		showAccountAssign = false;
		IWorkItemActionResolver actionResolver = WorkItemFactory.getWorkItemActionResolver();        	
		List<WorkItemAction> workItemActions = actionResolver.getActions(jspHelper.getSecurityProfile(), jspHelper.getWorkItem());
		Iterator<WorkItemAction> it = workItemActions.iterator();
		while(it.hasNext() ){
			String actionTitle = it.next().getActionTitle();
			if("Move".equalsIgnoreCase(actionTitle) || "Link".equalsIgnoreCase(actionTitle)){
				showAccountAssign = true;
				break;
			}
		}
	}
	
	String account_imcomplete = "account_imcomplete";
	if(jspHelper.isAccountComplete()){
		account_imcomplete="";
	}
	boolean supportsDefaults = transaction.supportsDefaults();
	boolean defaultsAvailable = false;
	DefaultsItem[] defaultsList = jspHelper.getDefaultsList();
	if (defaultsList.length > 0) {
		defaultsAvailable = true;
	}
%>

<div id="work_item_menu" class="padded-box work-item-menu">

	<div class="container">
		<div class="row">
			<div id="wi-reference"
				class="col-xs-12 col-sm-6 text-left wi-reference">

				<% if (jspHelper.showProgressBar()) {
							Page thisPage = JSPHelper.get(request).getPage();
							if (null  !=  thisPage) { 
								int percentageComplete = ProgressBarUtilFactory.get().getTransactionProgress(thisPage, false);
								String progressStatus = "";
								if (percentageComplete <=20) progressStatus = "zero";
						%>
				<div class="progress" style="width: 20%">
					<div class="progress-bar progress-bar-<%= progressStatus  %>"
						role="progressbar" style="width: <%=percentageComplete%>%">
						<span><%= percentageComplete %>%</span>
					</div>
				</div>

				<% }
					} %>

				<div id="lob-title" class="lob-title <%= transaction.getLob() %>">
					<%= transaction.getTitle() %> (ID: <%= JSPHelper.prepareForHTML(workItemTitle) %>)
				</div>
			</div>

			<div id="wi-options" class="hidden-xs col-sm-6 text-right wi-options">

				<div class="row">
				
					<% if(null != accountUrl){ %>
					<span id="accountReference"><a href="<%= accountUrl %>" class="<%=account_imcomplete%>">
							<%=JSPHelper.prepareForHTML(accountEntityName) %>&nbsp;<%=JSPHelper.prepareForHTML(accountNum) %></a></span>
					<%} %>			

					<% if (showAccountAssign) {%>
					<span> <a id="account_link" class="account-link"
						data-content='<%=accountRB.getString("account.actions.link.workitem.hover") %>'
						href="#lb_account_link" data-toggle="modal"
						onclick="javascript:ap.MoveManager.showMove();"><i class="fa"></i>
							<%= workItemRB.getString("message.Workitem_noaccount")%></a>
					</span> <span class="separator"> | </span>
					<% } %>

					<% if (jspHelper.showTimelineLink() ) { %>
					<span> <a id="timeline_link" class="timeline-link"
						href="#lb_timeline" data-toggle="modal"
						onclick="javascript:ap.timeline.displayTimeline('<%= transaction.getId()%>', '<%= pageId %>', '<%= workItemId%>', '<%=jspHelper.getCSRFToken()%>');"><i
							class="fa"></i> <%=rb.getString("menu.wi.name.timeline")%></a>
					</span> <span class="separator"> | </span>
					
					<span id="ap_autosave_list" class="auto-save" <% if(lastAutoSaved == null) { %> style="display: none" <% } %>>
						<%=rb.getString("title.autosave") + ":"%>
						<span id="ap_autosave" class="timestamp"><%=lastAutoSaved%></span>
					</span>
					
					<% } %>
				
				</div>
				
				<div class="row">
				
				
					<% if ( isUploadSituation ) { %>
					<span class="dropdown"> <a data-toggle="dropdown"
						class="dropdown-toggle" href="#"> <span class="is-upload"><i
								class="fa"></i></span> <%=rb.getString("menu.wi.Name.Upload")%> <span
							class="arrow-down"><i class="fa"></i></span>
					</a>

						<ul class="dropdown-menu">
							<li class="upload-info"><a href="#lb_upload_info"
								data-toggle="modal"><%=rb.getString("menu.wi.Name.Upload.SourceSystemInfo")%></a></li>
							<li class="upload-help"><a href="#lb_upload_help"
								data-toggle="modal"><%=rb.getString("menu.wi.Name.Upload.Help")%></a></li>
						</ul>
					</span> <span class="separator"> | </span>
					<% } %>

					<% if ( hasCorrections ){%>
					<span class="dropdown"> <a data-toggle="dropdown"
						class="dropdown-toggle" href="#"> <span class="has-corrections"><i
								class="fa"></i></span> <%=rb.getString("menu.wi.Name.Corrections")%> <span
							class="arrow-down"><i class="fa"></i></span>
					</a>
						<ul class="dropdown-menu dropdown-menu-right">
							<li><a href="#lb_tcr" data-toggle="modal"><%=rb.getString("menu.wi.Name.Corrections.ReviewAutomaticCorrections")%></a></li>
							<li><a href="#lb_tcr_help" data-toggle="modal"><%=rb.getString("menu.wi.Name.Corrections.Help")%></a></li>
						</ul>
					</span> <span class="separator"> | </span>
					<% } %>
				
					<% if ( supportsDefaults ){ %>
					<span class="dropdown">
						<a data-toggle="dropdown" class="dropdown-toggle " href="#">
							<span class="supports-defaults"><i class="fa"></i> <%=rb.getString("menu.wi.Name.MyDefaults")%></span> 
							<span class="arrow-down"><i class="fa fa-caret-down"></i></span>
						</a>
						<ul class="dropdown-menu dropdown-menu-right">
							<%if (defaultsAvailable) { %>
							<li><a href="#lb_apply_default" data-toggle="modal" ><%=rb.getString("menu.wi.Name.MyDefaults.ApplyToThisSubmission")%></a></li>
							<li><a href="#lb_manage_default" data-toggle="modal"><%=rb.getString("menu.wi.Name.MyDefaults.Manage")%></a></li>
							<% } %>
							<li><a href="#lb_which_default" data-toggle="modal"><%=rb.getString("menu.wi.Name.MyDefaults.AvailableFields")%></a></li>
							<li><a href="#lb_help_default" data-toggle="modal"><%=rb.getString("menu.wi.Name.MyDefaults.Help")%></a></li>
						</ul>
					</span>
					<% } %>
									
				</div>

				
				
				
			</div>
		</div>
	</div>
</div>


<!-- progress bar -->

<div id="pleaseWait">
	<div class="progress progress-striped please-wait active invisible"
		data-spy="affix" data-offset-top="60">
		<div class="progress-bar" role="progressbar" style="width: 100%">
			<span>Please Wait...</span>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade timeline-dialog" id="timeline_dialog"
	tabindex="-1" data-backdrop="static" data-keyboard="false"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" id="modal-timeline-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h2 class="modal-title in-progress" id="myModalLabel"><%=rbTimeline.getString("timeline.header")%></h2>
			</div>
			<div class="modal-body">
				<div class="row">
					<div id="event-list" class="col-md-3 timeline-event-list"></div>
					<div class="col-md-9">
						<ul class="nav nav-tabs" id="timeline-tabs">
							<li class="active" id="tab_timeline_event_summary"><a
								href="#timeline_event_summary" data-toggle="tab"
								id="href_timeline_event_summary"><%= rbTimeline.getString("timeline.event.summary.tab") %></a></li>
							<li id="tab_timeline_change_summary"><a
								href="#timeline_change_summary" data-toggle="tab"
								id="href_timeline_change_summary"><%= rbTimeline.getString("timeline.event.change.tab") %></a></li>
							<li id="tab_timeline_work_item_data" style="display: none;"><a
								href="#timeline_work_item_data" data-toggle="tab"
								id="href_timeline_work_item_data"><%= rbTimeline.getString("timeline.event.snapshot.tab") %></a></li>
						</ul>
						<div id="timeline_event_detail" class="timeline-event-detail"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../worklist/move-workitem.jsp" flush="true" />
