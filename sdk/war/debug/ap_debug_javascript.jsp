<%@ page import="com.agencyport.jsp.JSPHelper,com.agencyport.product.ProductDefinitionsManager"%>
<%
JSPHelper jspHelper = JSPHelper.get(request);
String versionNumber = ProductDefinitionsManager.getCurrentlyRunningVersion().toString();
%>
<html class="content">
	<head>
	<title>Debug Content</title>
	<style type="text/css" title="Debug Themeing">
		@import "ap_debug.css";	
	</style>
	<script type="text/javascript" src="ap_debug.js?<%=versionNumber%>"></script>
	<script type="text/javascript">
		var page = parent.page;
		var transaction = parent.transaction;
		var user = parent.user;
		var debugConsole = parent.debugConsole;
	</script>	
	</head>
	<body>
		<div class="content">
			<h2>Core AP JavaScript Objects</h2>

			<div class="detail">
				<h3>user</h3>
				<script type="text/javascript">
					var user_i = new Introspector(user);
					document.write(user_i.printAll());
				</script>
			</div>			
			
			<div class="detail">
				<h3>transaction</h3>
				<script type="text/javascript">
					var transaction_i = new Introspector(transaction);
					document.write(transaction_i.printAll());
				</script>
			</div>
			
			<div class="detail">
				<h3>page</h3>
				<script type="text/javascript">
					var page_i = new Introspector(page);
					document.write(page_i.printAll());
				</script>
			</div>	
		
			<hr />
			
			<h2>AP JavaScript Field Objects</h2>
			
			<p class="note">Field objects can be obtained for use in custom javascript using <span style="font-family: courier; font-weight: bold;">page.form.getFieldByName("Foo")</span> where foo is the name (ie XPath/Id) of your field. Available methods for the field object are listed below each object.</p>
			
			<div class="javascript_fields">
				<script type="text/javascript">
					var debug_fieldIntropectors = new Array();
				
					function showDetails(anchorId) {
						var a = document.getElementById(anchorId);
						var li = a.parentNode;
						var div = document.createElement('div');
						
						div.id = anchorId + "_div";
						a.href = "javascript:hideDetails("+anchorId+");void(0);"
						a.title = "hide details";
						div.innerHTML = debug_fieldIntropectors[anchorId].printAll();
						li.appendChild(div);
						
					}
					function hideDetails(anchorId) {
						var a = document.getElementById(anchorId);
						var li = a.parentNode;
						var div = document.getElementById(anchorId + "_div");
						
						a.href = "javascript:showDetails("+anchorId+");void(0);"
						a.title = "show details";
						li.removeChild(div);
					}
				
					document.write('<ul>');
					for (var ix=0; ix < page.form.fields.length; ix++) {
						debug_fieldIntropectors.push(new Introspector(page.form.fields[ix]));
						document.write("<li><a id=\"" + ix + "\" title='show details' href=\"javascript:showDetails(" + ix + ");void(0);\">" + page.form.fields[ix].name + "</a></li>");
					}
					document.write('</ul>');				
				</script>
			</div>
			
		</div>
	</body>
</html>
<!--begin debug\ap_debug_javascript.jsp -->