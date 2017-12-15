<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>
<%@page import="com.agencyport.webshared.IWebsharedConstants"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>

<!-- worklist/workItemAssign.jsp-->
<%
	Integer wiId= (Integer)request.getAttribute(IWebsharedConstants.WORKITEMID);
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);
 %>
<a class="close"><i class="fa"></i></a>		
<div >
	<span>
		<label><%=rb.getString("label.Assignee")%></label>
	</span>
	<span>
		<input id ="assignee" name ="assignee" type="text"></input>
		<input id ="<%=IWebsharedConstants.WORKITEMID %>" name ="<%=IWebsharedConstants.WORKITEMID %>" type="hidden" value="<%=wiId.intValue() %>"></input>
		<input id ="action" name ="action" type="hidden" value="DoAssign"></input>
		<ap:csrf/>
	</span>
</div>
<div  class ="workItemAssign_action">
	<span >
		<a id ="DoAssign"   name ="DoAssign" onmouseover="return true;" href="javascript:void(0);" title="<%=rb.getString("action.WorkItem.canAssign")%>"><%=rb.getString("action.WorkItem.canAssign")%></a>
	</span>
</div>