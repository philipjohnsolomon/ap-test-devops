<%@page import="com.agencyport.domXML.APDataCollection"%>
<%@page import="com.agencyport.toolkit.data.ToolkitOptionListProvider,
				com.agencyport.webshared.IWebsharedConstants"%>

<%
	String label = request.getParameter("label");
	String path = request.getParameter("path");
	String required = request.getParameter("required");
	String defaultValue = request.getParameter("defaultValue");
	String optionList = request.getParameter("optionList");
	String className = request.getParameter("class");
	//This is to show of hide the div. Prototype's show()/hide() api 
	//to work with inline style of 'display: none;' and not style class. 
	String showHideDiv = (String) request.getParameter("showHideDiv");
	
	if(className == null) {
		className = "";
	}
	if ("*".equals(required)) {
		className = className + " required";
	}
	//this is used if we want a different id from the saves to id
	String elementName = request.getParameter("elementName");
	if(elementName == null) {
		elementName = path;
	}

	APDataCollection artifactData = (APDataCollection)request.getAttribute(IWebsharedConstants.APDATACOLLECTION);
	
	String fieldValue = defaultValue;
	if (!path.startsWith("SP.") && artifactData != null) {
		fieldValue = artifactData.getFieldValue(elementName, defaultValue);
	}
	String options = ToolkitOptionListProvider.getOptionListHTML(optionList, fieldValue, defaultValue);

	String helptext = request.getParameter("helptext");
	String helpDescription = "";
	
	if (helptext != null){
		String[] helptextSplit = helptext.split("\\|");
		helpDescription = ToolkitOptionListProvider.getOptionListValue(helptextSplit[0],helptextSplit[1]);
	}
%>


<div id="<%=path%>_formRow" class="formRow" style="<%=showHideDiv%>">
	<label class="label" id="<%=path%>_labelElement" for="<%=path%>">
		<span id="<%=path%>_required"><%=required%></span>
		<%if (helptext == null) { %>
		<span id="<%=path%>_labelText"><%=label%></span>
		<%
		} else { %>
		<span id="<%=path%>_labelText">
			<acronym title="<%=helpDescription %>">
				<%=label%>
			</acronym>
		</span>
		<%} %>
	</label>
	<span>
		<select name="<%=elementName%>" id="<%=path%>" class="<%=className%>" >
		<%=options%>
		</select>
	</span>
</div>