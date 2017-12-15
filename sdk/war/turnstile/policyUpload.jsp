<%@ page import="com.agencyport.domXML.RandomGUID" %>
<%@ page import="com.agencyport.webshared.IWebsharedConstants"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.shared.locale.ISharedLocaleConstants"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<%
	IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
 	String errorMessage = (String)request.getAttribute(IWebsharedConstants.TURNSTILE_ERROR_MESSAGE);
 	String display ="";
 	if(errorMessage == null){
 		errorMessage = "";
 		display = "display:none";
 	}
 	
 %>
 <script type="text/javascript">
	function submit(){
		var fileName = $('fileName').value;
		if (fileName == '') {
	    	return false;
	    }
		var uploadForm = $('turnstileupload');
		uploadForm.submit();
	}
</script>
<div id="uploadDownload">
	<form id="turnstileupload" enctype="multipart/form-data" method="post" name="turnstileupload" action="TurnstileServlet">			
		<fieldset class="standardForm">
			<legend><%= coreRB.getString("header.Legend.TurnstilePolicyUpload") %></legend>
			
			<div class="critical" style="<%= display %>">
				<p><%= errorMessage %></p>
			</div>
			<div class="formRow"> 
				<label for="fileName"><span class="requiredField">*</span><%= coreRB.getString("label.PolicyUpload.FileName") %></label>
				<input type="file" value="" id="fileName" name="fileName" size="100" />
				<input type="button" class="button" style="float:center;" id="turnstile_policy_button" value="<%=coreRB.getString("action.Go")%>" onclick="javascript:submit();">
		    </div>                						
		</div>	
		</fieldset>	
	</form>	
</div> 



