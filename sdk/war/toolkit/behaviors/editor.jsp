<%@ taglib prefix="tk" uri="http://www.agencyportal.com/toolkit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="${param.artifactId}" class="palette_toggle">
	<tk:accordionContainer  containerId="accordion_container">
 		<jsp:include page="editor/behaviorsHotfieldsTemplate.jsp">
	    	<jsp:param name="index" value="0"/>
	    	<jsp:param name="title" value="Additional Fields"/>
	    	<jsp:param name="basePath" value="additionalFieldToShred"/>
	    	<jsp:param name="className" value="additionalFieldToShred"/>
		</jsp:include>
		<jsp:include page="editor/behaviorsHotfieldsTemplate.jsp">
	    	<jsp:param name="index" value="0"/>
	    	<jsp:param name="title" value="Hotfields"/>
	    	<jsp:param name="basePath" value="hotField"/>
	    	<jsp:param name="className" value="hotfield"/>
		</jsp:include>
		<jsp:include page="editor/behaviorsHotfieldsTemplate.jsp">
	    	<jsp:param name="index" value="0"/>
	    	<jsp:param name="title" value="Behaviors"/>
	    	<jsp:param name="basePath" value="behavior"/>
	    	<jsp:param name="className" value="behavior"/>
		</jsp:include>
	</tk:accordionContainer>
</div>