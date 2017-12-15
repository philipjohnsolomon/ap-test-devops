<!--begin commlAuto/policySummary.jsp -->

<!--BEGIN STANDARD FRAMEWORK -->

<%@ page import="java.util.*,
    com.agencyport.pagebuilder.Page,
    com.agencyport.autob.beans.AutobPolicySummary,
    com.agencyport.webshared.IWebsharedConstants, 
	com.agencyport.webshared.URLBuilder,
	com.agencyport.jsp.JSPHelper"%>
	
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal"%>

<%@ include file="../policychange/pageSetup.jsp" %>
<%@ include file="../shared/framework_ui.jsp" %>

<%
	String pageTitle = htmlPage.getTitle();
    String pageName = htmlPage.getId();
	AutobPolicySummary policySummary = (AutobPolicySummary) request.getAttribute("AUTOB_POLICY_SUMMARY");
	String status = JSPHelper.prepareForHTML(policySummary.getWorkItemStatus().getAfterChangeStatusTitle());
	String[] validationErrors = (String[]) request.getAttribute("ERRORS");
	IResourceBundle policySummaryRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.POLICY_SUMMARY_BUNDLE);

 	String pdfUrl = URLBuilder.buildFrontServletURL(jspHelper.getWorkItemId(), "PDFForm", null, "commlAuto", URLBuilder.DISPLAY_METHOD, false);
%>

<div class="container policy-summary">
	<div class="messages">
		<jsp:include page="../shared/messageTemplate.jsp" flush="true" />
	</div>
	
	<div class="header">
		<h1>
			<%=policySummaryRB.getString("header.Title.Summary")%>
			<span class="label label-<%=status.toLowerCase()%> "><%=status%></span>
		</h1>
		<p><%=policySummaryRB.getString("prompt.StandardTips.SaveAndExit")%></p>
	</div>

	<div class="row padded-box animated fadeIn premiums">
		<div class="col-md-4">
			<div class="premium monthly">
				<h3>$<%=JSPHelper.prepareForHTML(policySummary.getTotalPremium().toString())%></h3>
				<h4><%=policySummaryRB.getString("header.Title.Monthly")%></h4>
			</div>
		</div>
		<div class="col-md-4">
			<div class="premium bi-annual">
				<h3>$<%=JSPHelper.prepareForHTML(policySummary.getTotalPremium().toString())%></h3>
				<h4><%=policySummaryRB.getString("header.Title.BiAnnual")%></h4>
			</div>
		</div>
		<div class="col-md-4">
			<div class="premium full-payment">
				<h3>$<%=JSPHelper.prepareForHTML(policySummary.getTotalPremium().toString())%></h3>
				<h4><%=policySummaryRB.getString("header.Title.Full")%></h4>
			</div>
		</div>
	</div>
	
	<% if (null == policySummary) { %>
	<div class="padded-box">
		<h3><%=policySummaryRB.getString("header.Title.Summary")%></h3>
		<p><%=policySummaryRB.getString("label.Summary.Error")%></p>
	</div>
	<% } %>
	
	<div class="row animated fadeIn cards">
		<div class="col-xs-12 col-lg-4">
			<div class="card agency">
				<h3>
					<%=policySummary.getAgencyName()%>
					<span class="pull-right"><i class="fa"></i></span>
				</h3>
				<ul>
					<li><%=policySummaryRB.getString("label.Agency.ProducerCode")%><%=policySummary.getProducerCode()%></li>
					<li><%=policySummaryRB.getString("label.Agency.AgencyCustomerID")%> <%=policySummary.getAgencyCustomerId()%></li>
				</ul>
			</div>
		</div>
		<div class="col-xs-12 col-lg-4">
			<div class="card applicant">
				<h3>
					<%=policySummary.getInsured()%>
					<span class="pull-right"><i class="fa"></i></span>
				</h3>
				<ul>
					<li><%=policySummaryRB.getString("label.Applicant.CoApplicant")%> <%=policySummary.getCoinsured()%></li>
					<li><%=policySummaryRB.getString("label.Applicant.PolicyTerm")%> <%=policySummary.getEffectiveDate()%> to <%=policySummary.getExpirationDate()%></li>
				</ul>
			</div>	
		</div>
		<div class="col-xs-12 col-lg-4">
			<div class="card documents">
				<h3>
					<%=policySummaryRB.getString("header.Title.Documents")%>
					<span class="pull-right"><i class="fa"></i></span>
				</h3>
				<p>
					<ap:view_acord_forms />								
				</p>
			</div>
		</div>
	</div>
	
	<div id="quote">
		<ap:page />
	</div>
			
	<form action="FrontServlet" id="<%=pageName%>" name="<%=pageName%>" method="post">
		<input type="hidden" name="TRANSACTION_NAME" id="TRANSACTION_NAME" value="<%=tran.getId()%>" />
		<input type="hidden" name="PAGE_NAME" id="PAGE_NAME" value="<%=htmlPage.getId()%>" />
		<input type="hidden" name="WORKITEMID" value="<%=jspHelper.getWorkItemId()%>" />
		<input type="hidden" name="NEXT" />
		<input type="hidden" name="METHOD" value="Process"/> 
		<ap:csrf/>
		<script type="text/javascript">
		ap.submitQuoteForm = function(action) {
			var form = document.forms["<%=pageName%>"];
			var next = form["NEXT"];
			next.value = action;
			/*
			if( action == 'ConvertToApplication' ) {
				$("#lb_confirm_convert").modal();
			}
			else */{
				form.submit();
				ap.pleaseWaitLB(true);
			}
		}
		</script>
		<div id="buttons">
			<div class="btn-group" role="group">
			<% if (tran.getType().equals(IWebsharedConstants.QUICK_QUOTE_TRANSACTION_TYPE)) { %>
				<input name="convertToApplicationButton" type="button" class="btn btn-primary" value="Convert to Application" onclick="ap.submitQuoteForm('ConvertToApplication');" />
			<% } %>
				
				<input name="saveAndExitButton" type="button" class="btn btn-primary" value="Save and Exit" onclick="ap.submitQuoteForm('Save and Exit');" />
				<a href="#" class="btn btn-default" onclick="javascript:window.history.back(-1);return false;"><%=policySummaryRB.getString("action.Back")%></a>
			</div>
		</div>		
	</form>
</div>

<jsp:include page="../home/footer.jsp" flush="true" />