<!-- \shared\APErrorJSP.jsp-->

<%@ page import="com.agencyport.servlets.base.IBaseConstants,
				 com.agencyport.shared.ExceptionReport" %>
<%@page import="com.agencyport.utils.AppProperties"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.LocaleFactory"%>
<%@page import="java.util.Locale"%>
<%@page import="com.agencyport.utils.text.StringUtilities"%>

<%
	ExceptionReport exRpt = (ExceptionReport) request.getAttribute(IBaseConstants.ERROR_REPORT); 
    String urlLink = (String) request.getAttribute(IBaseConstants.URL_LINK);
    Locale locale = LocaleFactory.get().acquireLocale(request);
    IResourceBundle coreRB = ResourceBundleManager.get().getBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE, locale);
    coreRB = coreRB.getHTMLEncoder();

    // perform html character encoding on the errorString
    String highLevelMessage = 
			com.agencyport.utils.text.HtmlTransliterator.encode(exRpt.getHighLevelMessage());
	String detailedErrorMessage = 			
			com.agencyport.utils.text.HtmlTransliterator.encode(exRpt.getDetailedMessage());
	String detailedSystemInformation = 			
			com.agencyport.utils.text.HtmlTransliterator.encode(exRpt.getDetailedSystemInformation());
	boolean showExtendedErrorDetail = AppProperties.getAppProperties().getTrueFalseBooleanProperty("show_extended_error_detail", false, false);
%>

<script type="text/javascript">
	ap.toggleExtendedErrorInfo = function() {
		$('#extendedErrorInfo').toggle('blind');	
	}
</script>

<section id="error_page" class="error-404-section">
	<div class="container">
		<div class="padded-box">
			<h1><%=coreRB.getString("header.ProblemWithRequest")%></h1>
			<p><%=highLevelMessage%></p>
			<%
			//We don't display a link for runtime and InvalidSessionException
		    if(!StringUtilities.isEmpty(urlLink)){
			%>
			<a href="<%=urlLink%>" class="btn btn-large btn-primary"><%=coreRB.getString("action.ClickHereToContinue")%></a>
			<%
		    }
			%>
			<% if ( showExtendedErrorDetail ) { %>
				<p><a href="javascript: ap.toggleExtendedErrorInfo();void(0);"><%=coreRB.getString("action.ToggleExtendedError")%></a></p>
				<div id="extendedErrorInfo" style="display: none">
					<p><%=detailedErrorMessage%></p>
					<pre><%=detailedSystemInformation%></pre>
				</div>
			<%}%>
		</div>
	</div>
</section>

<jsp:include page="../home/footer.jsp" flush="true" />