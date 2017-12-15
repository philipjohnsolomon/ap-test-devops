<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="${param.artifactId}" class="focused_page_entity transaction_container palette_toggle">
	<h3 id="${param.artifactId}_view_title" class="transaction_title">Views in this collection</h3>
	<tk:accordionContainer  containerId="accordion_container">
		<tk:accordions page="/toolkit/views/editor/view.jsp"></tk:accordions>
	</tk:accordionContainer>
</div>