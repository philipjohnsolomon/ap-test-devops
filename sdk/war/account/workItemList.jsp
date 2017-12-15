<%@ page import="java.util.List"%>
<%@page import="com.agencyport.paging.IHeader"%>
<%@page import="com.agencyport.paging.IRow"%>
<%@page import="com.agencyport.paging.worklist.IColumnMetaData"%>
<%@page import="com.agencyport.paging.worklist.IWorkListResults"%>
<%@page import="com.agencyport.worklist.WorkListHelper"%>
<%@page import="com.agencyport.paging.ICell"%>
<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.IResourceBundle"%>

<%
	IWorkListResults results = (IWorkListResults) request.getAttribute(WorkListHelper.IResults);
	List<IHeader> headers =  results.getHeader();
	List<IRow> rows = results.getRows();
	List<IColumnMetaData> columnMetaDataList = results.getResultColumnMetadata();
	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.ACCOUNT_MANAGEMENT_BUNDLE);
	int numberOfRows = rows.size();
%>

<%if(numberOfRows == 0) {%>
	<div id="move_work_list" class="move_workitem_container">	
	  <div class="no_workitem_warning"><%=rb.getString("account.actions.move.workitem.noworkitem")%></div>
	</div>
<%} %>
<%if(numberOfRows > 0) {%>
<div id="move_work_list" class="move_workitem_container">	
  	<div id="result_account_list" class="result_account_container result_workitem_container_height">
	<table  border="0" cellspacing="0" cellpadding="0" summary=" A work list" class="account_table">
		<thead>
			<tr>
			<% 
			for(IHeader header : headers) { 
				IColumnMetaData columnMetaData = WorkListHelper.getColumn(columnMetaDataList,header.getName());
				if ( ! columnMetaData.isColumnEnabled()) continue;%>
				<th>
					<div>											
						<%=columnMetaData.getColumnTitle()%>
					</div>
				</th>
			<% }%>
			</tr>
		</thead>
		<tbody id="lightboxSearchResults">
		<%
			String oddEvenClass;
			for(int rowIndex =0; rowIndex < numberOfRows; rowIndex ++) {
				IRow row = rows.get(rowIndex);
				oddEvenClass = (rowIndex % 2 == 0)? "rowodd" : "roweven";																
		%>
			<tr id="<%=row.getRowId().toString()%>" class="<%=oddEvenClass%>">
		<% 
				int index = 0;
				List<ICell> cells = row.getCellValues();									
				for(ICell cell: cells) {
					IHeader header = headers.get(index++);
					IColumnMetaData column = WorkListHelper.getColumn(columnMetaDataList,header.getName()); 
					if ( ! column.isColumnEnabled()) {  continue; }							
		%>
				<td> 
					<div style="text-align: left;">
				<%if(index == 1){%>
					<input class="account_workitems_checkbox" type="checkbox"
						value="<%=cell.getValue()%>" name="<%=cell.getValue()%>"> <%=JSPHelper.prepareForHTML(cell.getValue())%> </input>	
				<%}else{%>
					<%=JSPHelper.prepareForHTML(cell.getValue())%>
				<%} %>
					</div>
				</td>
			<%}%>
			</tr>
		<%}%>
		</tbody>
	</table>
	</div>
</div>
<%} %>	