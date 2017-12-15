<%@ taglib prefix="tk" uri="http://www.agencyportal.com/agencyportal"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<tk:menuPill id="${param.productId}_${param.artifactType}_artifactPill">
	<tk:menuButton id="${param.productId}_${param.artifactType}_addbutton"
		title="Add ${param.artifactType}" text="Add"
		classname="primary addable addArtifact ${param.artifactType}" />
	<tk:menuButton
		id="${param.productId}_${param.artifactType}_importbutton"
		title="Import ${param.artifactType}" text="Import"
		classname="addable addArtifactFromXML" />
</tk:menuPill>

<c:if test="${(artifactCount > 0)}">
	<tk:menuPill id="${param.productId}_${param.artifactType}_exportExcelPill">
		<tk:menuButton
			id="${param.productId}_${param.artifactType}_exportExcelbutton"
			title="Export Rules to Excel" text="Export to Excel"
			classname="addable exportExcel" />
	</tk:menuPill>
</c:if>
