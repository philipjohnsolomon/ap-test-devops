<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>
<%@ page
	import="java.util.Iterator,
	java.util.List,
	com.agencyport.defaults.DefaultsItem,
	com.agencyport.data.corrections.*,
	com.agencyport.html.elements.CorrectionElement,
	com.agencyport.webshared.IWebsharedConstants,
	com.agencyport.trandef.validation.TransactionValidationReport,
	com.agencyport.trandef.validation.ValidationResult,
	com.agencyport.utils.text.HtmlTransliterator,
    com.agencyport.html.elements.BaseElement,
    com.agencyport.pagebuilder.BasePageElement,	
	com.agencyport.jsp.JSPHelper,
	com.agencyport.pagebuilder.Page,
	com.agencyport.trandef.Transaction"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%@page import="com.agencyport.data.containers.TransactionDataContainer"%>
	
<%
JSPHelper jspHelper = JSPHelper.get(request);
Transaction transaction = jspHelper.getTransaction();
boolean supportsDefaults = transaction.supportsDefaults();

if (supportsDefaults) {
	Page htmlPage = jspHelper.getPage();
	Page firstBadPage = null;
	DefaultsItem[] defaultsList = jspHelper.getDefaultsList();
	TransactionValidationReport tvr = jspHelper.getTransactionValidationReport();
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
	IResourceBundle defaultsrb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.DEFAULTS_MSGS_BUNDLE);

	String transactionType = transaction.getType();
	String firstTime = jspHelper.getFirstTimeFlag();
	String fromLightBox = jspHelper.getFromLightBox();
	String nameOfDefaultsJustApplied = "";
	String actionJustApplied = "";
	String messageForActionJustApplied = "";

	boolean defaultsAvailable = false;
	boolean wouldBeHelpfulToApplyDefaults = jspHelper.wouldBeHelpfulToApplyDefaults();
	boolean defaultsJustApplied = jspHelper.defaultsJustApplied();
	boolean defaultsResultedInCorrections = jspHelper.defaultsResultedInCorrections();
	boolean defaultsResultedInCompleteDataOverlay = jspHelper.defaultsResultedInCompleteDataOverlay();
	boolean somethingChanged = false;
	boolean tvrRanClean = false;
	boolean actionWasJustApplied = jspHelper.actionWasJustApplied();
	
	Page[] pages;

	if ( tvr != null ) {
		tvrRanClean = tvr.isClean();
		TransactionDataContainer tdr = tvr.getSourceDataContainer();
		pages = tdr.getPages();
	}
	else
		pages = transaction.getAllPages();
	
	if (defaultsResultedInCorrections || defaultsResultedInCompleteDataOverlay) {
		somethingChanged = true;
	}
	
	TransactionCorrectionReport tcr = null;
	CorrectiveActionAudit[] corrections = null;

	if (defaultsList.length > 0) {
		defaultsAvailable = true;
	}
	if (defaultsJustApplied) {
		nameOfDefaultsJustApplied = JSPHelper.prepareForHTML(jspHelper.nameOfDefaultsJustApplied());
	}
	
	if (actionWasJustApplied) {
		actionJustApplied = jspHelper.getActionJustApplied();
		messageForActionJustApplied = JSPHelper.prepareForHTML(jspHelper.getMessageForActionJustApplied());
	}
	%>
	<%@include file="user_defaults/help.jsp" %>
	<%@include file="user_defaults/save.jsp" %>
	<%@include file="user_defaults/which.jsp" %>
	
	<%
	if (defaultsAvailable) {
		%>
		<%@include file="user_defaults/apply.jsp" %>
		<%@include file="user_defaults/confirm_delete.jsp" %>
		<%@include file="user_defaults/manage.jsp" %>
		<%@include file="user_defaults/rename.jsp" %>
		
	<%
	}
	if (actionWasJustApplied) {
		if (actionJustApplied.equals(IWebsharedConstants.APPLY_DEFAULTS)) {
			%>
			<%@include file="user_defaults/just_applied.jsp" %>
			<%
		}
		else if (actionJustApplied.equals(IWebsharedConstants.SAVE_TO_DEFAULTS)) {
			%>
			<%@include file="user_defaults/just_saved.jsp" %>
			<%
		}
		else if (actionJustApplied.equals(IWebsharedConstants.DELETE_DEFAULTS)) {
			%>
			<%@include file="user_defaults/just_deleted.jsp" %>
			<%
		}
		else if (actionJustApplied.equals(IWebsharedConstants.RENAME_DEFAULTS)) {
			%>
			<%@include file="user_defaults/just_renamed.jsp" %>
			<%
		}
	}
}
%>