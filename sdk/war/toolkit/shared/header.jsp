
<%
	String productId = request.getParameter("product");
	String artifactId = request.getParameter("artifactId");
	String title = request.getParameter("title");
	String description =  request.getParameter("description");
%>

<span id="<%=artifactId%>_title_wrapper">
	<span id="<%=artifactId%>_title" title="click to edit" class="inPlaceDisplay ">
		<span></span>
		<span title="click to edit" class="inPlaceTip">(click here to edit)</span>
	</span>	
	<input type="text" name="productDatabase.product[@id='<%=productId%>'].artifact[@id='<%=artifactId%>'].title" 
		id="productDatabase.product[@id='<%=productId%>'].artifact[@id='<%=artifactId%>'].title" class="inPlaceBehind" 
		size="50" style="display: none;" value="<%=title%>" />
</span>	
<!--
<span id="file_description">
	<span title="click to edit" class="inPlaceDisplay">
		<span></span>
		<span title="click to edit" class="inPlaceTip">(click here to edit)</span>
	</span>
	<input name="productDatabase.product[@id='<%=productId%>'].artifact[@id='<%=artifactId%>'].description"
		id="productDatabase.product[@id='<%=productId%>'].artifact[@id='<%=artifactId%>'].description" size="50" 
		class="inPlaceBehind" style="display: none;" value="<%=description%>" />
</span>
-->