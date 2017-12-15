<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="toolkitData" class="com.agencyport.toolkit.data.ToolkitData" scope="request"/>
<div id="${param.artifactId}" class="focused_page_entity transaction_container palette_toggle">
	<h3 id="${param.artifactId}_transaction_title" class="transaction_title">${toolkitData.title}</h3>
	<div id="${param.artifactId}" class="palette_toggle">
		<tk:accordionContainer  containerId="accordion_container">
			<tk:accordions page="/toolkit/transactiondefinition/editor/page/page.jsp"></tk:accordions>
		</tk:accordionContainer>
	</div>
</div>