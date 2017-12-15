<!--  standardTips.jsp a policy change summary artifact -->
<%@ page import="com.agencyport.trandef.Transaction,
  	com.agencyport.jsp.JSPHelper,
    com.agencyport.policysummary.changemanagement.PolicyChangeSummarizer"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%
	JSPHelper jspHelper = JSPHelper.get(request);
    Transaction tran = jspHelper.getTransaction();
	
	// When we have multiple PCS the following will get the first one if there else a null will be returned.     
	PolicyChangeSummarizer summary = jspHelper.getPolicyChangeSummarizer();
	boolean hasChanges = summary.hasChanges(tran);
	String transactionType = tran.getType().toLowerCase();
	IResourceBundle policySummaryRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.POLICY_SUMMARY_BUNDLE);
	
%> 
	<div id="tip">
	<%if ( hasChanges ) { %>
		<h4 class="hidden"><%=policySummaryRB.getString("header.Title.Tips") %></h4>
		<p><%=policySummaryRB.getString("prompt.StandardTips.RequestNotYetSubmitted")%></p>
	<%} else {%>
		<h4 class="hidden"><%=policySummaryRB.getString("header.Title.Tips") %></h4>
		<p><%=policySummaryRB.getString("prompt.StandardTips.NoChangesApplied")%></p>
		<p><%=policySummaryRB.getString("prompt.StandardTips.NoFurtherAction")%></p>
	<%}%>
	</div>