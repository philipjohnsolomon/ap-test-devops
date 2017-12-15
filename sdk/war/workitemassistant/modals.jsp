<!-- work item assistant resources -->
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils" %>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%
	IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKITEM_ASSISTANT_BUNDLE);
	IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
%>

<!-- document: enter/change file name -->
<script type="text/ng-template" id="fileNameModal.html">
	<div class="modal fade" id="file-name-document">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" ng-click="close()" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h2 class="modal-title"><%=workItemRB.getString("workitemAssistant.modal.fileName.header") %></h2>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="newfilename"><%=workItemRB.getString("workitemAssistant.modal.fileName.body") %></label>
						<input type="text" class="form-control" id="newfilename" auto-focus="true" ng-model="filename" placeholder="Enter file name" />
					</div> 
					
					<div class="button-row">
						<button type="button" ng-click="close('save')"  ng-keypress="enter($event, 'save')" class="btn btn-primary" data-dismiss="modal" ng-disabled="filenNameEmpty()"><%=workItemRB.getString("workitemAssistant.action.save") %></button>
						<button type="button" ng-click="close()" ng-keypress="enter($event)" class="btn btn-default" data-dismiss="modal"><%=workItemRB.getString("workitemAssistant.action.remove") %></button> 
					</div>
				</div>
			</div>
		</div>
	</div>
</script>

<!-- document: confirm deletion  -->
<script type="text/ng-template" id="deleteFileConfirmModal.html">
	<div class="modal fade" id="confirm-delete-document">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" ng-click="close()" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h2 class="modal-title"><%=workItemRB.getString("workitemAssistant.modal.fileDelete.header") %></h2>
				</div>
				<div class="modal-body">
					<p><%=workItemRB.getString("workitemAssistant.modal.fileDelete.body") %></p>
					<div class="button-row">
						<button type="button" ng-click="close('delete')" auto-focus="true" ng-keypress="enter($event, 'delete')" class="btn btn-primary" data-dismiss="modal"><%=workItemRB.getString("workitemAssistant.action.yes") %></button>
						<button type="button" ng-click="close()" ng-keypress="enter($event)" class="btn btn-default" data-dismiss="modal"><%=workItemRB.getString("workitemAssistant.action.no") %></button>
					</div>
				</div>
			</div>
		</div>
	</div>
</script>

<!-- document: confirm deletion  -->
<script type="text/ng-template" id="deleteCommentConfirmModal.html">
	<div class="modal fade" id="confirm-delete-document">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" ng-click="close()" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h2 class="modal-title"><%=workItemRB.getString("workitemAssistant.modal.commentDelete.header") %></h2>
				</div>
				<div class="modal-body">
					<p><%=workItemRB.getString("workitemAssistant.modal.commentDelete.body") %></p>
					<div class="button-row">
						<button type="button" ng-click="close('delete')"  auto-focus="true"  ng-keypress="enter($event, 'delete')" class="btn btn-primary" data-dismiss="modal"><%=workItemRB.getString("workitemAssistant.action.yes") %></button>
						<button type="button" ng-click="close()" ng-keypress="enter($event)" class="btn btn-default" data-dismiss="modal"><%=workItemRB.getString("workitemAssistant.action.no") %></button>
					</div>
				</div>
			</div>
		</div>
	</div>
</script>