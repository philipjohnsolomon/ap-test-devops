<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<div id="${param.artifactId}" class="palette_toggle">
	<tk:accordionContainer containerId="accordion_container">
		<tk:accordions page="/toolkit/xarcrule/editor/rule.jsp"></tk:accordions>
	</tk:accordionContainer>
</div>