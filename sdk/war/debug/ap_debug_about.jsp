<!--begin debug\ap_debug_javascript.jsp -->
<%@ page import="com.agencyport.runtime.APRuntime,
	com.agencyport.version.JarVersionInfo,
    com.agencyport.version.JarVersionManager,
    java.text.NumberFormat,
	java.util.Map,
	java.util.Map.Entry,
	java.util.Iterator,
	java.util.jar.Manifest,
	java.util.jar.Attributes,
	com.agencyport.jsp.JSPHelper" %>
<%
JSPHelper jspHelper = JSPHelper.get(request);
%>
<html class="content">
	<head>
	<title>Debug Content</title>
	<style type="text/css" title="Debug Themeing">
		@import "ap_debug.css";	
	</style>	
	</head>
	<body>
		<div class="content">
			<h2>Memory Utilization</h2>
			<%
				APRuntime runtime = new APRuntime(); 
				NumberFormat formatter = NumberFormat.getIntegerInstance();
				final long megaByteDivisor = 1024 * 1024; 
			%>		
			<div class="detail">
					<table class="about">
						<tr>
							<td class="property">Memory Used:</td>
							<td><%=formatter.format(runtime.getUsedMemory()/megaByteDivisor)%> MB</td>
						</tr>
						<tr>
							<td class="property">Available Memory:</td>
							<td><%=formatter.format(runtime.getAvailableMemory()/megaByteDivisor)%> MB</td>
						</tr>
						<tr>
							<td class="property">Maximum Heap Size:</td>
							<td><%=formatter.format(runtime.getMaxMemory()/megaByteDivisor)%> MB</td>
						</tr>
						<tr>
							<td class="property">Available Processors:</td>
							<td><%=runtime.getAvailableProcessors()%></td>
						</tr>
					</table>
			</div>
			<h2>Library Version Information</h2>		
			<%
			JarVersionManager jarVersionManager = JarVersionManager.getDefaultInstance();
			JarVersionInfo[] jarVersionInfos = jarVersionManager.getVersionInfo();
			final String unknown = "unknown";
			for ( int ix = 0; ix < jarVersionInfos.length; ix++){
				Package supportingPackage = jarVersionInfos[ix].getSupportingPackage();
				String jarPath = jarVersionInfos[ix].getJarPathName();
				if (jarPath == null )
					jarPath = unknown;
				%>
				<div class="detail">
					<h3><%=jarVersionInfos[ix].getJarFileName()%></h3>
					<h4>About this Jar</h4>
					<table class="about">
						<tr>
							<td class="property">Implementation Title</td>
							<td><%=supportingPackage.getImplementationTitle()%></td>
						</tr>
						<tr>
							<td class="property">Implementation Vendor</td>
							<td><%=supportingPackage.getImplementationVendor()%></td>
						</tr>
						<tr>
							<td class="property">Implementation Version:</td>
							<td><%=jarVersionInfos[ix].getImplementationVersion()%></td>
						</tr>
						<tr>
							<td class="property">Minimum Implementation Version:</td>	
							<td><%=jarVersionInfos[ix].getMinimumImplementationVersion()%></td>
						</tr>
					</table>
					<h4>Manifest Attributes</h4>
					<table class="about">
					<%
					Manifest jarManifest = jarVersionInfos[ix].getJarManifest();
					if ( jarManifest != null ) {
						Iterator it = jarManifest.getMainAttributes().entrySet().iterator();
						while (it.hasNext()){
							Map.Entry entry = (Map.Entry) it.next();
							%>
							<tr>
								<td class="property"><%=entry.getKey()%></td>
								<td><%=entry.getValue()%></td>
							</tr>
							<%
						}
					}
						%>				
					</table>
					<div class="disclaimer">Assumed path location: <%=jarPath%></div> 
					<div class="disclaimer">Information gathered using <%=jarVersionInfos[ix].getReferenceClassName()%> as a reference class.</div>
				</div>
				<%
			}
			%>		
		</div>
	</body>
</html>
<!--begin debug\ap_debug_javascript.jsp -->