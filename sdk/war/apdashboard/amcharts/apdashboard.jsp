<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.security.profile.ISecurityProfile"%>
<%@page import="com.agencyport.dashboard.reporting.provider.ReportDataProvider"%>
<%@page import="java.util.List"%>
<%@page import="com.agencyport.dashboard.reporting.model.Report"%>
<%@page import="com.agencyport.id.Id"%>
<%@page import="com.agencyport.dashboard.charting.AbstractChart"%>
<%@page import="com.agencyport.dashboard.reporting.IRequestParameters"%>
<%@page import="com.agencyport.dashboard.reporting.model.ReportParamProperty"%>
<%@page import="com.agencyport.trandef.TransactionDefinitionManager"%>
<%@page import="java.util.Set"%>
<%@page import="com.agencyport.domXML.widgets.LOBCode"%>
<%@page import="com.agencyport.security.model.IUserGroup"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.agencyport.security.model.IPrincipal"%>
<%@page import="com.agencyport.security.model.IGroup"%>
<%@page import="com.agencyport.product.ProductDefinitionsManager" %>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<ap:ap_rb_loader />
<ap:ap_rb_loader rbname="format_info" />

<%
	JSPHelper jspHelper = JSPHelper.get(request);
	ISecurityProfile securityProfile = jspHelper.getSecurityProfile();
	ReportDataProvider reportDataProvider = new ReportDataProvider();
	List<Report> availableReports = reportDataProvider.getTopLevelReports(securityProfile);  
	IResourceBundle dashboardrb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.DASHBOARD_BUNDLE);
%>
	
<!-- .ap-dashboard -->
<div id="dashboard_container" class="ap-dashboard">
	<div class="container">
		<%
		for ( Report report : availableReports ) {
			if ( !report.isChartBased()) {
				continue;
			}
		%>
		
		<!-- .report-block -->
		<div class="report-block">
			<div id="message_<%=report.getId()%>" class="report-message"></div>					
			<div id="content_<%=report.getId()%>" class="report"></div>							
			
			<div class="row report-console">
					<div id="primary_<%=report.getId()%>" class="form-inline">	
											
						<div class="form-group">
							<label class="control-label" for="<%=report.getId()%>_start_date"><%=dashboardrb.getString("label.From")%></label>
							<div class="form-group">
								<div class="has-addon">
									<span class="input-group date">
										<input id="<%=report.getId()%>_start_date" size="10" maxlength="10" value="" type="text" class="form-control"/>
										<span class="input-group-addon">
											<i class="fa"></i>
										</span>
									</span>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label" for="<%=report.getId()%>_end_date"><%=dashboardrb.getString("label.To")%></label>
							<div class="form-group">
								<div class="has-addon">
									<div class="input-group date">
										<input id="<%=report.getId()%>_end_date" size="10" maxlength="10" value="" type="text" class="form-control"/>
										<span class="input-group-addon">
											<i class="fa"></i>
										</span>
									</div>
								</div>
							</div>
					    </div>
					    
						<%if(!report.getName().contains("Top Broken Underwriting Rules")) { %>
						
						<div class="form-group">
							<label for="<%=report.getId()%>_user_groups"><%=dashboardrb.getString("label.For")%></label>
							<select id="<%=report.getId()%>_user_groups"  class="form-control">
								<option value=""><%=dashboardrb.getString("option.All")%></option>
							<%
								Set<IUserGroup> usergrp = securityProfile.getUserGroups().get(securityProfile.getSubject().getPrincipal());
								for(IUserGroup grp : usergrp) {%>
									<option value="<%=grp.getId()%>"><%= grp.getName() %></option>
							<% 
									Iterator<IPrincipal> membersIterator =  grp.members().iterator();
									while ( membersIterator.hasNext() ){
										IPrincipal entry = membersIterator.next();
										if ( entry instanceof IGroup) {	
											%><option value="<%=((IGroup)entry).getId()%>"><%=((IGroup)entry).getName() %></option><% 
										}
									}
								} %>
							</select>	
						</div>
						
						<% }else { %>
						
						<div class="form-group">
							<label for="<%=report.getId()%>_LOB"><%=dashboardrb.getString("label.LOB")%></label>
							<select id="<%=report.getId()%>_LOB" class="form-control">
								<option value="">All</option>
								<%
								Set<LOBCode> lobCodes = TransactionDefinitionManager.getAllLOBs();
								for ( LOBCode lobCode : lobCodes ){%>
								<option value="<%=lobCode.getCode()%>"><%=lobCode.getDescription() %></option>
								<% } %>
							</select>
						</div>
						
						<% } %>
						
						
						<div class="btn-group">
							<button class="btn btn-primary" id="go_<%=report.getId()%>" name="go_<%=report.getId()%>" type="button"><%=dashboardrb.getString("action.Go")%></button>
							<button class="btn btn-default" id="reset_<%=report.getId()%>" name="reset_<%=report.getId()%>" type="button"><%=dashboardrb.getString("action.Reset")%></button>
						</div>

					</div>
					
				</div>
			</div><!-- / .report-block -->
		
		
	<%} %>
	</div><!-- / .container -->
</div><!-- / .ap-dashboard -->
		
<script type="text/javascript">	
	$(function() {
		var chart =  null;
		<%for ( Report report : availableReports ) { %>
			<%if (!report.isChartBased()) {
				continue;
			}%>
			reportParameters = new ap.ReportParameters();
			<%
			for ( ReportParamProperty paramProperty : report.getParameters() ){	%>		
				reportParameters.add(new ap.ReportParameter("<%=paramProperty.getName()%>", "<%=paramProperty.getType().name()%>", <%=paramProperty.isDrilldownParam()%>));		
		 <% } %>	
		 
			chart = new ap.Report("<%=report.getId()%>",
				"<%=report.getDrillDownReportId()%>",
				reportParameters,
				"<%=report.getReportServlet()%>",
				<%=report.isDrillDown()%>);	
			chart.render();
		<%}%>	
	});
</script>
