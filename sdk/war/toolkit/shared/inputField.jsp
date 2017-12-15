<%@page import="com.agencyport.domXML.APDataCollection,
				com.agencyport.webshared.IWebsharedConstants"%>
<%@page import="com.agencyport.toolkit.data.ToolkitOptionListProvider"%>

<%
	String label = request.getParameter("label");
	String path = request.getParameter("path");
	//this is used if we want a different id from the saves to id
	String elementName = request.getParameter("elementName");
	if(elementName == null) {
		elementName = path;
	}
	String required = request.getParameter("required");
	String defaultValue = request.getParameter("defaultValue");
	String size = request.getParameter("size");
	String className = request.getParameter("class");
	if ("*".equals(required)) {
		className = className + " required";
	}
	
	//This is to show of hide the div. Prototype's show()/hide() api 
	//to work with inline style of 'display: none;' and not style class. 
	String showHideDiv = (String) request.getParameter("showHideDiv");
	
	APDataCollection artifactData = (APDataCollection)request.getAttribute(IWebsharedConstants.APDATACOLLECTION);
	
	String fieldValue = defaultValue;
	if (!path.startsWith("SP.") && artifactData != null) {
		fieldValue = artifactData.getFieldValue(elementName, defaultValue);
	}
	
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
		<input type="text" title="<%=fieldValue %>" name="<%=elementName%>" id="<%=path%>" size="<%=size%>" value="<%=fieldValue %>" class="<%=className%>"/>
	</span>
</div>