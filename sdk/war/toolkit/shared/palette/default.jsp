<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<c:set var="path" value="${toolkitData.basePath}"/>
<div id="${path}_palette" style="" class="palette">
	<input type="hidden" name="${path}.@delete" id="${path}.@delete" value="" />
	<span class="noOptionsMessage">There are no options for the selected element.</span>
</div>