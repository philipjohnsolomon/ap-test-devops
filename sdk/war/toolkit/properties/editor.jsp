<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>

<div id="properties_editor">
	<textarea id="properties_content" name="properties_content" rows="30" readonly="readonly">${toolkitData.fileContents}</textarea>	
</div>
