<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${(param.artifactType=='propertyFile')}">
	<tk:menuPill id="${param.productId}_${param.artifactType}_artifactPill">
		<tk:menuButton
			id="${param.productId}_${param.artifactType}_importbutton"
			title="Import ${param.artifactType}" text="Import"
			classname="primary addable addArtifactFromXML" />
	</tk:menuPill>
</c:if>