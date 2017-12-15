<!--  COMMENTS: iterate through comment entryies for every section -->
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils" %>
<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.utils.AppProperties"%>

<%
	IResourceBundle workItemRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.WORKITEM_ASSISTANT_BUNDLE);
	boolean supportsCollapse = AppProperties.getAppProperties().getTrueFalseBooleanProperty("workitemassistant.supportsCollapse", true);
%>
<div class="panel panel-default" ng-repeat="section in comments track by section.id">
	<% if (supportsCollapse) { %>
	<div class="panel-heading collapsed" data-toggle="collapse" href="#workItemAssistant_comments_section_{{section.id}}" aria-expanded="true" aria-controls="workItemAssistant_comments_section_{{section.id}}" style="cursor:pointer">
		<% } else { %>
		<div class="panel-heading">
	<% } %>
		<h4 class="panel-title">
			<span class="has-comments"><i class="fa"></i></span> {{section.label}}
		</h4>
	</div>
	<div class="panel-body wia-comments <% if (supportsCollapse) { %>collapse<% } %>" id="workItemAssistant_comments_section_{{section.id}}" >
		<div id="workItemAssistant_comments_container{{section.id}}" class="wia-container panel-fixed-height">
			<div id="workItemAssistant_comments_{{section.id}}" class="workitem-comment wia-content" ng-repeat="entry in section.entries track by entry.id">
				<dl>
					<dd class="comment">
						<a href="#" ng-click="deleteEntry(entry, section)">
							<span class="comment-delete"><i class="fa"></i></span>
						</a>				 					
						{{entry.comment}}
					</dd>
					<dd class="author">{{entry.enteredByName}}</dd>
					<dd class="meta-data">{{entry.timestamp}}</dd>
				</dl>
			</div>
		</div>
		<div class="workItemAssistant_comments_new_comment new-comment">
			<textarea class="form-control  comment-textarea" id="comments_text{{section.id}}" ng-model="commentInputs[section.id]"></textarea>
			<div class="wip-button">
				<span class="actions_group secondary">
					<input type="button" class="btn btn-info comments_button" id="comments_button{{section.id}}" class="comment" value="<%=workItemRB.getString("workitemAssistant.comments.button")%>" ng-disabled="commentsEmpty(section)" ng-click="addComment(section)" />
				</span>
			</div>
		</div>	
	</div>
</div>