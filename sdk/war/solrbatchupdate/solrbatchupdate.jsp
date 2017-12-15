<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>

<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="java.util.Locale"%>
<%@page import="com.agencyport.locale.LocaleFactory"%>
<%@ taglib prefix="ap" uri="http://www.agencyportal.com/agencyportal" %>

<%
IResourceBundle solrRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.SOLR_BUNDLE, request);
IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE, request);
%>

<script type="text/javascript" language="javascript">
	var options = eval(<%= request.getAttribute("options") %>);
	angular.module('ap.common.constants').constant("metaData", options);
</script>

<ap:ap_rb_loader rbname="core_prompts" />

<section class="solr-admin-section">
	<div ng-app="ap.solrbatchupdater" ng-controller="ap.solrbatchupdater.SolrBatchUpdater as indexUpdater" class="container">
		<h1><%= solrRB.getString("header.Title.SolrSync") %></h1>

		<div id="error_messages" ng-show="indexUpdater.error"
			class="alert alert-error"><%=coreRB.getString("message.batch.error") %> {{indexUpdater.message}}</div>
		<div id="success_messages" ng-show="indexUpdater.success"
			class="alert alert-success"><%=coreRB.getString("message.batch.success") %></div>
	
		<table class="table" id="solr_admin_div">
			<thead>
				<tr>
					<th class="index"><%=solrRB.getString("label.indexer")%></th>
					<th class="action"><%=solrRB.getString("label.action")%></th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="index in indexUpdater.metaData.indexers">
					<td class="index">{{index}}</td>
					<td class="action">
						<a ng-href="" class="btn btn-primary" ng-click="indexUpdater.updateIndex(index);"><%=solrRB.getString("action.update")%></a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</section>

<jsp:include page="../home/footer.jsp" flush="true" />

