<!-- FILE UPLOAD: paint all file attachments on the section -->

<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils" %>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.utils.AppProperties" %>
<%@page import="com.agencyport.webshared.IWebsharedConstants" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils" %>

<%
	IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKITEM_ASSISTANT_BUNDLE);
	IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);	
	int maxSize = AppProperties.getAppProperties().getIntProperty(IWebsharedConstants.MAX_FILE_ATTACHMENT_SIZE, 10240000);
	double limit = (double) maxSize / (double) 1024000;
	DecimalFormat format = new DecimalFormat();
	format.setMaximumFractionDigits(1);
	String formatedLimit = format.format(limit);
	String errorMessage = ResourceBundleStringUtils.makeSubstitutions(workItemRB.getString("workitemAssistant.fileattachment.max.size"), formatedLimit);
	String invalidFileMessage = workItemRB.getString("workitemAssistant.fileattachment.invalid.file");
%>

<div id="workitemAssistantUpload" class="file-uploader" ng-controller="workitemAssistantUploadCtrl" nv-file-drop="" uploader="uploader" filters="queueLimit" ng-show="fileattachments.length > 0">
	<h4><%=workItemRB.getString("workitemAssistant.upload.file") %></h4>
	<div id="wia_error_msg" class="alert alert-danger" style="display:none">
		<%=workItemRB.getString("workitemAssistant.upload.message") %>
	</div>
	<div id="wia_filesize_error_msg" class="alert alert-danger" style="display:none">
		<%=errorMessage %>
	</div>
	<div id="wia_filevalidation_error_msg" class="alert alert-danger" style="display: none">
		<%=invalidFileMessage %>
	</div>
	<div class="wip-button">
		<span class="btn btn-primary fileinput-button">
			<span><%= coreRB.getString("label.FileSelector.AddFile") %></span> 
			<input type="file" name="files[]" nv-file-select="" uploader="uploader" class="section_fileuploader" id="wia_upload_file"/>
		</span>
	</div>
		
	<div ng-show="uploader.showQueue()" class="upload-file-queue">
		<div class="file-drop-zone" nv-file-over="" uploader="uploader">
		
			<div class="file-drop-instructions">			
				<p><%=workItemRB.getString("workitemAssistant.dragDrop.message") %></p>
				<i class="fa"></i>
			</div>
		
			<div class="file-drop-indicator" ng-repeat="item in uploader.queue">
				<p class="file-name">{{ item.file.name }}</p>
				<div class="file-progress" ng-show="uploader.isHTML5">
					 <div class="progress">
						  <div class="progress-bar" role="progressbar" ng-style="{ 'width': item.progress + '%' }"></div>
					 </div>
				</div>
			</div>
		</div>
	</div>
	
	<p>
		<span class="requiredField">*</span>
		<%= workItemRB.getString("workitemAssistant.fileAttachments.documentType") %>
	</p>
	<select class="form-control" ng-model="fileTypeCode" id="fileTypeCode">
		<option ng-repeat="entry in filetypes" value="{{entry.value}}">{{entry.displayText}}</option>
	</select>
	<div class="wip-button">
		<button type="button" class="btn btn-primary" ng-click="uploader.sendAll()"><%= workItemRB.getString("workitemAssistant.action.upload") %></button>
		<button type="button" class="btn btn-default" ng-click="uploader.clearAll()"><%= workItemRB.getString("workitemAssistant.action.remove") %></button>
	</div>
</div>