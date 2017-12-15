<!-- BEGIN fileAttachmentsInclude.jsp -->

<%@ page import="java.util.List,
        com.agencyport.webshared.IWebsharedConstants,
        com.agencyport.fileAttachments.FileAttachment,
        com.agencyport.fileAttachments.FileAttachmentManager,
        java.net.URLEncoder,
        com.agencyport.policysummary.BasePolicySummary"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%@page import="com.agencyport.webshared.URLBuilder"%>
<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
        <%
        JSPHelper jspHelper = JSPHelper.get(request);
    	FileAttachmentManager fileAttachmentManager = (FileAttachmentManager) request.getAttribute("FILE_ATTACHMENT_MANAGER");
        IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
        if (fileAttachmentManager == null) {
            return;
        }
        List roster = fileAttachmentManager.getFileAttachmentRoster();
        if ((roster == null || roster.size() <= 0))  {
            return;
        } 
	BasePolicySummary summary =	(BasePolicySummary) request.getAttribute("POLICY_SUMMARY");
%>
	<fieldset>
	<legend><%=rb.getString("legend.FileAttachments.Attachments")%></legend>
	<table class="table table-condensed table-striped">
		<tbody>
<%
        for (java.util.ListIterator li = roster.listIterator(); li.hasNext(); ) {
       
            FileAttachment fileAttachment = (FileAttachment) li.next();
            String fileName = fileAttachment.getFileName();

			if(fileName != null && fileName.length() > 0){
				fileName=  URLEncoder.encode(fileName, "UTF-8");
			}

            String documentType = fileAttachment.getDocumentType();
            Map<String, Object> extraParameters = new HashMap<String, Object>();
            extraParameters.put("FILENAME", fileName);
            extraParameters.put("INDEX.FileAttachmentInfo", "FileAttachmentInfo["+li.previousIndex()+"]");
            String url = URLBuilder.buildFrontServletURL(jspHelper.getWorkItemId(), "fileAttachment", null, jspHelper.getTransaction().getId(), URLBuilder.DISPLAYVIEWFILE_METHOD, false, extraParameters);
%>
				<tr>
					<td colspan=3>
	                     <a href="<%=url%>" target="newWindow" >
	                    <img src="themes/agencyportal/page.gif" alt="<%=ResourceBundleStringUtils.makeSubstitutions(rb.getString("alt.FileAttachments.ViewPrint"), fileName)%>"/>
	                    <%=ResourceBundleStringUtils.makeSubstitutions(rb.getString("action.FileAttachments.View"), documentType, fileName)%>
	                    </a>
	                </td>
	            </tr>
				<tr><td colspan=3>&nbsp;</td></tr>
<%
    	}
    
%> 
		</tbody>
	</table>
	</fieldset>
<!-- END fileAttachmentsInclude.jsp -->
