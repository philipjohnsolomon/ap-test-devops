<%@ page import="java.util.*,
    com.agencyport.pagebuilder.*,
    com.agencyport.domXML.IXMLConstants,
    com.agencyport.domXML.changemanagement.*,
  	com.agencyport.jsp.JSPHelper,
    com.agencyport.trandef.*,
    com.agencyport.utils.ArrayHelper,
    com.agencyport.policysummary.*,
    com.agencyport.policysummary.changemanagement.*,
    com.agencyport.webshared.IWebsharedConstants"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%
	JSPHelper jspHelper = JSPHelper.get(request);
	PolicyChangeSummarizer summary = jspHelper.getPolicyChangeSummarizer();
    Page htmlPage = jspHelper.getPage();
    Transaction tran = jspHelper.getTransaction();
	boolean hasChanges = false;
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.POLICY_SUMMARY_BUNDLE);
    
    String undoAllChangesPrompt = rb.getString("prompt.PageSetup.UndoAllChanges");
    String confirmDeleteRequestPrompt = rb.getString("prompt.PageSetup.ConfirmDeleteRequest");
    String showPrompt = rb.getString("prompt.PageSetup.ShowChanges");
    String showPromptTitle = rb.getString("title.PageSetup.ShowChanges");
    String hidePrompt = rb.getString("prompt.PageSetup.HideChanges");
    String hidePromptTitle = rb.getString("title.PageSetup.HideChanges");
	if ( summary != null ){
	    if ( summary.shouldOnlyShowCurrentValues() ){
    		showPrompt = rb.getString("prompt.PageSetup.ShowDetails");
    		showPromptTitle = rb.getString("title.PageSetup.ShowDetails");
    		hidePrompt = rb.getString("prompt.PageSetup.HideDetails");
    		hidePromptTitle = rb.getString("title.PageSetup.HideDetails");
	    }
	
		hasChanges = summary.hasChanges(tran);
	}
    String processMethod = (String) request.getAttribute("METHOD");
    if (processMethod == null) 
    	processMethod = "Process";
%> 
<script type="text/javascript">
	function processChangeRequestAction(action){
		if (action == "Undo All Changes") {
			if(!confirm('<%=undoAllChangesPrompt%>')) 
				return false;
		}
		else if (action == "Cancel") {
			if(!confirm('<%=confirmDeleteRequestPrompt%>')) 
				return false;
		}
		else if (action == "") 
			return false;
		document.getElementById('NEXT').value = action;
		var form =  document.getElementById('<%= htmlPage.getId()%>');
		form.submit();
	}
	ap.processChangeRequestAction = processChangeRequestAction;
</script>
<script type="text/javascript">
	function manageChangePageDetail(triggeringLink) {
		var summaryDiv = document.getElementById(triggeringLink.id + "_DIV");
		var currentState = summaryDiv.style.display;

		if (currentState == "none") {
			summaryDiv.style.display = "block";
			triggeringLink.removeChild(triggeringLink.firstChild);
			triggeringLink.appendChild(document.createTextNode("<%=hidePrompt%>"));
			triggeringLink.setAttribute("title", "<%=hidePromptTitle%>");
		}
		else {
			summaryDiv.style.display = "none";
			triggeringLink.removeChild(triggeringLink.firstChild);
			triggeringLink.appendChild(document.createTextNode("<%=showPrompt%>"));
			triggeringLink.setAttribute("title", "<%=showPromptTitle%>");
		}
	}
	ap.manageChangePageDetail = manageChangePageDetail;
</script>
	
