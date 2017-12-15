<!-- FILE ATTACHMENTS: paint all file attachments on the section -->
<%@page import="com.agencyport.jsp.JSPHelper"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils" %>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.utils.AppProperties"%>


<% 	IResourceBundle rb = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE); 
	IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKITEM_ASSISTANT_BUNDLE);
	JSPHelper jspHelper = JSPHelper.get(request);
	boolean deletePermission = jspHelper.canDeleteWorkItemAssistantAttachedFile();
	boolean supportsCollapse = AppProperties.getAppProperties().getTrueFalseBooleanProperty("workitemassistant.supportsCollapse", true);
%>

<div class="panel panel-default">
	<div ng-repeat="section in fileattachments track by section.id">
	<% if (supportsCollapse) { %>
		<div class="panel-heading collapsed" data-toggle="collapse" href="#workItemAssistant_fileattachments_section" aria-expanded="true" aria-controls="workItemAssistant_fileattachments_section" style="cursor:pointer">
	<% } else { %>
		<div class="panel-heading">
	<% } %>
			<h4 class="panel-title">
				<span class="has-files"><i class="fa"></i></span> {{section.label}}
			</h4>
		</div>
		<div class="panel-body wia-file-attachments <% if (supportsCollapse) { %>collapse<% } %>" id="workItemAssistant_fileattachments_section">
			<div id="workItemAssistant_fileattachments_container" class="panel-fixed-height">
				<div id="workItemAssistant_fileattachments" class="workitem-file-attachment wia-content" ng-repeat="entry in section.entries track by entry.id">
					<div class="file_attachment_icon"></div>
					
					<dl>
						<dd class="file_attachment_name"> 
							<a href="#" ng-click="editEntry(entry, section)">
								<span class="upload-file-edit"><i class="fa"></i></span>
							</a>
							<% if(deletePermission){ %>
								<a href="#" ng-click="deleteEntry(entry, section)">
									<span class="upload-file-delete"><i class="fa"></i></span>
								</a>
							<%} %>
							<a href="{{entry.fileDisplayURL}}">{{entry.fileName}}</a> 
						</dd>
						<dd class="meta-data">{{entry.fileTypeDisplay}}, <span class="no-wrap">{{entry.fileSize}} kb</span></dd>
						<dd class="meta-data">{{entry.enteredByName}}</dd>
						<dd class="meta-data">{{entry.timestamp}}</dd>
					</dl>
				</div>

				<!-- upload -->
				<jsp:include page="upload.jsp" />
			</div>
		</div>
	</div>
</div>

