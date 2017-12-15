<!-- worklist/workitem-actions.jsp-->
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
String endorseTransactionId = (String) request.getAttribute(IWebsharedConstants.TRANSACTION_TYPE_ENDORSE_TRANSACTION_ID);
IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
int secondaryActionsCnt = 0;
%>
			
<% for(WorkItemAction action: wiActions ) {
	
	if(action.isPrimaryAction()){ %>
	<span onmouseover="return true;" href="javascript:void(0);" title="<%=action.getLocalizedActionTitle() %>" class="work_list_action btn btn-default" id="eventWorkItemAction_<%=action.getActionTitle() %>"> 
		<span></span>
		<% String title = action.getLocalizedActionTitle(); %>
		<span><%=JSPHelper.prepareForHTML(title) %>
			<input type="hidden" id="<%=IWebsharedConstants.WORKITEMID%>" value=<%=workItemId.intValue()%>>
			<input type="hidden" id="<%=WorkItemAction.ACTION%>" value="<%=action.getActionTitle()%>">
			<input type="hidden" id="<%=IWebsharedConstants.TRANSACTION_TYPE_ENDORSE_TRANSACTION_ID%>" value="<%=endorseTransactionId%>"/>
			<ap:csrf/>
		</span>
	</span>
<% 	}else{
		secondaryActionsCnt++;
	}
}

	if(secondaryActionsCnt > 0){
	%>
	<div class="btn-group">
		<button id="work_item_actions_secondary" data-toggle="dropdown" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
			<%=rb.getString("action.OtherActions") %><span class="caret"></span>
		</button>
		<ul class="dropdown-menu other-actions" role="menu">
	<% 
		for(WorkItemAction action: wiActions ) {
			if(!action.isPrimaryAction()){
		%>
			<li class="work_item_actions-<%=action.getActionTitle()%>">
				<span onmouseover="return true;" href="javascript:void(0);" title="<%=action.getLocalizedActionTitle() %>" class="work_list_action" id="eventWorkItemAction_<%=action.getActionTitle() %>"> 
					<% String title = action.getLocalizedActionTitle(); %>
					<span><%=JSPHelper.prepareForHTML(title) %>
						<input type="hidden" id="<%=IWebsharedConstants.WORKITEMID%>" value=<%=workItemId.intValue()%>>
						<input type="hidden" id="<%=WorkItemAction.ACTION%>" value="<%=action.getActionTitle()%>">
						<input type="hidden" id="<%=IWebsharedConstants.TRANSACTION_TYPE_ENDORSE_TRANSACTION_ID%>" value="<%=endorseTransactionId%>"/>
						<ap:csrf/>
					</span>
				</span>
			</li>	
		<%
			}
		}
		%>
		</ul>
	</div>
	<%
	}
%>

				