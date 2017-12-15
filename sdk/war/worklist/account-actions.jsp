<!-- worklist/account-actions.jsp-->
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>
<%@page import="java.util.List"%>
<%@page import="com.agencyport.workitem.impl.WorkItemAction"%>
<%@page import="com.agencyport.worklist.WorkListHelper"%>
<%@page import="com.agencyport.workitem.impl.WorkItemOpenMode"%>
<%@page import="com.agencyport.webshared.IWebsharedConstants"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.utils.text.HtmlTransliterator"%>
<%@page import="com.agencyport.jsp.JSPHelper"%>


<%
		
	List<WorkItemAction> wiActions = (List<WorkItemAction>)request.getAttribute(WorkListHelper.WORK_ITEM_ACTIONS);
	
	Integer workItemId = (Integer)request.getAttribute(IWebsharedConstants.WORKITEMID);

	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKLIST_BUNDLE);

%>

		<%for(WorkItemAction action: wiActions ) {%>
					<span 	onmouseover="return true;" 
						href="javascript:void(0);" 
						title="<%=action.getLocalizedActionTitle() %>" 
						class="<%=action.getActionTitle()%>_action"
						id="eventWorkItemAction_<%=action.getActionTitle() %>" > <%=JSPHelper.prepareForHTML(action.getLocalizedActionTitle()) %>
						<input type="hidden" id="<%=IWebsharedConstants.WORKITEMID%>" value=<%=workItemId.intValue()%>>
						<input type="hidden" id="<%=WorkItemAction.ACTION%>" value="<%=action.getActionTitle()%>">
						<ap:csrf/>
					</span>
						
		<%} %>
			
		
				