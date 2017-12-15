<!--  polInfo.jsp a policy change summary artifact -->
<%@ page import="com.agencyport.domXML.IXMLConstants,
    com.agencyport.utils.AppProperties,
    com.agencyport.utils.ArrayHelper,
  	com.agencyport.jsp.JSPHelper,
    com.agencyport.policysummary.changemanagement.*,
    com.agencyport.trandef.Transaction"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%
	JSPHelper jspHelper = JSPHelper.get(request);
    Transaction tran = jspHelper.getTransaction();
	PolicyChangeSummarizer summary = jspHelper.getPolicyChangeSummarizer();
	boolean hasChanges = summary.hasChanges(tran);
	String isCommercialString = request.getParameter(PolicyChangeConstants.IS_COMMERCIAL);
	boolean isCommercial = AppProperties.determineTrueFalseValue(isCommercialString, false);
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.POLICY_SUMMARY_BUNDLE);
%> 
		<tr>
			<td><%=rb.getString("label.PolInfo.PolicyNumber")%></td>
			<td><%=summary.getPolicyNumber()%></td>
		</tr>
		<tr>
			<td><%=rb.getString("label.PolInfo.ReferenceNumber")%></td>
			<td><%=summary.getWorkItemId()%></td>
		</tr>
		<tr>
			<td><%=rb.getString("label.PolInfo.NamedInsured")%></td>
			<td><%=summary.getInsuredName(IXMLConstants.VIEW_ORIGINAL_DOCUMENT, isCommercial)%>
				<%if ( summary.hasInsuredNameChanged()) 
					{
					String changedTo = ResourceBundleStringUtils.makeSubstitutions("rb:policy_summary:message.PolInfo.ChangedTo", JSPHelper.prepareForHTML(summary.getInsuredName(IXMLConstants.VIEW_CURRENT_DOCUMENT, isCommercial)));
				%>
				<span style="font-style: italic"> <%=changedTo%></span>
				<%}%>
			</td>
		</tr>
		<tr>
			<td><%=rb.getString("label.PolInfo.PolicyEffectiveDate")%></td>
			<td><%=summary.getPolicyEffectiveDate()%></td>
		</tr>
		<tr>
			<td><%=rb.getString("label.PolInfo.PolicyExpirationDate")%></td>
			<td><%=summary.getPolicyExpirationDate()%></td>
		</tr>
		<tr>
			<td><%=rb.getString("label.PolInfo.EndorsementEffectiveDate")%></td>
			<td><%=summary.getTransactionEffectiveDate()%></td>
		</tr>
		<tr>
			<td><%=rb.getString("label.PolInfo.InsuredMailingAddress")%></td>
			<td><%=JSPHelper.prepareForHTML(ArrayHelper.stringArrayAsString(summary.getInsuredMailingAddress(IXMLConstants.VIEW_ORIGINAL_DOCUMENT)))%>
				<%if ( summary.hasInsuredMailingAddressChanged()) 
					{
						String changedTo = ResourceBundleStringUtils.makeSubstitutions("rb:policy_summary:message.PolInfo.ChangedTo", JSPHelper.prepareForHTML(ArrayHelper.stringArrayAsString(summary.getInsuredMailingAddress(IXMLConstants.VIEW_CURRENT_DOCUMENT))));
				%>
				<span style="font-style: italic"> <%=changedTo%></span>
				<%}%>
			</td>
		</tr>
