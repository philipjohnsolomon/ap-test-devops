<%@page import="com.agencyport.security.profile.impl.SecurityProfileManager"%>
<%@page import="com.agencyport.security.profile.ISecurityProfile"%>

<!-- Modal -->
<div class="modal fade" id="lb_tcr" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title" id="myModalLabel"><%=virb.getString("header.Correction.CorrectionsHaveBeenMade")%></h2>
			</div>
			<div class="modal-body">
			<% 
			ISecurityProfile secProfile = SecurityProfileManager.get().acquire();
			boolean canReadSecureData = secProfile.getRoles().checkPermission(secProfile.getSubject().getPrincipal(), "canReadSecureData");
			
			if ( isQuickQuote ) { %>
				<p><%=virb.getString("message.Correction.CorrectionsHaveBeenMade")%></p>
			<% }
			for (int i = 0; i < tcrs.length; i++) {
				corrections = tcrs[i].getCorrectiveActionAudits();
				%>
				<p><%=virb.getString("header.Correction.MadeOn")%> <%=tcrs[i].getCreationTime().getStringDate() %></p>

					<% for (CorrectiveActionAudit correction : corrections) { %>
					<div class="data">
						<h3><%=virb.getString("header.Correction.Field")%>: <%=correction.getEntityLabel() %></h3>
						<div class="details">
						<%if (!correction.shouldSecureFromDisplay() || canReadSecureData) { %>
							<p><strong><%=virb.getString("header.Correction.Was")%>:</strong> <%=JSPHelper.prepareForHTML(correction.getPreviousValue())%></p>
							<p><strong><%=virb.getString("header.Correction.IsNow")%>:</strong> <%=JSPHelper.prepareForHTML(correction.getAdjustedValue())%></p>
						<% } %>
							<p class="error"><strong><%=virb.getString("header.Correction.Error")%>:</strong> <%=JSPHelper.prepareForHTML(correction.getValidationMessageText())%></p>
							<p><strong><%=virb.getString("header.Correction.Notes")%>:</strong> <%=JSPHelper.prepareForHTML(correction.getCorrectionMessage())%></p>
						</div>
					</div>
					<% } %>

				<% } %>
			</div>
		</div>
	</div>
</div>