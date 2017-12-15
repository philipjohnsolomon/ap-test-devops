<%@page import="com.agencyport.domXML.APDataCollection,
				com.agencyport.webshared.IWebsharedConstants"%>
<%@page import="com.agencyport.toolkit.data.ToolkitOptionListProvider"%>

<%
	String label = request.getParameter("label");
	String path = request.getParameter("path");
	//this is used if we want a different id from the saved id
	String elementName = request.getParameter("elementName");
	if(elementName == null) {
		elementName = path;
	}
	String required = request.getParameter("required");
	String defaultValue = request.getParameter("defaultValue");
	String product = request.getParameter("product");
	String artifactId = request.getParameter("artifactId");
	String className = request.getParameter("class");
	if ("*".equals(required)) {
		className = className + " required";
	}
	String helptext = request.getParameter("helptext");
	String helpDescription = "";
	
	if (helptext != null){
		String[] helptextSplit = helptext.split("\\|");
		helpDescription = ToolkitOptionListProvider.getOptionListValue(helptextSplit[0],helptextSplit[1]);
	}
	
	//APDataCollection artifactData = (APDataCollection)request.getAttribute("ARTIFACTDATA");
	APDataCollection artifactData = (APDataCollection)request.getAttribute(IWebsharedConstants.APDATACOLLECTION);
		
	String fieldValue = artifactData.getFieldValue(elementName, defaultValue);
%>

<div id="<%=path%>_formRow" class="formRow">
	<label class="label" id="<%=path%>_labelElement" for="<%=path%>">
		<span id="<%=path%>_required" ><%=required%></span>
		<%if (helptext == null) { %>
		<span id="<%=path%>_labelText"><%=label%></span>
		<%
		} else { %>
		<span id="<%=path%>_labelText">
			<acronym title="<%=helpDescription%>">
				<%=label%>
			</acronym>
		</span>
		<%} %>
	</label>
	<span id="<%=path%>_inplace">
		<span title="(click here to edit)" class="inPlaceDisplay">
			<span></span>
			<span title="click to edit" class="inPlaceTip"></span>
		</span>
		<textarea rows="4" cols="30" name="<%=elementName%>" id="<%=path%>" class="inPlaceBehind <%=className%>" style="display: none;" ><%=fieldValue.trim()%></textarea>
	</span>
</div>