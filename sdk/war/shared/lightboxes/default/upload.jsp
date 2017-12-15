<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>
<%@page import="com.agencyport.product.ProductDefinitionsManager"%>
<%@ page
	import="com.agencyport.defaults.DefaultsItem,
	com.agencyport.jsp.JSPHelper,
	com.agencyport.pagebuilder.Page,
	com.agencyport.trandef.validation.TransactionValidationReport,
	com.agencyport.trandef.validation.ValidationResult,
	com.agencyport.data.containers.*,
	com.agencyport.data.corrections.*,
	com.agencyport.trandef.Transaction"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%@page import="com.agencyport.account.AccountManagementFeature"%>
<%@page import="com.agencyport.workitem.model.ILOBWorkItem" %>
<%@page import="com.agencyport.id.Id" %>
	
<%
JSPHelper jspHelper = JSPHelper.get(request);
boolean requireAccountSetup = jspHelper.requireAccountSetup();
boolean isUploadSituation = jspHelper.isUploadSituation();
if (isUploadSituation || requireAccountSetup){
	String versionNumber = ProductDefinitionsManager.getCurrentlyRunningVersion().toString();
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
	IResourceBundle uploadrb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.UPLOAD_INFO_BUNDLE);
	Page htmlPage = jspHelper.getPage();
	Page firstBadPage = null;
	Transaction transaction = jspHelper.getTransaction();
	TransactionCorrectionReport[] tcrs = jspHelper.getTransactionCorrectionReports();
	TransactionValidationReport tvr = jspHelper.getTransactionValidationReport();
	ValidationResult[] validationResults = null;
	int workItemId = jspHelper.getWorkItemId();
	DefaultsItem[] defaultsList = jspHelper.getDefaultsList();
	String transactionType = transaction.getType();
	String firstTime = jspHelper.getFirstTimeFlag();
	String fromLightBox = jspHelper.getFromLightBox();
	String uploadSourceVersion = jspHelper.getUploadSourceVersion();
	String uploadSourceSystem = jspHelper.getUploadSourceSystem();
	String uploadSourceOrg = jspHelper.getUploadSourceOrg();

	boolean isTransactionStartPoint = true;//jspHelper.isTransactionStartPoint();
	boolean supportsUploadDataCorrection = transaction.supportsUploadDataCorrection();
	boolean supportsPreValidation = htmlPage.shouldPreValidate();
	boolean supportsDefaults = transaction.supportsDefaults();
	boolean defaultsAvailable = false;
	boolean wouldBeHelpfulToApplyDefaults = jspHelper.wouldBeHelpfulToApplyDefaults();
	boolean tvrRanClean = false;
	boolean firstPageIsBad = false;
	boolean hasCorrections = false;
	boolean isQuickQuote = false;
	
	if (tcrs.length > 0) {
		hasCorrections = true;
	}

	if (defaultsList.length > 0) {
		defaultsAvailable = true;
	}	
	
	if (transactionType.equals("QUICK_QUOTE")) {
		isQuickQuote = true;
	}

	if ( tvr != null ) {
		firstBadPage = jspHelper.getFirstBadPageFromTVR();
		if (firstBadPage != null) {
			if (firstBadPage.getId().equals(htmlPage.getId())) {
				firstPageIsBad = true;
			}
		}
		tvrRanClean = tvr.isClean();
		
		if (!tvrRanClean) {
			validationResults = tvr.getEntireDetailValidationResultSet(false);
			%>
			<%@include file="upload/tvr.jsp" %>
			<%
		}
	}
	%>
	<%@include file="upload/help.jsp" %>
	<%@include file="upload/body.jsp" %>
	<%@include file="upload/info.jsp" %>
	<%
}
%>
