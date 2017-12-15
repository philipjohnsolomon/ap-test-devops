<!--begin shared/endorse/corePolicyChangeSummary.jsp -->
<!--BEGIN STANDARD FRAMEWORK -->

<%@page import="com.agencyport.connector.MessageMap"%>
<%@page import="com.agencyport.connector.IConnectorConstants"%>
<%@page import="com.agencyport.webshared.URLBuilder"%>
<%@page import="com.agencyport.workitem.model.IWorkItem" %>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<%@include file="../../policychange/pageSetup.jsp" %>
<%
	boolean unresolvedIssues = false;
    MessageMap messageMap = (MessageMap) request.getAttribute(IWebsharedConstants.MESSAGES);
    IResourceBundle policySummaryRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.POLICY_SUMMARY_BUNDLE);
	if ( messageMap != null && messageMap.count(IConnectorConstants.MESSAGE_ERROR_LITERAL) > 0 )
		unresolvedIssues = true;
			
	boolean showWorkItemAssistant = jspHelper.supportsWorkItemAssistant();

	if(showWorkItemAssistant){
		IWorkItem workItem = jspHelper.getWorkItem();
		if(workItem != null)
			showWorkItemAssistant = workItem.getCommitFlag();
	}
 %>

<section class="policy-summary endorsement">
	<div class="container">
		<div class="messages">
			<jsp:include page="../../shared/messageTemplate.jsp" flush="true" />
		</div>

		<div class="header">
			<h1><%=JSPHelper.prepareForHTML(htmlPage.getTitle())%></h1>
			<jsp:include page="../../policychange/standardTips.jsp" flush="true" />
		</div>

		<div class="row padded-box animated fadeIn">

			<form action="FrontServlet" id="<%=htmlPage.getId()%>" name="<%=htmlPage.getId()%>" method="post">
				<input type="hidden" name="NEXT" id="NEXT" value="" />
				<input type="hidden" name="WORKITEMID" value="<%=summary.getWorkItemId()%>" />
				<input type="HIDDEN" name="TRANSACTION_NAME" value="<%=htmlPage.getOwningTransaction().getId()%>" />
				<input type="HIDDEN" name="PAGE_NAME" value="<%=htmlPage.getId()%>" /> 
				<input type="HIDDEN" name="METHOD" value="<%=processMethod%>" /> 
				<ap:csrf/>

				<h3><%= policySummaryRB.getString("header.Title.PolicyInformation") %></h3>
				<table summary="Submission Summary" class="table">
					<jsp:include page="../../policychange/polInfo.jsp" flush="true" />
					<% if(hasChanges) {
					String url = URLBuilder.buildFrontServletURL(jspHelper.getWorkItemId(), "PolicyChangePDF", null, 
					htmlPage.getOwningTransaction().getId(), URLBuilder.DISPLAY_METHOD, false);
					%>		 
					<tr>
						<td><%= policySummaryRB.getString("header.Title.PolicyChangeForm") %></td>
						<td><a href="<%=url%>" target="new_window" title="Change Request PDF" class="pdf" /><i class="fa"></i>Change Request PDF</td>
					</tr>
					<% }%>		
					<!--  If you want to add more table rows just add as many tr entries as you want here. -->
				</table>

				<jsp:include page="../../policychange/changeRequests.jsp" flush="true" >
					<jsp:param name="CHANGE_REQUEST_TITLE" value="Change Requests Summarized by Screen" />
				</jsp:include>

				<% if(hasChanges) { 
					final Transaction transaction = htmlPage.getOwningTransaction();
					final String transactionType = transaction.getType().toLowerCase();
					StringBuffer message = new StringBuffer("This ");
					message.append(transactionType); 
					if (unresolvedIssues)
					message.append(" request cannot be submitted in its current state. Please fix the issues as noted.");
					else
					message.append(" request has not yet been submitted to the carrier. Click the \"submit\" button below to do so now.");
				%>
		
				<!--  This depends on a Java script function 'processChangeRequestAction()' 
				which is declared in pageSetup.jsp -->		
				<h3><%= policySummaryRB.getString("header.Title.Actions") %></h3>
				<h4><%=JSPHelper.prepareForHTML(message.toString())%></h4>
				<div class="button-row">
					<%if (!unresolvedIssues) { %>
					<input type="button" name="submitButton" value="Submit" onclick="processChangeRequestAction(this.value);" />
					<%} 
					else { %>
					<input type="button" name="saveExitButton" value="Save and Exit" onclick="processChangeRequestAction(this.value);" />
					<%}%>
					<select class="secondaryActions" onchange="processChangeRequestAction(this.value);">
					<option selected="" value=""><%= policySummaryRB.getString("action.MoreActions") %></option>
					<%if (!unresolvedIssues) { %>
					<option value="Save and Exit"><%= policySummaryRB.getString("action.SaveAndExit") %></option>
					<%}%>
						<option value="Cancel"><%= policySummaryRB.getString("action.Cancel") %></option>
						<option value="Undo All Changes"><%= policySummaryRB.getString("action.UndoAllChanges") %></option>
					</select>
					<%}%>
				</div>
				<ap:control_data/>	
			</form>
		</div>
		
	</div>
</section>

<jsp:include page="../../home/footer.jsp" flush="true" />
