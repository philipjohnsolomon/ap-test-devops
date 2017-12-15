<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
%>
<% if ( isTransactionStartPoint ) { %>

<div class="modal fade" id="lb_upload_welcome" tabindex="-1" role="dialog" aria-labelledby="lb_upload_welcome" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="modal-title" class="modal-title"> <%= coreRB.getString("header.Title.Success") %></h2>
			</div>
			<div class="modal-body">
				<p>
					<% if (firstPageIsBad) { %>
					<%@ include file="problem.jsp" %>

						<% if (defaultsAvailable) { %>
						<%@include file="apply_defaults.jsp" %>
						<% }

					} else { if (tvrRanClean) { %>
					<p><%@include file="clean_transfer.jsp"%></p>
				
				<h4><%@include file="where.jsp" %></h4>
			
					<%} else { %>
				
					<p><%@include file="problem.jsp" %></p>
					<h4><%@include file="where.jsp" %></h4>
					<p>
						<% if (defaultsAvailable) { %>
						<%@include file="apply_defaults.jsp" %>
						<% }
						} %>
					</p>
			
					<% } %>
	
					<% if ( hasCorrections ){%>
						<%@include file="corrections.jsp" %></p>
					<% } %>
			
				<div class="button-row">
				<% if (!tvrRanClean) {  %>
					<%@include file="fast_forward.jsp" %>
				<% } else { %>
					<% if (isQuickQuote) { %>
							<%@include file="quick_quote.jsp" %>
						<% } else { %>
							<%@include file="to_summary.jsp" %>
					<% } %>
				<% } %>
					<%@include file="double_check.jsp" %>
				
				</div>
			
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<% } %>