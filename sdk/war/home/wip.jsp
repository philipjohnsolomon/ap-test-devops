<%@ page import="com.agencyport.account.AccountManagementFeature" %>
<%@ page import="com.agencyport.constants.TurnstileConstantsProvider" %>
<%@ page import="com.agencyport.jsp.JSPHelper" %>
<%@ page import="com.agencyport.locale.IResourceBundle" %>
<%@ page import="com.agencyport.locale.ResourceBundleManager" %>
<%@ page import="com.agencyport.locale.ILocaleConstants" %>
<%@ page import="com.agencyport.worklist.WorkListHelper"%>
<%@ page import="com.agencyport.utils.AppProperties" %>
<%@ page import="com.agencyport.webshared.IWebsharedConstants" %>
<%@ page import="com.agencyport.webshared.URLBuilder" %>

<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal"%>

<!-- Adding core_prompts resource bundles for JavaScript use -->
<ap:ap_rb_loader rbname="core_prompts" />
<ap:ap_rb_loader rbname="worklist" />

<!-- home/wip.jsp-->
<!--@@apwebapp_specification_version@@-->

<% 
String workListType = request.getParameter("WorkListType");
if(workListType == null) {
	workListType = "";
}

int numberOfVisibleRows = AppProperties.getAppProperties().getIntProperty(WorkListHelper.WORKLIST_NUMBER_OF_VISIBLE_ROWS, 10);
int bufferSize = AppProperties.getAppProperties().getIntProperty(WorkListHelper.WORKLIST_BUFFER_SIZE, 250);

IResourceBundle core_rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
int scrollPadding = bufferSize / 2;
String numberOfVisible = request.getParameter("numberOfVisibleRows");
if(null != numberOfVisible){
	numberOfVisibleRows = Integer.parseInt(numberOfVisible);
}
JSPHelper jspHelper = JSPHelper.get(request); 
String worklistId = (String)request.getAttribute(WorkListHelper.WORK_LIST_VIEW_ID);
String filterXML = (String)request.getAttribute(IWebsharedConstants.FILTER_XML + worklistId);
%>


<div class="container" ng-app="ap.worklist">
	<jsp:include page="../worklist/worklist-ng.jsp" />
</div>


<jsp:include page="../home/footer.jsp" flush="true" /> 