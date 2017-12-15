<!--  changeRequests.jsp a policy change summary artifact -->
<%@ page import="com.agencyport.data.corrections.*,
  	com.agencyport.jsp.JSPHelper,
    com.agencyport.policysummary.changemanagement.*,
    com.agencyport.trandef.Transaction,
    java.text.SimpleDateFormat,
    com.agencyport.utils.APDate"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleProperty"%>
<%@page import="com.agencyport.security.profile.impl.SecurityProfileManager"%>
<%@page import="com.agencyport.security.profile.ISecurityProfile"%>
<%@page import="com.agencyport.html.elements.FieldSecurityElement.SecureDataEntryMode"%>

<%
	String title = (String) request.getParameter(PolicyChangeConstants.CHANGE_REQUEST_TITLE);
	JSPHelper jspHelper = JSPHelper.get(request);
    Transaction tran = jspHelper.getTransaction();
 	SimpleDateFormat dateFormatter = new SimpleDateFormat(ResourceBundleManager.get().getString(ILocaleConstants.DATE_FORMAT_PROPERTY, null));
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.POLICY_SUMMARY_BUNDLE);
	
	ISecurityProfile secProfile = SecurityProfileManager.get().acquire();
	boolean canReadSecureData = secProfile.getRoles().checkPermission(secProfile.getSubject().getPrincipal(), "canReadSecureData");
	
	// When we have multiple PCS the following will get the first one if there else a null will be returned.     
	PolicyChangeSummarizer summary = jspHelper.getPolicyChangeSummarizer();
	boolean hasChanges = summary.hasChanges(tran);
	boolean showCurrentValuesOnly = summary.shouldOnlyShowCurrentValues();
	String noChangesText = rb.getString("prompt.ChangeRequests.Changes.NoChanges");
	int numberOfColumns = 3;
	if ( title == null ){
		if ( showCurrentValuesOnly ) {
			title = rb.getString("prompt.ChangeRequests.Details.PolicyDetailsByScreen");
			noChangesText = rb.getString("prompt.ChangeRequests.Details.NoDetails");
			numberOfColumns = 2;
		}
		else
			title = rb.getString("prompt.ChangeRequests.Changes.ChangesByScreen");;
	}
    String showPrompt = rb.getString("prompt.ChangeRequests.Changes.Show");
    if ( showCurrentValuesOnly ){
	    showPrompt = rb.getString("prompt.ChangeRequests.Details.Show");
    }
    String originalValueColumn = rb.getString("header.ChangeRequests.OriginalValue");
    String currentValueColumn = rb.getString("header.ChangeRequests.CurrentValue");
    String actionTakenColumn = rb.getString("header.ChangeRequests.ActionTaken");
    String fieldHeader = rb.getString("header.ChangeRequests.Field");
    String correctiveActionMessage = rb.getString("header.ChangeRequests.CorrectiveActionMessage");
    String relatedErrorMessage = rb.getString("header.ChangeRequests.RelatedErrorMessage");
	String screen = rb.getString("prompt.ChangeRequests.Screen");
	String none =  rb.getString("prompt.ChangeRequests.None");
	String appliedOnLabel = rb.getString("label.ChangeRequests.AppliedOn");   
	String defaultsUsedLabel = rb.getString("label.ChangeRequests.DefaultsUsed");   
	String correctionsSetTrackingIdLabel = rb.getString("label.ChangeRequests.CorrectionsSetTrackingId");   
	if(hasChanges) {%>
		<h3><%=title%></h3>
		<div class="screen-summary">
	<%}		
    PolicyChangeSummarizer[] summaries = jspHelper.getPolicyChangeSummarizerList();
	for ( int summaryIx = 0; summaryIx < summaries.length; summaryIx++ ) {
		summary = summaries[summaryIx];	
		hasChanges = summary.hasChanges(tran);
		PageLevelChangeDetail[] pageLevelChangeDetails = summary.getPageLevelChangeDetails(tran);
		TransactionCorrectionReport transactionCorrectionRpt = summary.getTransactionCorrectionReport();
		boolean hasCorrectionReport = transactionCorrectionRpt != null;
		int aggregateLevelEyeCatcherNumColumns = numberOfColumns; 
		int aggregateLevelActionTakenNumColumns = 1; 
		if ( hasCorrectionReport ) {
	    	originalValueColumn = rb.getString("header.ChangeRequests.OriginalValue.BeforeCorrection");
	    	currentValueColumn = rb.getString("header.ChangeRequests.CurrentValue.BeforeCorrection");
	    	actionTakenColumn = rb.getString("header.ChangeRequests.ActionTaken.BeforeCorrection");
	    	numberOfColumns = 6;
			aggregateLevelEyeCatcherNumColumns = 3;
			aggregateLevelActionTakenNumColumns = 3;
		}
				
		//  This depends on a Java script function 'manageChangePageDetail()' which is declared in pageSetup.jsp		
		if(hasChanges) {
			 if ( hasCorrectionReport ){
			 	APDate apDate = transactionCorrectionRpt.getCreationTime();
			 	String changesAppliedOn = apDate.getStringDate(dateFormatter);
			 	String prototypeDocumentNameUsed = transactionCorrectionRpt.getDefaultsTemplateNameUsed();
			 	if ( prototypeDocumentNameUsed == null )
			 		prototypeDocumentNameUsed = none;
			 	int correctionSetId = transactionCorrectionRpt.getCorrectionSetId();	
			 	%>
			 	<h4><%=appliedOnLabel%> <%=changesAppliedOn%></h4>
			 	<h4><%=defaultsUsedLabel%> '<%=prototypeDocumentNameUsed%>' </h4>
			 	<h4><%=correctionsSetTrackingIdLabel%> <%=correctionSetId%> </h4>
			 	<% 
			 }
		%>
		<%
		for ( int pageLevelIx = 0; pageLevelIx < pageLevelChangeDetails.length; pageLevelIx++){
			PageLevelChangeDetail pageLevelChangeDetail = pageLevelChangeDetails[pageLevelIx];
			AggregateLevelChangeDetail[] aggregateLevelChangeDetails = pageLevelChangeDetail.getAggregateLevelChangeDetails();
			String endScreenId = "END_SCREEN_" + (summaryIx + 1) + "_" + (pageLevelIx + 1);   
			%>
			<%if(!pageLevelChangeDetail.hasChanges()) { %>
				<p><%=screen%> <%=pageLevelIx+1%> - <%=JSPHelper.prepareForHTML(pageLevelChangeDetail.getLegend())%> (<%=noChangesText%>)</p>
			<%}
			else { %>
			<p><%=screen%> <%=pageLevelIx+1%> - <%=JSPHelper.prepareForHTML(pageLevelChangeDetail.getLegend())%> <a id="<%=endScreenId%>" href="javascript:void(0);" onclick="manageChangePageDetail(this)" title="Show the changes that have been made to this screen."><%=showPrompt%></a>
			<div id="<%=endScreenId%>_DIV" style="margin: 5px 0px 5px 0px; display: none">
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th><%=fieldHeader%></th>
						<%if(!showCurrentValuesOnly) { %>
						<th><%=originalValueColumn%></th>
						<%}%>
						<th><%=currentValueColumn%></th>
						<%if(!showCurrentValuesOnly) { %>
						<th><%=actionTakenColumn%></th>
						<%}%>
						<%if(hasCorrectionReport) { %>
						<th><%=correctiveActionMessage%></th>
						<th><%=relatedErrorMessage%></th>
						<%}%>
					</tr>
				</thead>
				<tbody>
			<%
			for ( int aggLevelIx = 0; aggLevelIx < aggregateLevelChangeDetails.length; aggLevelIx++){
				AggregateLevelChangeDetail aggregateLevelChangeDetail = aggregateLevelChangeDetails[aggLevelIx];
				String eyeCatcher = aggregateLevelChangeDetail.getEyeCatcher(true, null);
				if ( eyeCatcher.length() > 0 ){
				%>
				<tr>
					<td colspan="<%=aggregateLevelEyeCatcherNumColumns%>"><%=JSPHelper.prepareForHTML(eyeCatcher)%></td>
					<%if(!showCurrentValuesOnly) { %>
					<td colspan="<%=aggregateLevelActionTakenNumColumns%>"><%=aggregateLevelChangeDetail.getModInfoActionCodeString()%></td></tr>
					<%
					}
				}	
				if ( aggregateLevelChangeDetail.getFieldLevelChangeDetails().length	> 0) { 
					for ( int fieldLevelIx = 0; fieldLevelIx < aggregateLevelChangeDetail.getFieldLevelChangeDetails().length; fieldLevelIx++) {
						FieldLevelChangeDetail fieldLevelChangeDetail = aggregateLevelChangeDetail.getFieldLevelChangeDetails()[fieldLevelIx];
						boolean isSecure = SecureDataEntryMode.isSecureDataEntryEnabled(fieldLevelChangeDetail.getBaseElement());
						CorrectiveActionAudit caa = null;
						if ( hasCorrectionReport ){
						 	caa = transactionCorrectionRpt.findRelatedCorrectiveActionAudit(fieldLevelChangeDetail);
						 	if ( caa == null )
						 		continue;	// only show corrections and not other stuff dealing with pcs when in cr mode.		
				 		}	 
						%>				
						<tr>
							<td><%=JSPHelper.prepareForHTML(fieldLevelChangeDetail.getFieldLabel())%></td>
							<%if (!isSecure || canReadSecureData) { %>
								<%if(!showCurrentValuesOnly) { %>
								<td><%=fieldLevelChangeDetail.getOriginalDisplayValue()%></td>
								<%}%>
								<td><%=fieldLevelChangeDetail.getCurrentDisplayValue()%></td>
							<%} else {
									int colspan = showCurrentValuesOnly ? 1: 2;%>
									<td colspan="<%=colspan%>"><%=rb.getString("prompt.ChangeRequests.Secured.Value")%></td>
							<%}%>
							<%if(!showCurrentValuesOnly) { %>
							<td><%=fieldLevelChangeDetail.getModInfoActionCodeString()%></td>
							<%}%>
							<%if ( caa != null ) {
								String errorMessage = caa.getValidationMessageText();
								String correctiveActionMsg = caa.getCorrectionMessage();
								if ( errorMessage == null )
									errorMessage = "";
								if ( correctiveActionMsg == null )
									correctiveActionMsg = "";	 	
							%>
							<td><%=correctiveActionMsg%></td>
							<td><%=errorMessage%></td>
							<%}%>
						</tr>						
					<%}
				}
				if ( aggregateLevelChangeDetail.getEyeCatcher().length() > 0 ) {%>			
					</tr>
				<%}
			}%>
			</table>
			</div>
			</p>
			<%} 
			}
			%>
			</div>
			<%
			
 		}
	}
%>
	
